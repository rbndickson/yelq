require 'rails_helper'

describe Category do
  it { is_expected.to have_many(:businesses) }
  it { is_expected.to validate_presence_of(:name) }
end
