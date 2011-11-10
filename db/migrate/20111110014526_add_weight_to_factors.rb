class AddWeightToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :weight_id, :integer
  end
end
