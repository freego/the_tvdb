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
  # @param [Integer] timestamp the last update timestamp (if not provided the last_updated attribute of the gateway is used instead)
  # @return [Hash] the new last_updated time and the Shows that have been updated
  def self.update(time = nil)
    update_hash = gateway.update(time)
    result = { time: update_hash['Time'].to_i }
    result[:shows] = update_hash['Series'].map {|show_remote_id| Show.find(show_remote_id) }
    gateway.last_updated = result[:time]
    result
  end

end
