class KycAttachment < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file, content_type: %w[image/jpg image/jpeg image/png image/gif]

  delegate :original_filename, to: :file
  delegate :content_type, to: :file
  delegate :url, to: :file

end
