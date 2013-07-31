module Mongoid

  module SessionStore

    class Session

      include Mongoid::Document
      include Mongoid::Timestamps

      field :session_id
      field :data

      def self.find_by_session_id(session_id)
        where(:session_id => session_id)
      end

      def data
        Marshal.load(self.data) || {}
      end

      def data=(raw)
        write_attribute(data, Marshal.dump(data))
      end

      def loaded?
        @data
      end

    end

  end

end
