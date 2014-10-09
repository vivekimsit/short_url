require_relative '../repository/memory'
require_relative '../entities/short_url'
require_relative '../lib/interactor'
require_relative '../lib/short_url_authority'
require 'logger'
require 'pry'


class ResolveShortUrl < Interactor
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO

  attr_accessor :key

  def initialize(key, dependencies)
    @key = key
    @gateway = dependencies.fetch(:gateway)
  end

  def url
    resolved_url = get_url
    false if not resolved_url
    @@logger.info("Returning url: #{resolved_url}")
    resolved_url
  end

  private

  def get_url
    #binding.pry
    @gateway.all.each do |short_url|
      return short_url.url if short_url.key == key
    end
    @@logger.info("Key:#{key} does not exists")
    false
  end

end

