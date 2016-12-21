class AddCanvasToHtmlPage < ActiveRecord::Migration
  def change
    add_column :html_pages, :canvas, :text
  end
end
