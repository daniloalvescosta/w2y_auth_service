require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user, email: 'user@example.com', password: 'password') }

  describe 'POST #register' do
    context 'with valid attributes' do
      it 'creates a new user and returns a JWT token' do
        post :register, params: { user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' } }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['token']).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user and returns errors' do
        post :register, params: { user: { email: '', password: 'password', password_confirmation: 'password' } }
        expect(response).to have_http_status(:unprocessable_entity)

        expect(JSON.parse(response.body)["email"]).to eq(["can't be blank"])
      end
    end
  end

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post :register, params: { user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' } }
        post :login, params: { email: 'newuser@example.com', password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['token']).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post :login, params: { email: "invalid@email.com", password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('invalid credentials')
      end
    end
  end
end
