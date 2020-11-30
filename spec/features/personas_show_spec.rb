require 'rails_helper'

RSpec.feature "ペルソナ詳細画面テスト", type: :feature do
  background do
    FactoryBot.create(:arcana)
    FactoryBot.create(:category)
    FactoryBot.create(:skill)
    FactoryBot.create(:skill, :skill_2)
    FactoryBot.create(:persona_skill)
    FactoryBot.create(:persona_skill, skill_id: 2, level: 5)
    FactoryBot.create(:persona)
    visit root_path
    find('a', text: 'ペルソナ一覧').click
    find('a.persona-name', text: 'サンプル').click
    windows = page.driver.browser.window_handles
    page.driver.browser.switch_to.window(windows.last)
  end

  scenario 'ペルソナ一覧画面から詳細画面が別タブで開かれる' do
    expect(current_path).to eq(persona_path(1))
  end

  scenario 'ペルソナ名が表示されている' do
    expect(page.all('h4').first.text).to eq('(愚者) サンプル')
  end

  scenario 'ペルソナの習得スキルが表示されている' do
    expect(page.all('.skill-name').size).to eq(2)
  end
end
