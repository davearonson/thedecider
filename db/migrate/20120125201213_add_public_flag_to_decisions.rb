class AddPublicFlagToDecisions < ActiveRecord::Migration
  def change
    add_column :decisions, :public, :boolean
  end
end
