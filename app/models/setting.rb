# == Schema Information
#
# Table name: settings
#
#  id           :integer          not null, primary key
#  view_link    :string
#  last_updated :datetime
#

class Setting < ActiveRecord::Base
  validates_presence_of :view_link

  def self.data
    self.first || self.create!(
      view_link: 'http://example.com?q=%s',
      last_updated: 1.day.ago.to_datetime
    )
  end
end
