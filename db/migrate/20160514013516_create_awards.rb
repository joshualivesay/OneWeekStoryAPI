class CreateAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :awards do |t|
      t.string :name
      t.string :description
      t.integer :points
      t.text :type

      t.timestamps
    end
  end
end
