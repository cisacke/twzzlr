class AddUserColumns < ActiveRecord::Migration
  def change
      add_column :images, :user_id, :integer
      remove_column :unwraps, :session
      add_column :unwraps, :user_id, :integer
  end
end
