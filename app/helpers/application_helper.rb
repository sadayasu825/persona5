module ApplicationHelper
  def arcana_for_select
    Arcana.all.pluck(:name, :number)
  end

  def category_for_select
    Category.all.pluck(:name, :id)
  end

  def form_box_class
    'form-box'
  end
end
