class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.text :status
      t.datetime :start_time
      t.string :on_turn
      t.string :integer

      t.timestamps
    end
  end
end
