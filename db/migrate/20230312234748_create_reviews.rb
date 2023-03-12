class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews, id: false do |t|
      t.string :impression
      t.float :rate
      t.references :user, null: false, foreign_key: true
      t.references :book
      t.timestamps
    end
  end
end
