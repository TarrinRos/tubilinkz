class AddProviderAndUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :url, :string
  end
end
