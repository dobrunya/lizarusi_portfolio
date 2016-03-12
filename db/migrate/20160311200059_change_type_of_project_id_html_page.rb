class ChangeTypeOfProjectIdHtmlPage < ActiveRecord::Migration
  def change
    remove_column :html_pages, :project_id
    add_column :html_pages, :project_id,  :integer
  end
end
