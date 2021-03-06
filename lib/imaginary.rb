require "imaginary/version"
require 'httmultiparty'

module Imaginary
  class Client
    include HTTMultiParty

    def initialize(url, options = {})
      @base_url = url
      @auth = { username: options[:username], password: options[:password] }
      @bucket = options[:bucket]
      @secret = options[:secret]
      @cdn_base_url = options[:cdn_base_url]
    end

    def post(url, params)
      params[:basic_auth] ||= @auth
      self.class.post(url, params)
    end

    # Uploads an image from a file (IO) and returns the name assigned to
    # it by the Imaginary Server.
    #
    # Example:
    #
    #   client.add_image_from_file File.open('test.jpg')
    #
    def add_image_from_file(file, name = nil)
      r = post("#{@base_url}buckets/#{@bucket}/images.json", body: { image: {
        name: name,
        image: file
      }})

      if r["errors"]
        raise "Failed. #{r["errors"]}"
      else
        r["name"]
      end
    end

    def add_image_from_url(url, name = nil)
      r = post("#{@base_url}buckets/#{@bucket}/images.json", body: { image: {
        name: name,
        image_url: url
      }})

      if r["errors"]
        raise "Failed. #{r["errors"]}"
      else
        r["name"]
      end
    end

    def image_url(name, options = nil)
      parts = ['x', @bucket]

      unless options.nil?
        if options.is_a?(String)
          parts << options
        elsif options.is_a?(Array)
          parts += options
        elsif options.is_a?(Hash)
          parts += options.to_a
        else
          raise "Invalid options."
        end
      end

      # add image name
      parts << name

      # build path
      path = parts.join('/')

      # add signature
      if @secret
        signature_string = [path, @secret].join('/')
        signature = Digest::SHA1.hexdigest(signature_string)[0..15]
        path << "-#{signature}"
      end

      (@cdn_base_url || @base_url) + path
    end
  end
end
