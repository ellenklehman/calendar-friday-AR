require 'pry'
class Event < ActiveRecord::Base

  def self.all_ordered
    self.where("start_date > '#{Date.today.to_s}'").order(:start_date)
  end
end
