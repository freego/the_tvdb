module TheTvdb
  class Show
    
    def self.search(name)
      TheTvdb.gateway.get_series(name)
    end

  end
end