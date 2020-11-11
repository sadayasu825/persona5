class PersonasController < ApplicationController
  def index
    @search_params = {
      name: params[:name].blank? ? nil : params[:name],
      arcana: params[:arcana].blank? ? nil : params[:arcana]
    }
    @personas = Persona.search(@search_params)
  end

  def show
  end
end
