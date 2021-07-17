class CreateClouds < ActiveRecord::Migration[5.2]
  def change
    create_table :clouds do |t|
      t.string :name
      t.string :vendor

      t.timestamps
    end
  end
end
