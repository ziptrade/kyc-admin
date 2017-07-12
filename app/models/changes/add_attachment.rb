module Changes
  class AddAttachment < KycChangeRequest
    belongs_to :kyc_attachment

    def apply(docket)
      docket.add_attachment(attachment)
    end

    def self.create_with_file!(file)
      add_attachment = new_with_file(file)
      add_attachment.save!
      add_attachment
    end

    def self.new_with_file(file)
      new(kyc_attachment: KycAttachment.new(file: file))
    end
  end
end
