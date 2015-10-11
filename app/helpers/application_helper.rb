module ApplicationHelper

  def month_and_year(time)
    time.strftime("%B %Y")
  end

  def format_datetime(time)
    time.strftime("%B %d %Y")
  end

  def star_options
    [5, 4, 3, 2, 1].collect { |number| [pluralize(number, 'star'), number] }
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://robohash.org/#{gravatar_id}?gravatar=hashed&size=200x200&bgset=bg1"
  end
end
