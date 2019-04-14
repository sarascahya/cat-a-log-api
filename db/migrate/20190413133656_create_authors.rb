class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :biography
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end
end
