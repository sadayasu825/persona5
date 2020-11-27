FactoryBot.define do
  factory :arcana, class: Arcana do
    number { 0 }
    name { '愚者' }
  end

  trait :magician do
    number { 1 }
    name { '魔術師' }
  end

  trait :chariot do
    number { 7 }
    name { '戦車' }
  end

  trait :justice do
    number { 8 }
    name { '正義' }
  end

  trait :strength do
    number { 11 }
    name { '剛毅' }
  end

  trait :death do
    number { 13 }
    name { '死神' }
  end

  trait :judgement do
    number { 20 }
    name { '審判' }
  end
end
