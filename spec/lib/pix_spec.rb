require 'spec_helper'

describe Pix do
  describe '#create' do
    context 'quando os parâmetros são enviados' do
      let(:path) { 'charge/pix' }
      let(:params) do
        {
          amount: 100,
          pix_account_id: 67,
          expire_at: "2023-12-02T10:03:56-03:00"
        }
      end

      subject { described_class.new(params: params).create }

      it 'cria cobrança pix com sucesso' do
        expect(subject.body['status']).to eq(201)
        expect(subject.body['data']['status']).to eq('opened')
      end

      it 'retorna dados' do
        expect(subject.body).to be_a_kind_of(Hash)
      end
    end

    context 'quando não envia parâmetros obrigatório' do
      let(:params) do
        {
          amount: nil,
          pix_account_id: nil,
          expire_at: nil
        }
      end

      subject { described_class.new(params: params).create }

      it 'retorna erros' do
        expect(subject[:errors].first).to eq("amount can't be blank")
        expect(subject[:errors][1]).to eq("pix_account_id can't be blank")
        expect(subject[:errors].last).to eq("expire_at can't be blank")
      end
    end
  end
end