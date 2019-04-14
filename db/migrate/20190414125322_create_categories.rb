class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end
end
