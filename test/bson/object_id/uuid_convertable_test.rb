# frozen_string_literal: true

require 'test_helper'
require 'simple_uuid'

class BSON::ObjectId::UUIDConvertableTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BSON::ObjectId::UUIDConvertable::VERSION
  end

  def test_it_converts_bson_object_id_into_a_valid_uuid_v4_variant_5
    object_id = BSON::ObjectId('5a74c31b0d6cabe30aa88fad')

    converted_uuid = object_id.to_uuid
    assert_equal(converted_uuid, '0bdaea5a-74c3-41b0-ad6c-abe30aa88fad')

    simple_uuid = SimpleUUID::UUID.new(converted_uuid)
    assert_equal(simple_uuid.version, 4)
    assert_equal(simple_uuid.variant, 5)
  end

  def test_it_converts_a_converted_uuid_v4_back_into_the_same_bson_object_id
    object_id = BSON::ObjectId('5a74c31b0d6cabe30aa88fad')

    converted_uuid = object_id.to_uuid
    reconverted_object_id = BSON::ObjectId.from_uuid(converted_uuid)
    assert_equal(reconverted_object_id, object_id)
  end

  def test_object_id_is_legal_for_a_uuid_string
    assert BSON::ObjectId.legal?('0bdaea5a-74c3-41b0-ad6c-abe30aa88fad')
  end

  def test_object_id_is_still_legal_for_a_object_id_string
    assert BSON::ObjectId.legal?('5a74c31b0d6cabe30aa88fad')
  end

  def test_obeject_id_from_string_converts_uuid_string_to_object_id
    object_id_from_uuid = BSON::ObjectId.from_string('0bdaea5a-74c3-41b0-ad6c-abe30aa88fad')

    assert_equal(object_id_from_uuid, BSON::ObjectId('5a74c31b0d6cabe30aa88fad'))
  end

  def test_obeject_id_from_string_still_converts_object_id_string_to_object_id
    object_id_from_uuid = BSON::ObjectId.from_string('5a74c31b0d6cabe30aa88fad')

    assert_equal(object_id_from_uuid, BSON::ObjectId('5a74c31b0d6cabe30aa88fad'))
  end
end
