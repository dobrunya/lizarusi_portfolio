class CreateHtmlPages < ActiveRecord::Migration
  def change
    create_table :html_pages do |t|
      t.string :page

      t.timestamps null: false
    end
  end
end
