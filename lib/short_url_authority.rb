require 'monitor'

module Authority
  class InMemory

    def next_id
      synchronized do
        generate_next_id
      end
    end

    private

    def generate_next_id
      @counter ||= 100
      convert @counter += 1
    end

    def convert(numeric_id)
      numeric_id.to_s(36)
    end

    def synchronized(&sync)
      @lock ||= Monitor.new
      @lock.synchronize(&sync)
    end
  end
end
