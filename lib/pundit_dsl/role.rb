module PunditDsl
  class Role
    attr_reader :role, :policies, :scopes

    # Public: Defined policiy and/or scope
    #
    # role - symbol of name of role concerned
    # &blk - block
    #
    # Examples
    #
    #   role :admin do
    #     policy :post do
    #       right :touch do |user, resource|
    #         true
    #       end
    #       right :create do |user, resource|
    #         user.is_admin?
    #       end
    #     end
    #     scope :post do |user|
    #       user.posts
    #     end
    #   end
    #
    #
    # Returns nothing
    def initialize(role, &blk)
      @role, @policies, @scopes = role, {}, {}
      instance_eval(&blk) if block_given?
    end

    def policy(klass, &blk)
      if block_given?
        policy = Policy.new(klass, &blk)
        @policies[klass] = policy
      end
    end

    def scope(klass, &blk)
      if block_given?
        scope = Scope.new(klass, &blk)
        @scopes[klass] = scope
      end
    end
  end
end
