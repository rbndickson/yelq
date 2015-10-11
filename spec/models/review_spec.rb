require 'rails_helper'

describe Review do
  it { is_expected.to belong_to(:creator) }
  it { is_expected.to belong_to(:business) }

  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_presence_of(:content) }
end
