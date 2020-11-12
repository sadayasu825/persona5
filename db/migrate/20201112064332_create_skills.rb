class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :type
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
