module TokenAuthenticable

  def self.included(base)

    base.before do
      error!("Unauthorized", 401) unless authenticated
    end

    base.helpers do
      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        request.headers["X-Authentication-Token"] && @user = User.find_by_authentication_token(request.headers["X-Authentication-Token"])
      end

      def current_user
        warden.user || @user
      end

      def authorize!(*args)
        begin
          ::Ability.new(current_user).authorize!(*args)
        rescue
          error!("You don't have permission to access",403)
        ensure
          true
        end
      end
    end

  end

end