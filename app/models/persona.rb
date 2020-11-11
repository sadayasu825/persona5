class Persona < ApplicationRecord
  belongs_to :arcana, primary_key: :number, foreign_key: :arcana_number
  belongs_to :category

  def self.search(params)
    query = self.select('*')
                .joins(:arcana)
                .joins(:category)
    unless params[:arcana].blank?
      query = query.where(arcana_number: params[:arcana])
    end
    unless params[:name].blank?
      query = query.where('personas.name like ?', "%#{params[:name]}%")
    end
    query
  end
end
