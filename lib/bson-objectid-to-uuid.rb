# frozen_string_literal: true

require 'bson/object_id/uuid_convertable/version'

require 'bson'
require 'bson/object_id/uuid_convertable'

BSON::ObjectId.prepend(BSON::ObjectId::UUIDConvertable)
