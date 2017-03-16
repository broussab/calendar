class AddSlackhandleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slackhandle, :string
    add_index :users, :slackhandle
  end
end
