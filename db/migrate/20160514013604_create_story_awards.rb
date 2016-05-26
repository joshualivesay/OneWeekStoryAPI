class CreateStoryAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :story_awards do |t|
      t.references :story, foreign_key: true
      t.references :award, foreign_key: true

      t.timestamps
    end
  end
end
