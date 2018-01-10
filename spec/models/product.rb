require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.not_to allow_value(nil).for(:sold_out) }
  it { is_expected.not_to allow_value(nil).for(:under_sale) }

  it { is_expected.to validate_numericality_of(:price) }
  it { is_expected.not_to allow_value(-1).for(:price) }
  it { is_expected.to allow_value(0).for(:price) }
  it { is_expected.not_to allow_value(1.5).for(:price) }
  it { is_expected.not_to allow_value(nil).for(:price) }

  it { is_expected.to validate_numericality_of(:sale_price) }
  it { is_expected.not_to allow_value(-1).for(:sale_price) }
  it { is_expected.to allow_value(0).for(:sale_price) }
  it { is_expected.not_to allow_value(1.5).for(:sale_price) }
  it { is_expected.to allow_value(nil).for(:sale_price) }
end