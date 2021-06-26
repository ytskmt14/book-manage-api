class AddIsCancelledToBookLendings < ActiveRecord::Migration[6.1]
  def change
    add_column :book_lendings, :is_cancelled, :boolean
  end
end
