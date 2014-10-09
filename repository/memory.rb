require_relative '../marshal/short_url_marshal'

module MemoryRepository
  class ShortUrl

    def initialize()
      @short_urls = {}
    end

    def save(short_url)
      uid = short_url[:uid]
      short_urls[uid] = short_url
      short_url
    end

    def all
      res = []
      short_urls.values.each do |short_url|
        res << short_url
      end
      res
    end

    def find(key)
      @short_urls[key]
    end

    private

    attr_reader :short_urls
  end
end
