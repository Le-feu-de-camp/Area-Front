class AddGoogleRefreshTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :google_refresh_token, :string
  end
end