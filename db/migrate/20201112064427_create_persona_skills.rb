class CreatePersonaSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :persona_skills do |t|
      t.integer :persona_id
      t.integer :skill_id
      t.integer :level
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
