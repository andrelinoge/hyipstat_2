module ApplicationHelper
  def class_for_frist_only(css_class, index)
    css_class if index == 0
  end
end
