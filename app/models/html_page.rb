class HtmlPage < ActiveRecord::Base
  mount_uploader :html, AttachmentUploader
  has_one :project
end
