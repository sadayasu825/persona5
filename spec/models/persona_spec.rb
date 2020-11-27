require 'rails_helper'

RSpec.describe Persona, type: :model do
  before do
    FactoryBot.create(:arcana)
    FactoryBot.create(:category)
    FactoryBot.create(:persona)
    FactoryBot.create(:skill)
    FactoryBot.create(:persona_skill)
  end

  it 'ペルソナ名でlike検索ができる' do
    FactoryBot.create(:persona, name: 'ターゲット')
    search_params = { name: 'ゲット' }
    result = Persona.search(search_params)
    expect(result.length).to eq(1)
    expect(result.first.name).to eq('ターゲット')
  end

  it 'アルカナ番号で検索できる' do
    FactoryBot.create(:arcana, :magician)
    FactoryBot.create(:persona, name: 'サンプル2', arcana_number: 1)
    search_params = { arcana: 1 }
    result = Persona.search(search_params)
    expect(result.length).to eq(1)
    expect(result.first.name).to eq('サンプル2')
  end

  it 'カテゴリIDで検索できる' do
    FactoryBot.create(:category, :jewelry)
    FactoryBot.create(:persona, name: 'サンプル2', category_id: 2)
    search_params = { category: 2 }
    result = Persona.search(search_params)
    expect(result.length).to eq(1)
    expect(result.first.name).to eq('サンプル2')
  end

  it 'ペルソナIDから獲得スキル一覧を取得できる' do
    FactoryBot.create(:skill, :skill_2)
    FactoryBot.create(:persona_skill, skill_id: 2)
    result = Persona.skills(1)
    expect(result.length).to eq(2)
  end

  it '二体のペルソナの合体結果を取得できる' do
    FactoryBot.create(:persona)
    FactoryBot.create(:persona, name: 'リザルトペルソナ', initial_level: 2)
    FactoryBot.create(:arcana_combination)
    result = Persona.fusion(1, 2)
    expect(result.name).to eq('リザルトペルソナ')
  end

  it '「愚者」✕「愚者」は「愚者」を取得する' do
    # 合体元
    FactoryBot.create(:persona)
    # 合体後候補
    FactoryBot.create(:persona, initial_level: 2)
    FactoryBot.create(:arcana, :death)
    FactoryBot.create(:persona, :death_persona, initial_level: 2)
    FactoryBot.create(:arcana_combination)
    result = Persona.fusion(1, 2)
    expect(result.arcana_number).to eq(0)
  end

  it '「愚者」✕「魔術師」は「死神」を取得する' do
    # 合体元
    FactoryBot.create(:arcana, :magician)
    FactoryBot.create(:persona, :magician_persona)
    # 合体後候補
    FactoryBot.create(:persona, initial_level: 2)
    FactoryBot.create(:arcana, :death)
    FactoryBot.create(:persona, :death_persona, initial_level: 2)
    FactoryBot.create(:arcana_combination, :fool_magician)
    result = Persona.fusion(1, 2)
    expect(result.arcana_number).to eq(13)
  end

  it '合体結果のペルソナは仮レベル以上かつ最も初期レベルが低いものを取得する' do
    # 合体元
    FactoryBot.create(:persona)
    # 合体後候補
    FactoryBot.create(:persona, name: '低レベルペルソナ', initial_level: 2)
    FactoryBot.create(:persona, name: '高レベルペルソナ', initial_level: 3)
    FactoryBot.create(:arcana_combination)
    result = Persona.fusion(1, 2)
    expect(result.name).to eq('低レベルペルソナ')
  end

  it '「審判」✕「戦車」はfalseとなる' do
    FactoryBot.create(:arcana, :chariot)
    FactoryBot.create(:persona, :chariot_persona)
    FactoryBot.create(:arcana, :judgement)
    FactoryBot.create(:persona, :judgement_persona)
    FactoryBot.create(:arcana_combination, :judgement_chariot)
    result = Persona.fusion(2, 3)
    expect(result).to eq(false)
  end

  it '「審判」✕「正義」はfalseとなる' do
    FactoryBot.create(:arcana, :justice)
    FactoryBot.create(:persona, :justice_persona)
    FactoryBot.create(:arcana, :judgement)
    FactoryBot.create(:persona, :judgement_persona)
    FactoryBot.create(:arcana_combination, :judgement_justice)
    result = Persona.fusion(2, 3)
    expect(result).to eq(false)
  end

  it '「審判」✕「剛毅」はfalseとなる' do
    FactoryBot.create(:arcana, :strength)
    FactoryBot.create(:persona, :strength_persona)
    FactoryBot.create(:arcana, :judgement)
    FactoryBot.create(:persona, :judgement_persona)
    FactoryBot.create(:arcana_combination, :judgement_strength)
    result = Persona.fusion(2, 3)
    expect(result).to eq(false)
  end

  it '「審判」✕「死神」はfalseとなる' do
    FactoryBot.create(:arcana, :death)
    FactoryBot.create(:persona, :death_persona)
    FactoryBot.create(:arcana, :judgement)
    FactoryBot.create(:persona, :judgement_persona)
    FactoryBot.create(:arcana_combination, :judgement_death)
    result = Persona.fusion(2, 3)
    expect(result).to eq(false)
  end
end
