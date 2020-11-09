class Persona < ApplicationRecord
  def self.search(params)
    if params[:arcana].blank?
      Persona.all
    else
      Persona.where(arcana_number: params[:arcana])
    end
  end
end
