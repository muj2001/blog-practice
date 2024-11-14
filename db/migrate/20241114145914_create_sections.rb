class CreateSections < ActiveRecord::Migration[7.2]
  def change
    create_table :sections do |t|
      t.string :title
      t.string :body
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
