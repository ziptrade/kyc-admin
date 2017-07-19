module Changes
  class AddAttachmentSerializer < Changes::KycChangeRequestSerializer
    has_one :kyc_attachment
  end
end
