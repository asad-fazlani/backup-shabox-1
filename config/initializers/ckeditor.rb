# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
   
  Ckeditor.setup do |config|
    # //cdn.ckeditor.com/<version.number>/<distribution>/ckeditor.js
    config.cdn_url = "//cdn.ckeditor.com/4.6.1/full/ckeditor.js"
    config.js_config_url = 'ckeditor/config.js'
    config.image_file_types = %w(jpg jpeg png gif tiff)
  end

end
