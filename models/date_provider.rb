require 'date'

class DateProvider
  def expired_offer(expired_date)
    (expired_date - Date.today).negative?
  end
end
