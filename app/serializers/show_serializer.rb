class ShowSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :search_name, :file_name, :source_id
end
