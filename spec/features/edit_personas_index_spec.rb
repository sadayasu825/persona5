require 'rails_helper'

RSpec.feature "ペルソナ編集画面テスト", type: :feature do
  background do
    User.create(
      name: 'dummy',
      email: 'dummy@example.com',
      password: 'dummypass',
      password_confirmation: 'dummypass'
    )
    FactoryBot.create(:arcana)
    FactoryBot.create(:arcana, :magician)
    FactoryBot.create(:category)
    FactoryBot.create(:category, :jewelry)
    FactoryBot.create(:persona)
    visit root_path
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
  end

  scenario 'ログインしているとサイドバーのリンクから編集画面に遷移できる' do
    find('a', text: 'ペルソナ情報編集').click
    expect(current_path).to eq(edit_personas_path)
  end

  scenario 'ログインしていない状態で編集画面に行こうとするとホーム画面にリダイレクトする' do
    page.accept_confirm do
      click_on 'ログアウト'
    end
    # ページ描画待ち用find処理
    find('h1', text: 'ようこそ')
    visit edit_personas_path
    expect(current_path).to eq(root_path)
  end

  scenario '画面遷移した時にペルソナ情報が表示されている' do
    find('a', text: 'ペルソナ情報編集').click
    expect(page.all('#persona-list').size).to eq(1)
    expect(page.first('.name-td > input')['value']).to eq('サンプル')
  end

  scenario '初期状態で「変更」ボタンが押せない' do
    find('a', text: 'ペルソナ情報編集').click
    expect(page.first('.submit-button')['disabled']).to eq('true')
  end

  scenario 'フォームに変化があると「変更」ボタンが押せるようになる' do
    find('a', text: 'ペルソナ情報編集').click
    select '魔術師', from: 'arcana_1'
    expect(page.first('.submit-button')['disabled']).to eq('false')
  end

  scenario 'ペルソナ名が変更できる' do
    find('a', text: 'ペルソナ情報編集').click
    fill_in "name_1",	with: "ニューネーム"
    # 「変更」ボタンのdisabledをはずすためのアクション
    find('#arcana_1').click
    find('#arcana_1').click
    click_on '変更'
    expect(page).to have_field('name_1', with: 'ニューネーム')
  end

  scenario 'アルカナが変更できる' do
    find('a', text: 'ペルソナ情報編集').click
    select '魔術師', from: 'arcana_1'
    click_on '変更'
    expect(page).to have_select('arcana_1', selected: '魔術師')
  end

  scenario '初期レベルが変更できる' do
    find('a', text: 'ペルソナ情報編集').click
    fill_in "initial_level_1",	with: "5"
    # 「変更」ボタンのdisabledをはずすためのアクション
    find('#arcana_1').click
    find('#arcana_1').click
    click_on '変更'
    expect(page).to have_field('initial_level_1', with: '5')
  end

  scenario '種別が変更できる' do
    find('a', text: 'ペルソナ情報編集').click
    select '宝魔', from: 'category_1'
    click_on '変更'
    expect(page).to have_select('category_1', selected: '宝魔')
  end

  scenario '変更時に「変更されました」のフラッシュメッセージが出る' do
    find('a', text: 'ペルソナ情報編集').click
    select '魔術師', from: 'arcana_1'
    click_on '変更'
    expect(page.first('#flash-message').text).to eq('変更されました')
  end
end
