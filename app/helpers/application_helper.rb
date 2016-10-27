module ApplicationHelper
  def for_first_only(value, index, els_value = nil, compare_with = 0)
    if index == compare_with
      value
    else
      els_value
    end
  end
end
