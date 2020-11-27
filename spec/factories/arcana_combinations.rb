FactoryBot.define do
  factory :arcana_combination, class: ArcanaCombination do
    key_number { '00' }
    first_arcana_number { 0 }
    second_arcana_number { 0 }
    result_arcana_number { 0 }
  end

  trait :fool_magician do
    key_number { '01' }
    first_arcana_number { 0 }
    second_arcana_number { 1 }
    result_arcana_number { 13 }
  end

  trait :judgement_chariot do
    key_number { '720' }
    first_arcana_number { 7 }
    second_arcana_number { 20 }
    result_arcana_number { nil }
  end

  trait :judgement_justice do
    key_number { '820' }
    first_arcana_number { 8 }
    second_arcana_number { 20 }
    result_arcana_number { nil }
  end

  trait :judgement_strength do
    key_number { '1120' }
    first_arcana_number { 11 }
    second_arcana_number { 20 }
    result_arcana_number { nil }
  end

  trait :judgement_death do
    key_number { '1320' }
    first_arcana_number { 13 }
    second_arcana_number { 20 }
    result_arcana_number { nil }
  end
end
