class ChangeStoryUserToUserStory < ActiveRecord::Migration[5.1]
  def change
    rename_table :story_users, :user_stories
  end
end
