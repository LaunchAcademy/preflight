require 'securerandom'
module Preflight
  class CampaignSubscription < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :subscriber
    belongs_to :referrer,
      class_name: "Preflight::CampaignSubscription",
      foreign_key: "referrer_id"

    has_many :shares,
      class_name: "Preflight::Share",
      foreign_key: "campaign_subscription_id",
      dependent: :destroy

    validates :campaign,
      presence: true,
      uniqueness: {scope: :subscriber_id}

    validates :invitation_token,
      uniqueness: {scope: :campaign_id}

    validates :subscriber, presence: true

    before_create :generate_invitation_token

    def to_param
      self.invitation_token
    end

    class << self
      #adapted from Devise:
      #https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L476
      def friendly_token
        SecureRandom.urlsafe_base64(15).tr('lIO0', 'sxyz')
      end
    end

    protected
    def generate_invitation_token
      if invitation_token.blank?
        generate_unique_token
      end
    end

    def generate_unique_token
      generate_token
      while self.class.where(invitation_token: invitation_token).count > 1
        generate_unique_token
      end
    end

    def generate_token
      self.invitation_token = self.class.friendly_token
    end
  end
end
