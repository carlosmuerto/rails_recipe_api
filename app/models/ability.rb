class Ability
  include CanCan::Ability

  def initialize(user)
    can(%i[read], Food)
    can(%i[publics], Recipe, public: true)

    return unless user.present?

    can(%i[read], Food)
    can(%i[read create update destroy], Recipe, author: user)
    can(%i[read create update destroy], UserFood, user:)
    can(%i[read create update destroy], RecipeFood)

    return unless user.admin?

    can %i[read update create destroy], :all
  end
end
