
class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name
  def url_content
    url(:content) || begin
      if persisted?
        reload
        url(:content)
      end
    end
  end
end
