# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  background             :string
#  cat                    :jsonb
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  google_token           :string
#  last_name              :string           not null
#  p_uid                  :string
#  picture                :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  songs                  :jsonb
#  spotify_token          :string
#  twitter_token          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { FFaker::NameFR.first_name }
    last_name { FFaker::NameFR.last_name }
    email { FFaker::Internet.unique.email }
    google_token { FFaker::Internet.password }
    password { "123456" }

    factory :user_admin do
      admin { true }
    end
  end
end
