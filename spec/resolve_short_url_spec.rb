require_relative '../repository/repository'
require_relative '../repository/memory'
require_relative '../interactors/resolve_short_url'
require_relative '../interactors/shorten_url'
require_relative '../lib/short_url_authority'

describe ResolveShortUrl do
  let(:key) { '100' }

  describe 'with a given key' do
    before(:all) do
      @dependencies = {
        :short_url_repo  => MemoryRepository::ShortUrl.new
      }
      repo = @dependencies.fetch(:short_url_repo)
      short_url = Entity::ShortUrl.new('http://www.example.com')
      short_url.url_key = '100'
      repo.persist(short_url)
      short_url = Entity::ShortUrl.new('http://www.example.com/foo')
      short_url.url_key = '100123'
      repo.persist(short_url)
    end

    it 'provides an url' do
      expect(url_for(key)).to match(/[a-z0-9]+/)
    end

    it 'does not collide for a second url' do
      diff_key = key + '123'
      expect(url_for(diff_key)).to_not eq(url_for(key))
    end

    it 'gets always the same url for the same key' do
      expect(url_for(key)).to eq(url_for(key))
    end
  end

  def url_for(key)
    resolver(key).url
  end

  def resolver(key)
    ResolveShortUrl.call(key, @dependencies)
  end
end
