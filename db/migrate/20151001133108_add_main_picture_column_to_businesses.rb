class AddMainPictureColumnToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :main_picture_url, :string
  end
end
