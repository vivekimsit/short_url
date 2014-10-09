require_relative '../entities/short_url'

class ShortUrlMarshal
  def dump(short_url)
    {
      :uid => short_url.key,
      :url => short_url.url
    }
  end

  def load(dumped_short_url)
    uid = dumped_short_url[:uid]
    url = dumped_short_url[:url]
    Entity::ShortUrl.new(url, uid)
  end
end
