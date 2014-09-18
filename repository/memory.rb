require_relative '../entities/short_url'

module MemoryRepository
  class ShortUrl

    def initialize()
      @short_urls = {}
      @id = 0
    end

    def persist(short_url)
      @id += 1
      short_urls[@id] = short_url
      short_url.id = @id
      short_url
    end

    def all
      res = []
      short_urls.values.each do |short_url|
        res << short_url
      end
      res
    end

    def find_by_id(id)
      @short_urls[id.to_i]
    end

    private

    attr_reader :short_urls
  end
end
