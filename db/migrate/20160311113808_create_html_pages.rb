class CreateHtmlPages < ActiveRecord::Migration
  def change
    create_table :html_pages do |t|
      t.string :project_id
      t.string :html
      t.timestamps null: false
    end
  end
end
