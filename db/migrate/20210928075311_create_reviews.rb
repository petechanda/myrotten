class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :potatoes
      t.text :comments
      t.references :user
      t.references :movie
    end
  end
end
