class Skill < ApplicationRecord
  has_many :persona_skills
  has_many :persona, through: :persona_skills
end
