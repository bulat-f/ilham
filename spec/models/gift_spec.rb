require 'rails_helper'

RSpec.describe Gift, type: :model do
  let(:gift) { FactoryGirl.create :gift }

  describe '#pay!' do
    context 'befor pay' do
      it { expect(gift.paid?).to eq(false) }
    end

    context 'after pay' do
      before { gift.pay! }

      it { expect(gift.paid?).to eq(true) }
    end
  end
end
