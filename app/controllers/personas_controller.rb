class PersonasController < ApplicationController
  def index
    params[:arcana] = nil if params[:arcana].blank?
    @personas = Persona.search(params)
    # binding.pry
  end

  def show
    # @persona = Persona.find()
  end
end
