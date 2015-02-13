module Source
  class EpisodesGateway
    require 'open-uri'
    require 'zip'

    BASE_URL = "http://thetvdb.com/api/"

    def initialize(api_key)
      @api_key = api_key
    end

    def episodes_for(show_id)
      Retryable.retryable(tries: 15, on: [OpenURI::HTTPError, TimeoutError]) do
        download_show_zip show_id
      end

      Hash.from_xml(xml_from_show_zip)
    end

    private

    def show_url(show_id)
      "#{BASE_URL}#{@api_key}/series/#{show_id}/all/en.zip"
    end

    def download_show_zip(show_id)
      remote_data = open(show_url(show_id)).read
      local_file = open("#{Rails.root}/show.zip", "wb")
      local_file.write(remote_data)
      local_file.close
    end

    def xml_from_show_zip
      Zip::File.open("#{Rails.root}/show.zip").read('en.xml')
    end

  end
end
