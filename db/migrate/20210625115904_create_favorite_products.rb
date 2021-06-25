class CreateFavoriteProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_products do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
