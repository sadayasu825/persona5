class PersonasController < ApplicationController
  def index
    @personas = Persona.all
  end

  def show
    # @persona = Persona.find()
  end
end
