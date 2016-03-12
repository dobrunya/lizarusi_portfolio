class HtmlPage < ActiveRecord::Base
  mount_uploader :html, AttachmentUploader
  belongs_to :project, class_name: 'Project'

end
