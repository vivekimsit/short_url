require_relative '../serializer/raw'
require 'uri'

module Entity
  class ShortUrl

    attr_accessor :id, :url, :url_key

    def initialize(url)
      @url = url
      @url_key = nil
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
      [:url, :id, :url_key]
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
