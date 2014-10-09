require 'spec_helper'
require_relative '../repository/repository'
require_relative '../repository/memory'
require_relative '../interactors/resolve_short_url'
require_relative '../interactors/shorten_url'
require_relative '../lib/short_url_authority'

describe ResolveShortUrl do
  include ShortUrlSpecHelper

  let(:gateway) { build_gateway }
  let(:backend) { build_backend }
  let(:dependencies) { build_dependency }

  describe 'with a given key' do
    it 'provides an url' do
      key = '100'
      build_short_url('http://www.example.com', key)
      expect(url_for(key)).to match(/[a-z0-9]+/)
    end

    it 'does not collide for a second url' do
      key = '100'
      build_short_url('http://www.example.com', key)
      diff_key = key + '123'
      expect(url_for(diff_key)).to_not eq(url_for(key))
    end

    it 'gets always the same url for the same key' do
      key = '100'
      build_short_url('http://www.example.com', key)
      build_short_url('http://www.example.com/foo', '100123')
      expect(url_for(key)).to eq(url_for(key))
    end

    def build_short_url(url, key)
      short_url = Entity::ShortUrl.new('http://www.example.com')
      short_url.key = key
      gateway.save(short_url)
    end
  end

  def url_for(key)
    resolver(key).url
  end

  def resolver(key)
    ResolveShortUrl.call(key, dependencies)
  end
end
