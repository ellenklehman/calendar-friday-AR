
class Event < ActiveRecord::Base

  def self.all_ordered
    self.where("start_date > '#{Date.today.to_s}'").order(:start_date)
  end

  def self.all_by_date(start_day = Date.today, end_day = Date.today)
    self.where("start_date >= '#{start_day.to_s}' AND
                end_date <= '#{end_day.to_s}'").order(:start_date)
  end

end
