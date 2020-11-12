class Persona < ApplicationRecord
  belongs_to :arcana, primary_key: :number, foreign_key: :arcana_number
  belongs_to :category
  has_many :persona_skills
  has_many :skill, through: :persona_skills

  def self.search(params)
    query = self.select('personas.id AS persona_id, personas.name AS name, personas.initial_level AS initial_level, arcanas.name AS arcana_name, categories.name AS category_name')
                .joins(:arcana)
                .joins(:category)
    unless params[:name].blank?
      query = query.where('personas.name like ?', "%#{params[:name]}%")
    end
    unless params[:arcana].blank?
      query = query.where(arcana_number: params[:arcana])
    end
    unless params[:category].blank?
      query = query.where(category_id: params[:category])
    end
    if params[:sort] == 'level'
      query = query.order(initial_level: 'ASC')
    else
      query = query.order(arcana_number: 'ASC')
                   .order(initial_level: 'ASC')
    end
    query
  end

  def self.find_by_id(id)
    self.find(id)
  end

  def self.skills(persona_id)
    persona_skills_ary = PersonaSkill.where(persona_id: persona_id).pluck(:skill_id, :level)
    persona_skills = []
    persona_skills_ary.each do |e|
      persona_skills << { name: Skill.find(e[0]).name, level: e[1] }
    end
    persona_skills
  end
end
