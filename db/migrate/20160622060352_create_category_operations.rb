class CreateCategoryOperations < ActiveRecord::Migration
  def change
    create_table :category_operations do |t|
      t.references :category, index: true, foreign_key: true
      t.references :operation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
