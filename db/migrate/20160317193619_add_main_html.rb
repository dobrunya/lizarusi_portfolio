class AddMainHtml < ActiveRecord::Migration
  def change
    add_column :html_pages, :main,  :boolean, default: false
  end
end
