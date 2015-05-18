class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.string :category
      t.string :content

      t.timestamps null: false
    end
  end
end
