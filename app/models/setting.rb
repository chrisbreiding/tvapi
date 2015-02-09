# == Schema Information
#
# Table name: settings
#
#  id           :integer          not null, primary key
#  view_link    :string
#  last_updated :date
#

class Setting < ActiveRecord::Base

  def self.data
    self.first || self.new
  end

end
