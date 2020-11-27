FactoryBot.define do
  factory :skill, class: Skill do
    name { 'サンプルスキル' }
    description { 'スキル説明' }
  end

  trait :skill_2 do
    name { 'サンプルスキル2' }
    description { 'スキル説明2' }
  end
end
