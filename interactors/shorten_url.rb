require_relative '../entities/short_url'
require_relative '../lib/interactor'
require_relative '../lib/short_url_authority'
require 'pry'
require 'logger'


class ShortenUrl < Interactor

  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO

  attr_accessor :url

  def initialize(url, dependencies)
    @@logger.info('Initializing short url interactor')
    @url = url
    @gateway = dependencies.fetch(:gateway)
    @short_url_authority = dependencies.fetch(:short_url_authority)
  end

  def key
    key = url_exists? || save_url
    @@logger.info('Returning key: ' + String(key))
    key
  end

  def save_url
    @@logger.info('Saving url: ' + String(url))
    short_url = Entity::ShortUrl.new(url)
    short_url.key = @short_url_authority.next_id
    if short_url.valid?
      @gateway.save(short_url)
    end
  end

  private

  def url_exists?
    #binding.pry
    @gateway.all.each do |short_url|
      return short_url.key if short_url.url == url
    end
    @@logger.info('Url not exists: ' + url)
    false
  end
end
