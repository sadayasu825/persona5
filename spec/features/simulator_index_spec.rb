require 'rails_helper'

RSpec.feature "合体結果シミュレーター画面テスト", type: :feature do
  background do
    FactoryBot.create(:arcana)
    FactoryBot.create(:arcana, :magician)
    FactoryBot.create(:arcana, :death)
    FactoryBot.create(:arcana, :judgement)
    FactoryBot.create(:category)
    FactoryBot.create(:persona)
    FactoryBot.create(:persona, :magician_persona, initial_level: 3)
    FactoryBot.create(:persona, :death_persona, initial_level: 5)
    FactoryBot.create(:persona, :judgement_persona)
    FactoryBot.create(:arcana_combination, :fool_magician)
    FactoryBot.create(:arcana_combination, :judgement_death)
    visit root_path
    find('a', text: '合体結果シミュレーター').click
  end

  scenario '合体結果シミュレーター画面に遷移できる' do
    expect(current_path).to eq(simulator_index_path)
  end

  scenario 'アコーディオンメニューアイコンをクリックすると、説明欄が表示される' do
    expect(page).not_to have_selector 'p', text: '「P5R」における合体法則は以下のとおりです。'
    find('a', text: 'ペルソナ合体結果シミュレーターとは？').click
    # js描画待ち用find処理
    find('p', text: '「P5R」における合体法則は以下のとおりです。')
    expect(first('#exp-card-body')['style']).to eq('display: block; visibility: visible;')
  end

  scenario '二体のペルソナを選択して「合体」をクリックすると合体結果のペルソナが表示される' do
    select 'サンプル', from: 'first_persona'
    select '魔術師ペルソナ', from: 'second_persona'
    click_on '合体'
    find('a', text: '死神ペルソナ')
    expect(page.first('#result').text).to eq('死神ペルソナ')
  end

  scenario 'ペルソナを選択せずに「合体」をクリックするとアラートが出る' do
    click_on '合体'
    # [page.accept_confirm]にダイアログメッセージが代入されていて、呼び出した時点でokを押した扱いになっている？
    expect(page.accept_confirm).to eq('ペルソナを選択してください')
  end

  scenario '同じペルソナを選択して「合体」をクリックするとアラートが出る' do
    select 'サンプル', from: 'first_persona'
    select 'サンプル', from: 'second_persona'
    click_on '合体'
    expect(page.accept_confirm).to eq('同じペルソナは選べません')
  end

  scenario '合体結果ペルソナ名をクリックするとペルソナ詳細画面が別タブで開かれる' do
    select 'サンプル', from: 'first_persona'
    select '魔術師ペルソナ', from: 'second_persona'
    click_on '合体'
    find('#result').click
    windows = page.driver.browser.window_handles
    page.driver.browser.switch_to.window(windows.last)
    expect(current_path).to eq(persona_path(3))
  end

  scenario '合体不可な組み合わせのペルソナの合体結果は「合体不可」となる' do
    select '死神ペルソナ', from: 'first_persona'
    select '審判ペルソナ', from: 'second_persona'
    click_on '合体'
    find('h4', text: '合体不可')
    expect(page.first('#result').text).to eq('合体不可')
  end
end
