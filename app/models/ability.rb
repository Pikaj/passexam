class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :menager
      can :manage, [Subject, Point, NoProgress, Progress, Task, Category, List, Card, CardCategory]
      can [:delete, :create], [Solution, Comment], user_id: user.id
    end

    if user.has_role? :student
      can :read, [Subject, Task, List, Category, CardCategory]
      can(:read, Card) {|card| card.card_category.subject.has_ticket_user(user)}
      can(:read, Solution) {|sol| sol.card_category.subject.has_ticket_user(user)}
      can [:delete, :create, :read], [Solution, Comment], user_id: user.id
      can :menage, [NoProgress, Progress, Point]
    end
  end
end
