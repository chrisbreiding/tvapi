require 'source/shows_gateway'
require 'source/shows_adapter'

module Source
  class Shows < AdapterBase

    def search(query)
      result = ShowsGateway.new.search(query)
      ShowsAdapter.new.shows(result)
    end

    def updated_since(datetime)
      result = ShowsGateway.new.updated_since(datetime)
      ShowsAdapter.new.show_ids_and_time(result)
    end

  end
end
