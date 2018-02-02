# frozen_string_literal: true

module BSON::ObjectId::UUIDConvertable
  GREGORIAN_EPOCH_OFFSET = 0x01B2_1DD2_1381_4000 # Oct 15, 1582

  UUID_REGEX = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
  UUID_VERSION = 0x1000
  UUID_VARIANT = 0b1000_0000_0000_0000

  def to_uuid # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    timestamp = to_s[0..7].to_i(16) * 10_000_000 + GREGORIAN_EPOCH_OFFSET
    machine_pid = to_s[8..17].to_i(16)

    high_counter = to_s[18..19].to_i(16)
    mid_counter = to_s[20..21].to_i(16)
    low_counter = to_s[22..23].to_i(16)

    bytes = [
      (timestamp + low_counter) & 0xFFFF_FFFF,
      (timestamp >> 32) & 0xFFFF,
      ((timestamp >> 48) & 0x0FFF) | UUID_VERSION,
      mid_counter | UUID_VARIANT,
      (high_counter << 40) + machine_pid
    ]

    format('%06x-%04x-%04x-%04x-%012x', *bytes)
  end

  module ClassMethods
    def legal?(string)
      UUID_REGEX.match(string.to_s) ? true : super
    end

    def from_string(string)
      UUID_REGEX.match(string.to_s) ? from_uuid(string) : super
    end

    def from_uuid(string) # rubocop:disable Metrics/AbcSize
      parts = string.split('-')

      timestamp = parts[0].to_i(16) + (parts[1].to_i(16) << 32) + ((parts[2].to_i(16) & 0x0FFF) << 48)
      machine_pid = parts[4][2..-1]

      high_counter = parts[4][0..1]
      mid_counter = parts[3][2..3]
      low_counter = timestamp % 10_000_000

      seconds = (timestamp - GREGORIAN_EPOCH_OFFSET) / 10_000_000

      from_string(format('%06x', seconds) + machine_pid + high_counter + mid_counter + format('%02x', low_counter))
    end
  end

  def self.prepended(base)
    class << base
      prepend ClassMethods
    end
  end
end
