class CategoriesPosts < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_posts, id: false do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
    end
    add_index :categories_posts, [ :category_id, :post_id ], unique: true
  end
end
