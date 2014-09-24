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
    @repo = dependencies.fetch(:short_url_repo)
  end

  def url
    short_url = get_url
    if not short_url
      return false
    end
    key = short_url.url_key
    url = short_url.url
    @@logger.info("Returning: #{key}: #{url}")
    url
  end

  private

  def get_url
    #binding.pry
    @repo.all.each do |short_url|
      return short_url if short_url.url_key == key
    end
    @@logger.info("Key:#{key} does not exists")
    false
  end

end

