require_relative '../marshal/short_url_marshal'
require_relative '../repository/memory'
require_relative '../gateway/short_url_gateway'
require_relative '../entities/short_url'


describe ShortUrlGateway do
  let(:gateway) { build_gateway }
  let(:backend) { build_backend }


  it 'saves a shortend url' do
    short_url = build_short_url('http://www.example.com')
    gateway.save(short_url)

    retrieved_short_url = gateway.find(short_url.key)
    expect(short_url.key).to eq(retrieved_short_url.key)
  end

  def build_gateway
    services = {:backend => backend}
    ShortUrlGateway.new(services)
  end

  def build_backend
    MemoryRepository::ShortUrl.new
  end

  def build_short_url(url)
    Entity::ShortUrl.new(url, '123')
  end
end
