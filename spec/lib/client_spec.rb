require 'spec_helper'
require 'pry'

describe Client do
  describe '.post' do
    context 'quando os dados são validos' do
      let(:path) { 'charge/pix' }
      let(:params) do
        {
          amount: 100,
          pix_account_id: 67,
          expire_at: "2023-12-02T10:03:56-03:00"
        }
      end
      
      subject { described_class.post(path: path, params: params) }

      it 'é uma instância faraday' do
        expect(subject).to be_instance_of(Faraday::Response)
      end

      it 'usa configurações da url' do
        expect(subject.env.url).to eq URI("#{ENV['API_BASE_URL']}/#{ENV['API_VERSION']}/#{path}")
      end

      it 'content-Type está no formato json' do
        expect(subject.headers['Content-Type']).to eq('application/json; charset=utf-8')
      end
    end

    context 'quando os dados são invalidos' do
      subject { described_class.post(path: '', params: {}) }

      it 'retorna erros' do
        expect(subject[:errors].first).to eq("path can't be blank")
        expect(subject[:errors].last).to eq("params can't be blank")
      end
    end
  end
end 