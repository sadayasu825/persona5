FactoryBot.define do
  factory :category, class: Category do
    name { '通常' }
  end

  trait :jewelry do
    name { '宝魔' }
  end

  trait :guillotine do
    name { '集団ギロチン' }
  end

  trait :dlc do
    name { 'DLC' }
  end
end
