require 'rails_helper'

RSpec.describe User, type: :model do
    it "is valid with valid attributes" do
    user = user.create(email:"john@coucoumail.com")

    expect(@user).to eq("john@coucoumail.com")
    expect(@user).to be_a(User)
    expect(@user).to be_valid
    end
end