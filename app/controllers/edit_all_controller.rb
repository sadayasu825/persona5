class EditAllController < ApplicationController
  def index
    @personas = Persona.all
    @arcana_options = Arcana.all.pluck(:name, :number)
    @category_options = Category.all.pluck(:name, :id)
  end

  def update
    persona = Persona.find(params[:id])
    update_params = {
      name: params["name_#{params[:id]}"],
      arcana_number: params["arcana_#{params[:id]}"],
      initial_level: params["initial_level_#{params[:id]}"],
      category_id: params["category_#{params[:id]}"]
    }
    if persona.update(update_params)
      flash[:success] = '変更されました'
    else
      flash[:danger] = '変更に失敗しました'
    end
    redirect_to edit_all_index_path
  end
end
