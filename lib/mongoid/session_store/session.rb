module Mongoid

  module SessionStore

    class Session

      include Mongoid::Document
      include Mongoid::Timestamps

      field :session_id
      field :raw_data
      field :expires_at, :type => DateTime

      DEFAULT_SESSION_EXPIRY = 60

      store_in :collection => :sessions, :database => 'mongoid_session_store'

      before_update :set_expires_at

      def self.find_by_session_id(session_id)
        where(:session_id => session_id).last
      end

      def self.session_expiry
        ENV['SESSION_TIMEOUT'].to_i.minutes || DEFAULT_SESSION_EXPIRY.minutes
      end

      def data
        self.raw_data.present? && Marshal.load(Base64.decode64(self.raw_data)).merge(:expires_at => self.expires_at) || {}
      end

      def data=(raw={})
        self.raw_data = Base64.encode64(Marshal.dump(raw))
      end

      def set_expires_at
        if current?
          self.expires_at = Time.now + Session.session_expiry
        else
          self.expires_at = nil
        end
      end

      def current?
        return true unless self.expires_at.present?
        self.expires_at.in_time_zone > Time.now.in_time_zone
      end

      def expired?
        ! current?
      end

      def loaded?
        self.raw_data.present?
      end

    end

  end

end
