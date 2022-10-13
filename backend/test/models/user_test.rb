# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  email                  :string           not null
#  background             :string
#  admin                  :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
