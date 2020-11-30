FactoryBot.define do
  factory :persona, class: Persona do
    name { 'サンプル' }
    arcana_number { 0 }
    category_id { 1 }
    initial_level { 1 }
    img_path { '/sample.png' }
    type { nil }
  end

  trait :magician_persona do
    name { '魔術師ペルソナ' }
    arcana_number { 1 }
  end

  trait :chariot_persona do
    name { '戦車ペルソナ' }
    arcana_number { 7 }
  end

  trait :justice_persona do
    name { '正義ペルソナ' }
    arcana_number { 8 }
  end

  trait :strength_persona do
    name { '剛毅ペルソナ' }
    arcana_number { 11 }
  end

  trait :death_persona do
    name { '死神ペルソナ' }
    arcana_number { 13 }
  end

  trait :judgement_persona do
    name { '審判ペルソナ' }
    arcana_number { 20 }
  end
end
