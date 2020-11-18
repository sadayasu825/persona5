class CreateArcanaCombination < ActiveRecord::Migration[6.0]
  def change
    create_table :arcana_combinations do |t|
      t.string :key_number
      t.integer :first_arcana_number
      t.integer :second_arcana_number
      t.integer :result_arcana_number
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
