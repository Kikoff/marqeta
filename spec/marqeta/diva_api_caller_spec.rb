describe Marqeta::DivaApiCaller do
  subject(:api_caller) { Marqeta::DivaApiCaller.new(endpoint, params) }

  let(:endpoint) { 'foo' }
  let(:params) { {} }
  let(:response_hash) { { 'a' => 1, 'b' => 2 } }

  describe 'resource' do
    let(:resource) { api_caller.send(:resource) }

    it 'sets up the resource correctly' do
      expect(resource.url).to eq "www.diva-api.com#{endpoint}"
      expect(resource.options[:user]).to eq '12345'
      expect(resource.options[:password]).to eq '67890'
    end
  end
end
