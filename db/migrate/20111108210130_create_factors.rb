class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :name
      t.references :decision

      t.timestamps
    end
    add_index :factors, :decision_id
  end
end
