require "imaginary-client/version"
require 'httmultiparty'

module Imaginary
  class Client
    include HTTMultiParty

    class << self
      def configure(url, user = nil, password = nil)
        base_uri url
        basic_auth user, password
      end

      def create_bucket(name)
        post('/api/buckets', body: { bucket: {
          name: name
        }})
      end

      def add_image(bucket_id, data, name = nil)
        post("/api/buckets/#{bucket_id}/images", body: { image: {
          name: name,
          image: data
        }})
      end
    end
  end
end
