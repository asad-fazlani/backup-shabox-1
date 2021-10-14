#Replace the picture uploader file app/uploaders/ckeditor_picture_uploader.rb
class CkeditorPictureUploader < CarrierWave::Uploader::Base
 include Cloudinary::CarrierWave
 CarrierWave.configure do |config|
   config.cache_storage = :file
 end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [118, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

end
