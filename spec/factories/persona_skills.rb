FactoryBot.define do
  factory :persona_skill, class: PersonaSkill do
    persona_id { 1 }
    skill_id { 1 }
    level { 0 }
  end
end
