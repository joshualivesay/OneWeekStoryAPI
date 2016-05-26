class StoriesRemoveIntegerChangeTypeOfOnTurn < ActiveRecord::Migration[5.1]
  def change
    remove_column :stories, :integer
    remove_column :stories, :on_turn
    add_column :stories, :on_turn, :integer
  end
end
