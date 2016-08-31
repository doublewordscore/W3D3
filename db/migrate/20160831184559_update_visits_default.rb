class UpdateVisitsDefault < ActiveRecord::Migration

  def change
    change_column_default(:visits, :num_visits, 1)
  end
end
