class ChangeFieldProject < ActiveRecord::Migration
  def change
    remove_column :html_pages, :project_id, :integer
    add_column :html_pages, :title,  :string
  end
end
