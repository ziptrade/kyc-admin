module Changes
  class AddAttachmentSerializer
    include JSONAPI::Serializer
    has_one :kyc_attachment
  end
end
