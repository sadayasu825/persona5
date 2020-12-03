module ApplicationHelper
  def arcana_for_select
    Arcana.all.pluck(:name, :number)
  end

  def category_for_select
    Category.all.pluck(:name, :id)
  end

  def persona_normals_for_select
    Persona.normals.pluck(:name, :id)
  end

  def form_box_class
    'form-box'
  end

  def aws_s3_path
    'https://rails-persona5.s3-ap-northeast-1.amazonaws.com'
  end
end
