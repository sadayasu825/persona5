class PersonasController < ApplicationController
  def index
    @search_params = {
      name: params[:name].blank? ? nil : params[:name],
      arcana: params[:arcana].blank? ? nil : params[:arcana],
      category: params[:category].blank? ? nil : params[:category],
      sort: params[:sort].blank? ? 'arcana' : params[:sort]
    }
    @personas = Persona.search(@search_params)
  end

  def show
    @persona = Persona.find_by_id(params[:id])
    @skills = Persona.skills(params[:id])
  end
end
