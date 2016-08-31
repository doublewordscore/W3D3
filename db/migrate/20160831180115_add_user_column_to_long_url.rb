class AddUserColumnToLongUrl < ActiveRecord::Migration
  def change

    add_column :shortened_urls, :user_id, :integer, :null => false, :default => 1
  end
end
