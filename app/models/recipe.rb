class Recipe < ApplicationRecord
  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%m/%d/%Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60    
    result = ""
    if hours > 0
      result += "#{hours} hours "
    end
    if minutes > 0
      result += "#{minutes} minutes"
    end
    result
  end
end
