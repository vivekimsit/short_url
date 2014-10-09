require_relative '../serializer/raw'
require 'uri'

module Entity
  class ShortUrl

    attr_accessor :key, :url

    def initialize(url, key=nil)
      @url = url
      @key = key
    end

    def valid?
      if empty?
        return false
      end
      format?
    end

    def value
      Serializer::Raw.new(self).serialize
    end

    def attributes
      [:key, :url]
    end

    private

    def empty?
      String(url).length == 0
    end

    def format?
      !!URI.parse(url)
    rescue URI::InvalidURIError
      false
    end
  end
end
