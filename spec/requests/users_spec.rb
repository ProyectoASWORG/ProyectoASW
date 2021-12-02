require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users/{id}/edit' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('edit user') do
      tags 'Users'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      response(200, :ok) do
        run_test!
      end
      response(404, :not_found) do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
      response(403, :forbidden) do
        run_test!
      end
      
    end

    put('update user') do
      tags 'Users'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      parameter name: 'user', in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              about: { type: :string },
              email: { type: :string },
              max_visit: { type: :integer },
              min_away: { type: :integer }, 
              delay: { type: :integer }, 
              show_dead: { type: :boolean }, 
              no_procrast: { type: :boolean }, 
            }
          }
        }
      }
      response(200, :ok) do
        run_test!
      end
      response(404, :not_found) do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
      response(403, :forbidden) do
        run_test!
      end
    end
  end

  path '/users/{id}/show' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      tags 'Users'
      response(200, :ok) do
        run_test!
      end
      response(404, :not_found) do
        run_test!
      end
    end
  end
end
