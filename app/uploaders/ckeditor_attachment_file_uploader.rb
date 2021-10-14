#Do the changes in app/uploaders/ckeditor_attachment_file_uploader.rb
require 'carrierwave'

class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  # include Ckeditor::Backend::CarrierWave
  include Cloudinary::CarrierWave


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.attachment_file_types
  end
end
