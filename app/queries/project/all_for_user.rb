class Project
  class AllForUser
    # TODO: Implement
    def call(relation, user)
      relation
        .where(user_id: user.id)
    end
  end
end
