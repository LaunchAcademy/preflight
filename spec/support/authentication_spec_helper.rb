require 'omniauth'

module AuthenticationSpecHelper
  ACCESS_TOKEN = {
    :access_token => "LEGIT"
  }

  def stub_auth_response(role, provider = :crew_check)
    OmniAuth.config.test_mode = true

    info = {
      'provider' => 'crew_check',
      'uid'   => 413441,
      'info' => {
        'name'  => 'John Smith',
        'email' => 'user@example.com',
        'nickname' => 'johnnysmith'
      },
      'extra' => {
        'teams' => [],
        'roles' => [role]
      },
      'credentials' => {
        'token' => ENV['GITHUB_TOKEN']
      }
    }

    OmniAuth.config.mock_auth[:github] = info
  end

  def sign_in_as(role, provider = :crew_check)
    stub_auth_response(role, provider)
    visit "/preflight/auth/#{provider}"
  end
end
