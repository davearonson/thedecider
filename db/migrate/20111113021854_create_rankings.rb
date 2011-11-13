class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :alternative_id
      t.integer :factor_id
      t.timestamps
    end
    add_index :rankings, :alternative_id
    add_index :rankings, :factor_id
  end
end
