class RemoveDefaultValueFromLongUrl < ActiveRecord::Migration
  def change
    change_column_default(:shortened_urls, :user_id, nil)
  end
end
