# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Arcana.create(
  [
    { number: 0, name: '愚者' },
    { number: 1, name: '魔術師' },
    { number: 2, name: '女教皇' },
    { number: 3, name: '女帝' },
    { number: 4, name: '皇帝' },
    { number: 5, name: '法王' },
    { number: 6, name: '恋愛' },
    { number: 7, name: '戦車' },
    { number: 8, name: '力' },
    { number: 9, name: '隠者' },
    { number: 10, name: '運命' },
    { number: 11, name: '正義' },
    { number: 12, name: '刑死者' },
    { number: 13, name: '死神' },
    { number: 14, name: '節制' },
    { number: 15, name: '悪魔' },
    { number: 16, name: '塔' },
    { number: 17, name: '星' },
    { number: 18, name: '月' },
    { number: 19, name: '太陽' },
    { number: 20, name: '審判' },
    { number: 21, name: '世界' },
    { number: 22, name: '顧問官' },
    { number: 23, name: '信念' },
  ]
)

Category.create(
  [
    { name: '通常' },
    { name: '宝魔' },
    { name: '集団ギロチン' },
  ]
)
