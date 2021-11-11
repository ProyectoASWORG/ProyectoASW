module ContributionServices
  class CreateContributionService

    def initialize(params)
        @params = params
    end

    def call 
        contribution = Contribution.new(@params)

        if contribution.url.present?
            contribution.contribution_type = 'url'
        else
            contribution.contribution_type = 'ask'
        end

        contribution
    end

  end
end