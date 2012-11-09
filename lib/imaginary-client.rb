require "imaginary-client/version"
require 'httmultiparty'

module Imaginary
  class Client
    include HTTMultiParty

    def initialize(url, options = {})
      @base_url = url
      @auth = { username: options[:username], password: options[:password] }
      @bucket = options[:bucket]
    end

    def add_image_from_file(file, name = nil)
      self.class.post("#{@base_url}/api/buckets/#{@bucket}/images", basic_auth: @auth, body: { image: {
        name: name,
        image: file
      }})
    end

    def add_image_from_url(url, name = nil)
      self.class.post("#{@base_url}/api/buckets/#{@bucket}/images", basic_auth: @auth, body: { image: {
        name: name,
        image_url: url
      }})
    end
  end
end
