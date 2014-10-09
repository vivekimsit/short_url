require_relative '../marshal/short_url_marshal'

class ShortUrlGateway

  def initialize(services)
    @backend = services.fetch(:backend)
  end

  def save(short_url)
    persistable_short_url = dump(short_url)
    backend.save(persistable_short_url)
    short_url.key
  end

  def all
    res = []
    backend.all.each do |persisted_short_url|
      res << load(persisted_short_url)
    end
    res
  end

  def find(key)
    persisted_short_url = backend.find(key)
    load(persisted_short_url)
  end

  private

  def marshal
    ShortUrlMarshal.new
  end

  def dump(short_url)
    marshal.dump(short_url)
  end

  def load(dumped_short_url)
    marshal.load(dumped_short_url)
  end

  def backend
    @backend
  end
end
