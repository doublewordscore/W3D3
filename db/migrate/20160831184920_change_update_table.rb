class ChangeUpdateTable < ActiveRecord::Migration
  def change
    change_column_default(:visits, :num_visits, 0)
  end
end
