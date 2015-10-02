class AddCategoryIdColumnToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :category_id, :integer
  end
end
