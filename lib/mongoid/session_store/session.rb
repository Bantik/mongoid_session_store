module Mongoid

  module SessionStore

    class Session

      include Mongoid::Document
      include Mongoid::Timestamps

      field :session_id
      field :raw_data

      def self.find_by_session_id(session_id)
        where(:session_id => session_id).last
      end

      def data
        self.raw_data.present? && Marshal.load(ActiveSupport::Base64.decode64(self.raw_data)) || {}
      end

      def data=(raw)
        raw ||= {}
        self.raw_data = ActiveSupport::Base64.encode64(Marshal.dump(raw))
      end

      def loaded?
        self.raw_data.present?
      end

    end

  end

end
