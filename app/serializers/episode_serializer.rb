# == Schema Information
#
# Table name: episodes
#
#  id             :integer          not null, primary key
#  season         :integer
#  episode_number :integer
#  title          :string
#  airdate        :datetime
#  show_id        :integer
#

class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :season, :episode_number, :airdate
end
