class CreatePersonas < ActiveRecord::Migration[6.0]
  def change
    create_table :personas do |t|
      t.string :name
      t.integer :arcana_id
      t.integer :category_id
      t.integer :initial_level
      t.integer :type
      t.timestamps
    end
  end
end
