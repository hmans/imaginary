require 'spec_helper'

describe Imaginary::Client do
  let :client do
    Imaginary::Client.new('http://imaginary.test.org/',
      bucket: 'some_bucket', username: 'some_user', password: '123secret', secret: 'abcdefg')
  end

  let :client_without_secret do
    Imaginary::Client.new('http://imaginary.test.org/',
      bucket: 'some_bucket', username: 'some_user', password: '123secret')
  end

  subject { client }

  describe '#add_image_from_url' do
    it "should add the image to the server and return its name" do
      FakeWeb.register_uri :post,
        "http://some_user:123secret@imaginary.test.org/buckets/some_bucket/images.json",
        body: '{"name": "kitten"}',
        content_type: 'application/json; charset=utf-8'

      client.add_image_from_url('http://placekitten.com/200/300', 'kitten').should == 'kitten'
    end
  end

  describe '#add_image_from_file' do
    it "should add the image to the server and return its name" do
      FakeWeb.register_uri :post,
        "http://some_user:123secret@imaginary.test.org/buckets/some_bucket/images.json",
        body: '{"name": "hmans"}',
        content_type: 'application/json; charset=utf-8'

      client.add_image_from_file(File.new('./spec/files/hmans.jpg'), 'hmans').should == 'hmans'
    end
  end

  describe '#image_url' do
    context 'when client is configured to use a secret' do
      subject { client.image_url('some_image') }
      it { should == 'http://imaginary.test.org/x/some_bucket/some_image-0bc24ea1f1ab4e6f' }
    end

    context "when client is configured to not use a secret" do
      subject { client_without_secret.image_url('some_image') }
      it { should == 'http://imaginary.test.org/x/some_bucket/some_image' }
    end
  end
end
