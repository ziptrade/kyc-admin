module Factories
  class AddAttachmentFactory < ChangeFactory
    def build_from(params)
      file = build_file(params)
      attrs = change_request_params(params).merge(kyc_attachment: KycAttachment.new(file: file))
      Changes::AddAttachment.create!(attrs)
    end

    private

    def attachment_params(params)
      params.require(:attachment).permit(:file_data, :file_name, :file_content_type)
    end

    def build_file(params)
      add_attachment_params = attachment_params(params)
      file_data = add_attachment_params.require(:file_data)
      file = Paperclip.io_adapters.for(file_data)
      file.original_filename = add_attachment_params.require(:file_name)
      file.content_type = add_attachment_params.require(:file_content_type)
      file
    end
  end
end
