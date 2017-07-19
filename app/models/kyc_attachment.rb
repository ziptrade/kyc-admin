class KycAttachment < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file, content_type: %w[image/jpg image/jpeg image/png image/gif]

  delegate :file_name, :content_type, :url, to: :file
end
