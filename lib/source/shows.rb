require 'source/shows_gateway'
require 'source/shows_adapter'

module Source
  class Shows < AdapterBase

    def search(query)
      result = ShowsGateway.new.search(query)
      ShowsAdapter.new.shows(result)
    end

  end
end
