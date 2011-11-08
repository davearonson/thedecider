class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :decisions, :user_id
  end
end
