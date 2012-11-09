require "imaginary-client/version"
require 'httmultiparty'

module Imaginary
  class Client
    include HTTMultiParty

    def initialize(url, user = nil, password = nil)
      @base_url = url
      @auth = { username: user, password: password }
    end

    def create_bucket(name)
      self.class.post("#{@base_url}/api/buckets", basic_auth: @auth, body: { bucket: {
        name: name
      }})
    end

    def add_image(bucket_id, data, name = nil)
      self.class.post("/api/buckets/#{bucket_id}/images", basic_auth: @auth, body: { image: {
        name: name,
        image: data
      }})
    end
  end
end
