# frozen_string_literal: true

describe OmniAuth::Strategies::CatPrint do
  def raw_info_hash
    {
      'login'      => 'foobar',
      'name'       => 'Foo Bar',
      'first_name' => 'Foo',
      'last_name'  => 'Foo',
      'email'      => 'foo@bar.com',
      'image'      => 'https://www.catprint.com/assets/v1/catprint-paw.png'
    }
  end

  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact

    OmniAuth::Strategies::CatPrint.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('catprint')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://www.catprint.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_path).to eq('/oauth/authorize')
    end
  end

  describe 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the nickname' do
      expect(subject.info[:nickname]).to eq(raw_info_hash['login'])
    end

    it 'should returns the name' do
      expect(subject.info[:name]).to eq(raw_info_hash['name'])
    end

    it 'should returns the first_name' do
      expect(subject.info[:first_name]).to eq(raw_info_hash['first_name'])
    end

    it 'should returns the last_name' do
      expect(subject.info[:last_name]).to eq(raw_info_hash['last_name'])
    end

    it 'should returns the email' do
      expect(subject.info[:email]).to eq(raw_info_hash['email'])
    end

    it 'should returns the image' do
      expect(subject.info[:image]).to eq(raw_info_hash['image'])
    end
  end
end
