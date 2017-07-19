module Changes
  class AddAttachment < KycChangeRequest
    belongs_to :kyc_attachment

    def apply(docket)
      docket.add_attachment(kyc_attachment)
    end
  end
end
