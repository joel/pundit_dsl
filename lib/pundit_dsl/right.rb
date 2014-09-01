module PunditDsl
  class Right

    attr_reader :action, :rule

    # Public: Defined right for an action
    #
    # action - symbol of name of action concerned
    # &rule - block
    #
    # Examples
    #
    #   right :create do |user, resource|
    #     user.is_admin?
    #   end
    #
    # Returns boolean
    def initialize(action, &rule)
      @action = action
      @rule = rule
    end
  end
end
