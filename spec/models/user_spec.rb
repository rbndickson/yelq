require 'rails_helper'

describe User do
  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }

  it { is_expected.to validate_uniqueness_of(:email) }

  it do
    is_expected.to validate_length_of(:password).
    is_at_least(8).
    on(:create)
  end

  describe '#last_name_intital' do
    it "returns the first letter of the last name" do
      alice = Fabricate(:user, first_name: "Alice", last_name: "Alicia")
      expect(alice.last_name_intital).to eq("A")
    end
  end

end
