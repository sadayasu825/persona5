require 'rails_helper'

RSpec.feature "ペルソナ一覧画面テスト", type: :feature do
  scenario 'ペルソナ一覧画面に遷移できる' do
    visit root_path
    find('a', text: 'ペルソナ一覧').click
    expect(current_path).to eq(personas_path)
  end

  scenario '画面遷移したときにペルソナが表示されている'
  scenario 'ペルソナ名で検索ができる'
  scenario 'アルカナで検索ができる'
  scenario '種別で検索ができる'
  scenario 'アルカナ順でソートできる'
  scenario '初期レベル順でソートができる'
end
