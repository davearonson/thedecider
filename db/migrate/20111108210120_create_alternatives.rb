class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.string :name
      t.references :decision

      t.timestamps
    end
    add_index :alternatives, :decision_id
  end
end
