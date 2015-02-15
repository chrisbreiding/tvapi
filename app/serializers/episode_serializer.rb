class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :season, :episode_number, :airdate
end
