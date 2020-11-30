require 'rails_helper'

RSpec.feature "ログイン関連テスト", type: :feature do
  background do
    User.create(
      name: 'dummy',
      email: 'dummy@example.com',
      password: 'dummypass',
      password_confirmation: 'dummypass'
    )
    visit root_path
  end

  scenario 'ログインしていないとトップ画面に特定のメッセージが表示される' do
    expect(page.first('p').text).to eq('管理者としてログインすることで編集機能が使えます')
  end

  scenario 'ログインしていないとサイドバーに「ペルソナ情報編集」リンクが表示されない' do
    expect(page.all('.nav-link').size).to eq(2)
    expect(page.all('.nav-link')[0].text).to eq('ペルソナ一覧')
    expect(page.all('.nav-link')[1].text).to eq('合体結果シミュレーター')
  end

  scenario '「管理者ログイン」ボタンをクリックするとログイン画面に遷移する' do
    click_on '管理者ログイン'
    expect(current_path).to eq(login_path)
  end

  scenario 'ログイン画面で「ホーム画面に戻る」ボタンでホーム画面に遷移する' do
    click_on '管理者ログイン'
    click_on 'トップ画面に戻る'
    expect(current_path).to eq(root_path)
  end

  scenario '誤ったフォーム内容だとログインできない' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@dummy.com"
    fill_in "session_password",	with: "dummy"
    click_on 'ログイン'
    expect(current_path).to eq(login_path)
  end

  scenario 'フォーム内容に誤りがあるとflashメッセージが表示される' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@dummy.com" 
    fill_in "session_password",	with: "dummy" 
    click_on 'ログイン'
    expect(page.first('#flash-message').text).to eq('入力情報に誤りがあります')
  end

  scenario '適切なフォーム内容だとログインできる' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    expect(current_path).to eq(root_path)
  end

  scenario 'ログイン時に「ログインしました」のflashメッセージが表示される' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    expect(page.first('#flash-message').text).to eq('ログインしました')
  end

  scenario 'ログインしているとトップ画面に特定のメッセージが表示される' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    expect(page.all('p')[1].text).to eq('管理者としてログインしています')
  end

  scenario 'ログインしているとサイドバーに「ペルソナ情報編集」リンクが表示される' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    expect(page.all('.nav-link')[2].text).to eq('ペルソナ情報編集')
  end

  scenario 'ログイン状態から「ログアウト」ボタンをクリックすることでログアウトできる' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    page.accept_confirm do
      click_on 'ログアウト'
    end
    expect(page.all('p')[1].text).to eq('管理者としてログインすることで編集機能が使えます')
  end

  scenario 'ログアウト時に「ログアウトしました」のflashメッセージが表示される' do
    click_on '管理者ログイン'
    fill_in "session_email",	with: "dummy@example.com"
    fill_in "session_password",	with: "dummypass"
    click_on 'ログイン'
    page.accept_confirm do
      click_on 'ログアウト'
    end
    expect(page.first('#flash-message').text).to eq('ログアウトしました')
  end
end
