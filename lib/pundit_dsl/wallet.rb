module PunditDsl
  class Wallet

    def initialize &blk
      instance_eval(&blk) if block_given?
    end

    def role(role_name, &blk)
      if block_given?
        role = Role.new(role_name, &blk)
        Wallet[role_name] = role
      end
    end

    class << self

      # Public: Main class method for the DSL
      #
      # @blok  - Block of rules
      #
      # Examples
      #
      #   Wallet.generate_policy_for do
      #     role :admin do
      #       policy :post do
      #         right :touch do |user, resource|
      #           true
      #         end
      #         right :create do |user, resource|
      #           user.is_admin?
      #         end
      #       end
      #       scope :post do |user|
      #         user.posts
      #       end
      #     end
      #   end
      #
      # Returns role
      def generate_policy_for &block
        Wallet.new &block
      end

      def [] role_name
        PolicyRegistry.instance[role_name]
      end

      def []= role_name, role
        PolicyRegistry.instance[role_name] = role
      end

      # Public: Give authorization for an action
      #
      # user     - User for authorization is needed
      # resource - Resource for authorization is needed
      # action   - Authorization ask
      #
      # Examples
      #
      #   Wallet.authorized?(user, :update, post)
      #
      # Returns boolean
      def authorized? user, resource, action
        role = user.to_role
        policies = PolicyRegistry.instance[role].policies
        klass = resource.class.name.downcase.to_sym
        policy = policies[klass]
        policy.send(:"#{action}?", user, resource)
      rescue
        false
      end

      # Public: Give a scope
      #
      # user     - User for authorization is needed
      # resource - Resource for authorization is needed
      #
      # Examples
      #
      #   Wallet.scope(user, resource)
      #
      # Returns whatever you have define in proc, Array, Enum, and so on
      def scope user, resource
        role = user.to_role
        scopes = PolicyRegistry.instance[role].scopes
        klass = resource.class.name.downcase.to_sym
        scope = scopes[klass]
        scope.resolve user
      rescue
        []
      end
    end
  end
end
