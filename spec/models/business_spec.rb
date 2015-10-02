require 'rails_helper'

describe Business do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:country) }
end
