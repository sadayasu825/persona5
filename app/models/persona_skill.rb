class PersonaSkill < ApplicationRecord
  belongs_to :persona, optional: true
  belongs_to :skill, optional: true
end
