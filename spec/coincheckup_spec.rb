# frozen_string_literal: true

require 'spec_helper'

describe CoinCheckup do
  it { expect(described_class::VERSION).to eq('0.1.0') }

  describe '#all' do
    it 'returns hash' do
      stub_request(:get, /ico/).and_return(body: fixture('icos.html'))
      response = described_class.all
      expect(a_request(:get, /ico\/\?filter\=all/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:response_code, :response_time, :count, :icos)
    end
  end

  describe '#preico' do
    it 'returns hash' do
      stub_request(:get, /ico/).and_return(body: fixture('icos.html'))
      response = described_class.preico
      expect(a_request(:get, /ico\/\?filter\=preico/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:response_code, :response_time, :count, :icos)
    end
  end

  describe '#past' do
    it 'returns hash' do
      stub_request(:get, /ico/).and_return(body: fixture('icos.html'))
      response = described_class.past
      expect(a_request(:get, /ico\/\?filter\=past/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:response_code, :response_time, :count, :icos)
    end
  end

  describe '#upcoming' do
    it 'returns hash' do
      stub_request(:get, /ico/).and_return(body: fixture('icos.html'))
      response = described_class.upcoming
      expect(a_request(:get, /ico\/\?filter\=upcoming/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:response_code, :response_time, :count, :icos)
    end
  end

  describe '#ongoing' do
    it 'returns hash' do
      stub_request(:get, /ico/).and_return(body: fixture('icos.html'))
      response = described_class.ongoing
      expect(a_request(:get, /ico\/\?filter\=ongoing/)).to have_been_made.once
      expect(response).to be_a(Hash)
      expect(response.keys).to include(:response_code, :response_time, :count, :icos)
    end
  end

  describe '#parse_ico_row' do
    let(:html) { Nokogiri::HTML(fixture('icos.html')) }

    it 'parses row and returns hash' do
      tables = html.css('table.uk-table:not(.search-element)')
      row = tables[0].css('tbody tr')[0]
      ico = described_class.send(:parse_ico_row, row, true)
      expect(ico).to eq(
        name: 'Cappasity',
        symbol: 'CAPP',
        url: 'https://coincheckup.com/ico/cappasity/',
        ico_start: Date.parse('2018-03-21'),
        ico_end: Date.parse('2018-04-18'),
        hype_score: 61.4,
        risk_score: 40.0,
        expert_review: true,
        review_url: 'https://coincheckup.com/analytics/indepth/cappasity-rating-review-/',
        rating: 'Positive',
        industry: 'Gaming & VR'
      )
    end
  end
end
