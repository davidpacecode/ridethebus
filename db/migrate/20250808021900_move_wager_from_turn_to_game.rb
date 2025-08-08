class MoveWagerFromTurnToGame < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :wager, :integer
    remove_column :turns, :wager, :integer
  end
end
