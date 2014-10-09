# http://datamapper.org/getting-started.html
# http://blog.8thlight.com/mike-ebert/2013/03/23/the-repository-pattern.html
require_relative '../entities/short_url'
require 'data_mapper'

DB_PATH = 'sqlite://' + Dir.pwd + '/db/short_url.db'
DataMapper::Logger.new($stdout, :debug)
# An in-memory Sqlite3 connection:
# DataMapper.setup(:default, 'sqlite3::memory')
DataMapper.setup(:default, DB_PATH)

module DataMapperRepository
  class ShortUrl
    include DataMapper::Resource

    property :id,            Serial
    property :url,           Text
    property :url_key,       Text

    def model_class
      DataMapperRepository::ShortUrl
    end

    def save(entity)
      attrs = {
        :url => entity.url,
        :url_key => entity.key
      }
      model = model_class.create(attrs)
      entity.id = model.id
      return entity
    end

    def all
      res = []
      model_class.all.each do |value|
        short_url = Entity::ShortUrl.new(value.url)
        short_url.url_key = value.url_key
        short_url.id = value.id
        res << short_url
      end
      res
    end

    def find_by_id(id)
      model_class.first(:id => id.to_i)
    end
  end
end

DataMapper.finalize
# Automatically create the tables if they don't exist
DataMapper.auto_migrate!
