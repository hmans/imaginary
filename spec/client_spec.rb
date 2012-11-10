require 'spec_helper'

describe Imaginary::Client do
  let :client do
    Imaginary::Client.new('http://imaginary.local/',
      bucket: 'some_bucket', username: 'zomg', password: 'yay', secret: 'abcdefg')
  end

  let :client_without_secret do
    Imaginary::Client.new('http://imaginary.local/',
      bucket: 'some_bucket', username: 'zomg', password: 'yay')
  end

  subject { client }

  describe '#image_url' do
    context 'when client is configured to use a secret' do
      subject { client.image_url('some_image') }
      it { should == 'http://imaginary.local/x/some_bucket/some_image-0bc24ea1f1ab4e6f' }
    end

    context "when client is configured to not use a secret" do
      subject { client_without_secret.image_url('some_image') }
      it { should == 'http://imaginary.local/x/some_bucket/some_image' }
    end
  end
end
