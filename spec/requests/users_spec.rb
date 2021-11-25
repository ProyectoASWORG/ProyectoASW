require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users/{id}/edit' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('edit user') do
      response(200, 'successful') do

        run_test!
      end
    end

    put('update user') do
      response(200, 'successful') do
        
        run_test!
      end
    end
  end

  path '/users/{id}/show' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      response(200, 'successful') do
        
        run_test!
      end
    end
  end
end
