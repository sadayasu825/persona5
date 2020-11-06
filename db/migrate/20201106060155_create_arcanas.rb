class CreateArcanas < ActiveRecord::Migration[6.0]
  def change
    create_table :arcanas do |t|
      t.integer :number
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
