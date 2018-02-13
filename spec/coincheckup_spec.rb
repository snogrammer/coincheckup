# frozen_string_literal: true

require 'spec_helper'

describe CoinCheckup do
  it { expect(described_class::VERSION).to eq('0.1.0') }

  describe '#analysis' do
    it 'returns hash' do
      stub_request(:get, /coincheckup.com/).and_return(body: "<head><script>var DATA_URI = '/data/prod/201802131829/';</script></head>")
      stub_request(:get, /assets/).and_return(body: fixture('analysis.json'))
      response = described_class.analysis('funfair')
      expect(a_request(:get, /data\/prod\/.+\/assets\/funfair.json/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:code, :data_version)
    end

    it 'returns error if html is returned (unknown coin_id assumed)' do
      stub_request(:get, /coincheckup.com/).and_return(body: "<head><script>var DATA_URI = '/data/prod/201802131829/';</script></head>")
      stub_request(:get, /assets/).and_return(status: 404, body: '<html>Not Found</html>')
      response = described_class.analysis('blah')
      expected_response = fixture('error.json', json: true, symbolize: true)
      expect(response).to eq(expected_response)
    end
  end

  describe '#categories' do
    it 'returns hash' do
      stub_request(:get, /categories-tags/).and_return(status: 200, body: fixture('categories.json'))
      response = described_class.categories
      expect(a_request(:get, /data\/prod\/.+\/categories-tags.json/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:code, :count, :data_version, :categories)
    end
  end
end
