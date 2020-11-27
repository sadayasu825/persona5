require 'rails_helper'

RSpec.feature "ペルソナ編集画面テスト", type: :feature do
  scenario 'ログインしているとサイドバーのリンクから編集画面に遷移できる'
  scenario 'ログインしていない状態で編集画面に行こうとするとホーム画面にリダイレクトする'
  scenairo '画面遷移した時にペルソナ情報が表示されている'
  scenario '初期状態で「変更」ボタンが押せない'
  scenario 'フォームに変化があると「変更」ボタンが押せるようになる'
  scenario 'ログインしていない状態で「変更」ボタンを押して変更しようとするとホーム画面にリダイレクトする'
  scenario 'ペルソナ名が変更できる'
  scenario 'アルカナが変更できる'
  scenario '初期レベルが変更できる'
  scenario '種別が変更できる'
  scenario '変更時に「変更されました」のフラッシュメッセージが出る'
end
