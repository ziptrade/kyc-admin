class KycAttachmentSerializer
  include JSONAPI::Serializer

  attribute :original_filename
  attribute :content_type
  attribute :url
end
