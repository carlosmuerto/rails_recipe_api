class CreateUserFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :user_foods do |t|
      t.decimal :quantity
      t.references :user, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
