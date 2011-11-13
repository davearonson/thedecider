class AddWeightToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :weight_id, :integer
  end
end
