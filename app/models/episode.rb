# == Schema Information
#
# Table name: episodes
#
#  id             :integer          not null, primary key
#  season         :integer
#  episode_number :integer
#  title          :string
#  airdate        :date
#  show_id        :integer
#

class Episode < ActiveRecord::Base
  belongs_to :show
end
