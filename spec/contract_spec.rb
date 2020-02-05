require 'spec_helper'
require 'contract'
require 'product'
require 'date'

describe 'Contractクラス' do
  let(:contract) { Contract.new(signed_on: signed_on, product: product) }
  let(:signed_on) { Date.new(2020, 02, 05) }
  let(:product) { Product.new(params) }
  let(:params) do
    { name: 'MS Word', type: 'W', price: 18800 }
  end
  it 'signed_on属性を持っているか' do
    expect(contract.signed_on).to eq signed_on
  end
  it 'productをもっているか' do
    expect(contract.product).to be_a_kind_of Product
  end

  describe 'Contract#revenue_on' do
    context 'ワードプロセッサを契約したとき' do
      context '契約日以降の日付での売上' do
        let(:date) { Date.new(2020, 02, 05) }
        it '18800円を返す' do
          expect(contract.revenue_on(date)).to eq 18800
        end
      end

      context '契約日以前の日付での売上' do
        let(:date) { signed_on.prev_day }
        it '0円を返す' do
          expect(contract.revenue_on(date)).to eq 0
        end
      end
    end

    context 'スプレッドシートを契約したとき' do
      let(:params) do
        { name: 'MS Excel', type: 'S', price: 27800 }
      end
      context '契約日以降の日付での売上' do
        context '契約当日のとき' do
          let(:date) { Date.new(2020, 02, 05) }
          it '27800円の３分の２を返す' do
            expect(contract.revenue_on(date)).to eq 27800 *2 /3
          end
        end
        context '契約から30日以降のとき' do
          let(:date) { Date.new(2020, 02, 05) + 30 }
          it '27800円を返す' do
            expect(contract.revenue_on(date)).to eq 27800
          end
        end
      end

      context '契約日以前の日付での売上' do
        let(:date) { signed_on.prev_day }
        it '0円を返す' do
          expect(contract.revenue_on(date)).to eq 0
        end
      end
    end

    context 'データベースを契約したとき' do
      let(:params) do
        { name: 'MS SQL Server', type: 'D', price: 919000 }
      end
      context '契約当日のとき' do
        let(:date) { Date.new(2020, 02, 05) }
        it '919000円の3分の1を返す' do
          expect(contract.revenue_on(date)).to eq 919000 / 3
        end
      end
      context '契約から60日後のとき' do
        let(:date) { Date.new(2020, 02, 05) + 60 }
        it '919000円の3分の2を返す' do
          expect(contract.revenue_on(date)).to eq 919000 / 3 * 2
        end
      end

      context '契約から120日後のとき' do
        let(:date) { Date.new(2020, 02, 05) + 120 }
        it '919000円を返す' do
          expect(contract.revenue_on(date)).to eq 919000
        end
      end
    end
  end
end
