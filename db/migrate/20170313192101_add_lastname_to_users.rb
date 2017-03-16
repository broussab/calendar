class AddLastnameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lastname, :string
    add_index :users, :lastname
  end
end
