module ApplicationHelper

  def month_and_year(time)
    time.strftime("%B %Y")
  end

  def star_options
    [5, 4, 3, 2, 1].collect { |number| [pluralize(number, 'star'), number] }
  end
end
