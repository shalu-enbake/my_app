class AddFieldsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :title, :string
    add_column :books, :auther, :string
  end
end
