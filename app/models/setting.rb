# == Schema Information
#
# Table name: settings
#
#  id           :integer          not null, primary key
#  last_updated :datetime
#

class Setting < ActiveRecord::Base
  def self.data
    self.first || self.create!(last_updated: 1.day.ago.to_datetime)
  end
end
