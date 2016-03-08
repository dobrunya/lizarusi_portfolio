class HtmlPage < ActiveRecord::Base
  mount_uploader :page, HtmlUploader

end
