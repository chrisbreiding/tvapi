module Source
  class TimeAdapter

    def initialize(source_data)
      @source_data = source_data
    end

    def current_timestamp
      timestamp = @source_data['Items']['Time']
      DateTime.strptime(timestamp, '%s')
    end

  end
end
