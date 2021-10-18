module ContributionServices
  class CreateContributionService
    include Devise

    def initialize(params, user_id)
        @params = params
        @user_id = user_id
    end

    def call 
        contribution = Contribution.new(@params)

        if contribution.url.present?
            contribution.contribution_type = 'url'
        else
            contribution.contribution_type = 'text'
        end

        contribution.user_id = @user_id

        contribution
    end

  end
end