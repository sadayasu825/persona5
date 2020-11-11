class PersonasController < ApplicationController
  def index
    @search_params = {
      name: params[:name].blank? ? nil : params[:name],
      arcana: params[:arcana].blank? ? nil : params[:arcana],
      category: params[:category].blank? ? nil : params[:category]
    }
    @personas = Persona.search(@search_params)
  end

  def show
    @persona = Persona.persona_find_by_id(params[:id])
  end
end
