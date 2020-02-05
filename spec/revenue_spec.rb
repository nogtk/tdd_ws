require 'spec_helper'
require 'date'
require 'revenue'
require 'contract'
require 'product'

describe 'Revenueクラス' do
  describe 'Revenue.gross_revenue' do
    let(:date) { Date.new(2020, 2, 5) }
    let(:contracts) do
      [ contract ]
    end
    let(:contract) { Contract.new(signed_on: signed_on, product: word) }
    let(:signed_on) { Date.new(2020, 02, 05) }

    let(:word) { Product.new(word_params) }
    let(:word_params) do
      { name: 'MS Word', type: 'W', price: 18800 }
    end

    let(:excel) { Product.new(excel_params) }
    let(:excel_params) do
      { name: 'MS Excel', type: 'S', price: 27800 }
    end

    let(:db) { Product.new(db_params) }
    let(:db_params) do
      { name: 'MS SQL Server', type: 'D', price: 919000 }
    end

    it 'ワードプロセッサの契約が１つだった場合、18800を返す' do
      expect(Revenue.gross_revenue(date, contracts)).to eq 18800
    end
    context 'MS Excel、 MS SQL Server がひとつずつ、 5日後に MS Word と MS Excel がひとつずつ売れる契約の場合' do
      let(:excel_contract_today) {
        Contract.new(signed_on: signed_on, product: excel)
      }
      let(:db_contract_today) {
        Contract.new(signed_on: signed_on, product: db)
      }
      let(:word_contract_after_5_days) {
        Contract.new(signed_on: signed_on + 5, product: word)
      }
      let(:excel_contract_after_5_days) {
        Contract.new(signed_on: signed_on + 5, product: excel)
      }
      let(:contracts) {
        [
          excel_contract_today,
          db_contract_today,
          word_contract_after_5_days,
          excel_contract_after_5_days
        ]
      }

      context '本日' do
        it do
          expect(Revenue.gross_revenue(date, contracts)).to eq 27800/3 * 2 + 919000/3
        end
      end
      context '30日後' do

      end
      context '60日後' do

      end
    end
  end
end
