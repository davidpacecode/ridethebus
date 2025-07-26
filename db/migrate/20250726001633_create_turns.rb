class CreateTurns < ActiveRecord::Migration[8.0]
  def change
    create_table :turns do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :turn_number
      t.integer :wager
      t.string :bet_type
      t.string :result
      t.string :card

      t.timestamps
    end
  end
end
