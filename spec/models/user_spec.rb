require 'rails_helper'

RSpec.describe User, type: :model do
  it "Requires that a username must be present" do
      user = User.new

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:username)
  end


  it "Requires that a email must be present" do
      user = User.new

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:email)
  end

  before do
    @user = User.create(username: "moo", email: "goats@coats.com")
    @other_user = @user.dup
    @other_user.save
  end

  it "requires that a username be unique" do
    expect(@other_user).to_not be_valid
  end

  it "requires that a email be unique" do
    expect(@other_user).to_not be_valid
  end

end
