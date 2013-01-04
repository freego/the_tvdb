require "the_tvdb/version"
require "the_tvdb/gateway"
require "the_tvdb/configuration"
require "the_tvdb/show"
require "the_tvdb/episode"

module TheTvdb
  
  def self.setup
    yield self.configuration
  end
  
  def self.configuration
    @config ||= Configuration.instance
  end

  def self.gateway
    @gateway ||= Gateway.instance
  end
  
  # Starting from the last update recorded on the gateway, a hash with the new
  # update time and the updated shows are returned
  #
  # @param [Integer] timestamp the last update timestamp (if not provided the last_updated attribute of Gateway is used instead)
  # @param [Boolean] full_data if set to true will return full Show and Episode objects, not just the ids (defaults to false)
  # @return [Hash] the new last_updated time and the Shows that have been updated or their ids
  def self.update(timestamp=nil, full_data=false)
    update_hash = gateway.update(timestamp)
    result = { time: update_hash['Time'].to_i }
    result[:shows] = []
    if update_hash['Series']
      if full_data
        result[:shows] = update_hash['Series'].map {|show_remote_id| Show.find(show_remote_id) }
      else
        result[:shows] = update_hash['Series'].map {|show_remote_id| show_remote_id.to_i }
      end
    end
    gateway.last_updated = result[:time]
    p result
    result
  end

end

class String
  def to_tvdb_array
    gsub(/^\|/, '').split('|')
  end
end
