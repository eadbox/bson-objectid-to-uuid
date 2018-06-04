# frozen_string_literal: true

module BSON::ObjectId::UUIDConvertable
  UUID_PREFIX = '0bdaea'
  UUID_REGEX = /\A0bdaea[0-9a-f]{2}-[0-9a-f]{4}-4[0-9a-f]{3}-[ab][0-9a-f]{3}-[0-9a-f]{12}\z/i
  UUID_VERSION = '4'
  UUID_VARIANT = 'a'

  def to_uuid
    [
      UUID_PREFIX + to_s[0..1],   # 6 digit prefix + first 2 oid digits
      to_s[2..5],                 # next 4 oid digits
      UUID_VERSION + to_s[6..8],  # 1 digit version(0x4) + next 3 oid digits
      UUID_VARIANT + to_s[9..11], # 1 digit variant(0b101) + 1 zero bit + next 3 oid digits
      to_s[12..23]                # last 12 oid digits
    ].join('-')
  end

  module ClassMethods
    def legal?(string)
      UUID_REGEX.match?(string.to_s) ? true : super
    end

    def from_string(string)
      UUID_REGEX.match?(string.to_s) ? from_uuid(string) : super
    end

    def from_uuid(string)
      from_string(string[6..7] + string[9..12] + string[15..17] + string[20..22] + string[24..35])
    end
  end

  def self.prepended(base)
    class << base
      prepend ClassMethods
    end
  end
end
