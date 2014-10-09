module ShortUrlSpecHelper
  def build_gateway
    services = {:backend => backend}
    ShortUrlGateway.new(services)
  end

  def build_backend
    MemoryRepository::ShortUrl.new
  end

  def build_dependency
    {
      :gateway => gateway,
      :short_url_authority => Authority::InMemory.new
    }
  end
end
