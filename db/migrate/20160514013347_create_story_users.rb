class CreateStoryUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :story_users do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true
      t.boolean :owner
      t.integer :order

      t.timestamps
    end
  end
end
