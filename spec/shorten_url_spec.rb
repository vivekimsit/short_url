require 'spec_helper'
require_relative '../repository/repository'
require_relative '../repository/memory'
require_relative '../interactors/shorten_url'
require_relative '../lib/short_url_authority'

describe ShortenUrl do
  include ShortUrlSpecHelper

  let(:url) { 'http://example.com' }
  let(:gateway) { build_gateway }
  let(:backend) { build_backend }
  let(:dependencies) { build_dependency }

  describe 'with a given url' do
    it 'provides a key' do
      expect(key_for(url)).to match(/[a-z0-9]+/)
    end

    it 'does not collide for a second url' do
      diff_url = url + '/path.html'
      expect(key_for(diff_url)).to_not eq(key_for(url))
    end

    it 'creates always the same key for the same url' do
      expect(key_for(url)).to eq(key_for(url))
    end
  end

  def key_for(url)
    shorten(url).key
  end

  def shorten(url)
    ShortenUrl.call(url, dependencies)
  end
end
