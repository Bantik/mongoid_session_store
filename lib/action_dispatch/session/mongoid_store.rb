require 'action_dispatch/middleware/session/abstract_store'

module ActionDispatch
  module Session

    class MongoidSessionStore < ActionDispatch::Session::AbstractStore

      SESSION_RECORD_KEY = 'rack.session.record'
      ENV_SESSION_OPTIONS_KEY = Rack::Session::Abstract::ENV_SESSION_OPTIONS_KEY

      private

      def session_class
        Mongoid::SessionStore::Session
      end

      def get_session(env, sid)
        unless sid and session = session_class.find_by_session_id(sid)
          sid = generate_sid
          session = session_class.new(:session_id => sid, :data => {})
        end
        env[SESSION_RECORD_KEY] = session
        [sid, session.data]
      end

      def set_session(env, sid, session_data, options)
        record = get_session_model(env, sid)
        record.data = session_data
        return false unless record.save

        session_data = record.data
        if session_data && session_data.respond_to?(:each_value)
          session_data.each_value do |obj|
            obj.clear_association_cache if obj.respond_to?(:clear_association_cache)
          end
        end

        sid
      end

      def destroy_session(env, session_id, options)
        if sid = current_session_id(env)
          get_session_model(env, sid).destroy
          env[SESSION_RECORD_KEY] = nil
        end

        generate_sid unless options[:drop]
      end

      def get_session_model(env, sid)
        if env[ENV_SESSION_OPTIONS_KEY][:id].nil?
          env[SESSION_RECORD_KEY] = find_session(sid)
        else
          env[SESSION_RECORD_KEY] ||= find_session(sid)
        end
      end

      def find_session(id)
        session_class.find_by_session_id(id) ||
          session_class.new(:session_id => id, :data => {})
      end
    end
  end
end
