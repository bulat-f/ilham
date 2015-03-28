require 'rails_helper'

describe PaymentsController do
  describe '#confirm' do
    context 'status is pay' do
      let(:user)    { FactoryGirl.create :user }
      let(:fiction) { FactoryGirl.create :fiction }
      let(:payment) { FactoryGirl.create :payment, fiction: fiction, user: user }
      let(:params)  { { method: 'pay', params: { account: payment.id } } }
      let(:json)    { { result: { message: 'Success' } }.to_json }

      before do
        get :confirm, params
      end

      it { expect(response.body).to eq(json) }

      it { expect(user.bought?(fiction)).to eql(true) }
    end
  end
end
