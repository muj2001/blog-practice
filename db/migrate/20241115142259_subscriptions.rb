class Subscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions, id: false do |t|
      t.references :subscriber, foreign_key: { to_table: :users }, null: false
      t.references :user, null: false
    end
  end
end
