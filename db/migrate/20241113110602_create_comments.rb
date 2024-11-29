class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
