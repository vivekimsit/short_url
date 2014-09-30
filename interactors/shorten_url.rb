require_relative '../repository/memory'
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
    @repo = dependencies.fetch(:short_url_repo)
    @short_url_authority = dependencies.fetch(:short_url_authority)
  end

  def key
    short_url = url_exists? || save_url
    @@logger.info('Returning key: ' + String(short_url[:url_key]))
    short_url[:url_key]
  end

  def save_url
    @@logger.info('Saving url: ' + String(url))
    short_url = Entity::ShortUrl.new(url)
    short_url.url_key = @short_url_authority.next_id
    if short_url.valid?
      @repo.persist(short_url).value
    end
  end

  private

  def url_exists?
    #binding.pry
    @repo.all.each do |short_url|
      return short_url.value if short_url.url == url
    end
    @@logger.info('Url not exists: ' + url)
    false
  end
end
