require 'rails_helper'

RSpec.describe JsonWebToken, type: :service do
  let(:user_id) { 1 }
  let(:token) { JsonWebToken.encode(user_id: user_id) }

  describe '.encode' do
    it 'returns a token' do
      expect(token).not_to be_nil
    end
  end

  describe '.decode' do
    it 'decodes the token' do
      decoded = JsonWebToken.decode(token)
      expect(decoded[:user_id]).to eq(user_id)
    end

    it 'returns nil for invalid token' do
      decoded = JsonWebToken.decode('invalid_token')
      expect(decoded).to be_nil
    end
  end
end
