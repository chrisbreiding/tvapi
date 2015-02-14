module Source
  class TimeAdapter

    def current_timestamp(source_data)
      timestamp = source_data['Items']['Time']
      DateTime.strptime(timestamp, '%s')
    end

  end
end
