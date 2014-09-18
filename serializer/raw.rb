module Serializer
  class Raw
    def initialize(entity)
      @entity = entity
    end

    def serialize
      attributes = @entity.attributes
      if attributes.is_a? Hash
        attributes
      else
        create_attribute_hash attributes
      end
    end

    private

    attr_reader :entity

    def create_attribute_hash(attributes)
      attributes.inject({}) do |res, value|
        res[value] = entity.public_send(value)
        res
      end
    end
  end
end
