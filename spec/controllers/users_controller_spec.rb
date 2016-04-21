require 'rails_helper'

describe UsersController do
  describe 'GET index' do
    before { get :index }

    it { expect(response).to be_success }
  end

  describe 'GET show' do
    let(:user) { FactoryGirl.create(:user) }
    before { get :show, id: user.id }

    it { expect(response).to be_success }
  end

  describe 'POST create' do
    before do
      request.env["HTTP_REFERER"] = "schmoogle.com"
      post :create, user: { name: 'new user'}
    end

    it { expect(response).to redirect_to "schmoogle.com" }
    it { expect(User.last.name).to eq 'new user' }
  end

  describe 'PUT update' do
    let(:user) { FactoryGirl.create(:user, name: 'old name') }

    before do
      request.env["HTTP_REFERER"] = "schmoogle.com"
      put :update, id: user.id, user: { name: 'new name'}
    end

    it { expect(response).to redirect_to "schmoogle.com" }
    it { expect(user.reload.name).to eq 'new name' }
  end

  describe 'DELETE destroy' do
    let!(:user) { FactoryGirl.create(:user, name: 'old name') }

    before do
      request.env["HTTP_REFERER"] = "schmoogle.com"
      delete :destroy, id: user.id
    end

    it { expect(response).to redirect_to "schmoogle.com" }
    it { expect(User.count).to eq 0 }
  end
end
