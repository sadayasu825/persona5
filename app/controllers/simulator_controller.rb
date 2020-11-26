class SimulatorController < ApplicationController
  def index
    @search_params = {
      first_persona: params[:first_persona].blank? ? nil : params[:first_persona],
      second_persona: params[:second_persona].blank? ? nil : params[:second_persona]
    }
    unless params[:first_persona].blank? || params[:second_persona].blank?
      @res_persona = Persona.fusion(params[:first_persona].to_i, params[:second_persona].to_i)
    else
      @res_persona = false
    end
    respond_to do |format|
      format.json { render json: @res_persona }
      format.html
    end
  end
end
