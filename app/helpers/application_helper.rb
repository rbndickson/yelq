module ApplicationHelper

  def month_and_year(time)
    time.strftime("%B %Y")
  end

end
