class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.references :game, null: false, foreign_key: true
      t.string :label
      t.integer :value
      t.string :suit
      t.string :filename
      t.boolean :drawn

      t.timestamps
    end
  end
end
