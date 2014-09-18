require_relative '../../interactors/shorten_url'
require_relative '../../repository/repository'
require_relative '../../repository/memory'
require_relative '../../repository/dm'
require_relative '../../lib/short_url_authority'
require 'json'
require 'sinatra'

#set :repo, Repository.register(:short_url, MemoryRepository::ShortUrl.new)
configure do
  Repository.register(:short_url, DataMapperRepository::ShortUrl.new)
end

set :dependencies, {
  :short_url_repo  => Repository.for(:short_url),
  :short_url_authority => Authority::InMemory.new
}

before do
  request.body.rewind
  @request_payload = JSON.parse request.body.read rescue {}
end

get '/' do
  erb :'layout'
end

post '/api/shorten' do
  dependencies = settings.dependencies
  url = @request_payload['url']
  JSON.dump({
    :message => :Success,
    :key => ShortenUrl.new(url, dependencies).key
  })
end
