class AddCurrentTurnToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :current_turn, :integer
  end
end
