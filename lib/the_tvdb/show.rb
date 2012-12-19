module TheTvdb
  class Show
    
    def self.search(name)
      result = TheTvdb.gateway.get_series(name)
      #open_xml "#{endpoint}/GetSeries.php?seriesname=#{URI.escape(name)}"
      puts result.to_yaml
      result
    end

  end
end