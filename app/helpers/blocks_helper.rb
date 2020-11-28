module BlocksHelper
  def format_date(utc)
    Time.zone.at(utc).strftime("%F %T")
  end
end
