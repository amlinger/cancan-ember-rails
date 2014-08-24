class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
     user ||= User.new # guest user (not logged in)
     if user.role == 'admin'
       can :manage, :all
     else
       can :read, :all
     end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    can :update, User, :role => "pig"
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  def as_json(options)
    return { 
      rules: rules.map do |rule| 
      { 
        can:        rule.base_behavior, 
        actions:    rule.actions.as_json, 
        subjects:   rule.subjects.map(&:to_s), 
        conditions: rule.conditions.as_json
      }
    end
    }
  end
end
