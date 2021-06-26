class CreateBookLendings < ActiveRecord::Migration[6.1]
  def change
    create_table :book_lendings do |t|
      t.references :book, null: false, foreign_key: true
      t.date :start_dt
      t.date :end_dt
      t.boolean :returned_flg

      t.timestamps
    end
  end
end
