require 'spec_helper'
require 'product'

describe 'Productクラス' do
  let(:product) { Product.new(name: name, type: type, price: price) }
  let(:name) { 'MS Word' }
  let(:type) { 'W' }
  let(:price) { 18800 }
  it 'name属性を持っているか' do
    expect(product.name).to eq 'MS Word'
  end
  it 'type属性を持っているか' do
    expect(product.type).to eq 'W'
  end
  it 'price属性を持っているか' do
    expect(product.price).to eq 18800
  end
end
