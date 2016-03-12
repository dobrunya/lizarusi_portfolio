class Project < ActiveRecord::Base
  before_destroy :delete_project
  has_many :html_pages, dependent: :destroy, foreign_key: :title, class_name: 'HtmlPage', primary_key: :title
  accepts_nested_attributes_for :html_pages
  validates :title, uniqueness: true

  private
    def delete_project
      path = 'public/projects/'
      path += title
      FileUtils.rm_rf(path)
    end
end
