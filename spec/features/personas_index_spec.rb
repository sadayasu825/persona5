require 'rails_helper'

RSpec.feature "ペルソナ一覧画面テスト", type: :feature do
  background do
    FactoryBot.create(:arcana)
    FactoryBot.create(:arcana, :magician)
    FactoryBot.create(:category)
    FactoryBot.create(:category, :jewelry)
    FactoryBot.create(:persona, initial_level: 10)
    FactoryBot.create(:persona, :magician_persona, category_id: 2)
    visit root_path
    find('a', text: 'ペルソナ一覧').click
  end

  scenario 'ペルソナ一覧画面に遷移できる' do
    expect(current_path).to eq(personas_path)
  end

  scenario '画面遷移したときにペルソナが表示されている' do
    expect(page.all('#result > tr').size).to eq(2)
  end

  scenario 'ペルソナ名でlike検索ができる' do
    fill_in 'name',	with: '魔術師'
    click_on '検索'
    # js描画待ち用find処理
    find('.persona-name', text: '魔術師ペルソナ')
    expect(page.all('#result > tr').size).to eq(1)
    expect(page.all('.persona-name').first.text).to eq('魔術師ペルソナ')
  end

  scenario 'アルカナで検索ができる' do
    select '魔術師', from: 'arcana'
    click_on '検索'
    # js描画待ち用find処理
    find('.persona-name', text: '魔術師ペルソナ')
    expect(page.all('#result > tr').size).to eq(1)
    expect(page.all('.persona-name').first.text).to eq('魔術師ペルソナ')
  end

  scenario '種別で検索ができる' do
    select '宝魔', from: 'category'
    click_on '検索'
    # js描画待ち用find処理
    find('.persona-name', text: '魔術師ペルソナ')
    expect(page.all('#result > tr').size).to eq(1)
    expect(page.all('.persona-name').first.text).to eq('魔術師ペルソナ')
  end

  scenario 'デフォルトのソートはアルカナ順である' do
    expect(page).to have_checked_field('アルカナ')
    displayed_personas = page.all('.persona-name')
    expect(displayed_personas[0].text).to eq('サンプル')
    expect(displayed_personas[1].text).to eq('魔術師ペルソナ')
  end

  scenario '初期レベル順でソートができる' do
    choose '初期レベル'
    click_on '検索'
    # js描画待ち用find処理
    find('.persona-name', text: 'サンプル')
    before_displayed_personas = page.all('.persona-name')
    expect(before_displayed_personas[0].text).to eq('魔術師ペルソナ')
    expect(before_displayed_personas[1].text).to eq('サンプル')
  end

  scenario 'アルカナ順でソートできる' do
    choose '初期レベル'
    click_on '検索'
    # js描画待ち用find処理
    find('.persona-name', text: 'サンプル')
    before_displayed_personas = page.all('.persona-name')
    expect(before_displayed_personas[0].text).to eq('魔術師ペルソナ')
    expect(before_displayed_personas[1].text).to eq('サンプル')
    choose 'アルカナ'
    click_on '検索'
    find('.persona-name', text: 'サンプル')
    after_displayed_personas = page.all('.persona-name')
    expect(after_displayed_personas[0].text).to eq('サンプル')
    expect(after_displayed_personas[1].text).to eq('魔術師ペルソナ')
  end
end
