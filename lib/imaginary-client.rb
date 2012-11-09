require "imaginary-client/version"
require "active_resource"

module Imaginary
  module Client
    class Base < ActiveResource::Base
      self.site = 'http://imaginary-mans.herokuapp.com/api/'
      self.user = 'zomg'
      self.password = 'zomg'
    end

    class Bucket < Base
      def images(scope = :all)
        Image.find(scope, params: { bucket_id: self.id })
      end

      def image(id)
        images(id)
      end
    end

    class Image < Base
      self.site = 'http://imaginary-mans.herokuapp.com/api/buckets/:bucket_id'

      def bucket
        Bucket.find(self.prefix_options[:bucket_id])
      end

      def bucket=(bucket)
        self.prefix_options[:bucket_id] = bucket.id
      end
    end
  end
end
