class AddFieldsToBooksForPdf < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :attachment, :string
  end
end
