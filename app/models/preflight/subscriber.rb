module Preflight
  class Subscriber < ActiveRecord::Base
    has_many :subscriptions,
      class_name: 'Preflight::CampaignSubscription',
      foreign_key: 'subscriber_id',
      dependent: :destroy

    has_many :campaigns,
      through: :subscriptions

    #email regexp courtesy of devise:
    #https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L123
    validates :email, uniqueness: true,
      format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end
