require 'swagger_helper'

RSpec.describe 'contributions', type: :request do

  path '/contributions' do
    get('list contributions') do
      response(200, :success) do
        run_test!
      end
    end

    # You'll want to customize the parameter types...
    post('create contribution') do
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      parameter name: 'contribution', in: :body, schema: {
        type: :object,
        properties: {
          contribution: {
            type: :object,
            properties: {
              contribution_type: { type: :string },
              text: { type: :string },
              title: { type: :string },
              url: { type: :string }, 
            }
          }
        }
      }
      response(200, :success) do
        run_test!
      end
      response(201, :created) do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
    end
  end

  path '/contributions/{id}/like' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
    put('like contribution') do
      response(200, :success)do
        run_test!
      end
      response(401, :unauthorized)do
        run_test!
      end
      response(422, :unprocessable_entity)do
        run_test!
      end 
    end
  end

  path '/contributions/{id}/dislike' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'

    put('dislike contribution') do
      response(200, :success)do
        run_test!
      end
      response(401, :unauthorized)do
        run_test!
      end
      response(422, :unprocessable_entity)do
        run_test!
      end 
    end
  end

  path '/contributions/show_news' do

    get('show_news contribution') do
      response(200, :success) do
        run_test!
      end
    end
  end

  path '/contributions/show_ask' do

    get('show_ask contribution') do
      response(200, :success) do
        run_test!
      end
    end
  end

  path '/contributions/{id}/show_user' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show_user contribution') do
      response(200, :success) do
        run_test!
      end
    end
  end

  path '/contributions/{id}/show_upvoted_contributions' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show_upvoted_contributions contribution') do
      response(200, :success) do
        run_test!
      end
      response(422, :unprocessable_entity) do
        run_test!
      end
    end
  end

  path '/contributions/new' do
    # You'll want to customize the parameter types...
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
    get('new contribution') do
      response(200, :success) do
        run_test!
      end
    end
  end
  
  path '/contributions/{id}/edit' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('edit contribution') do
      response(200, :success) do
        run_test!
      end
    end
  end

  path '/contributions/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show contribution') do
      response(200, :success) do
        run_test!
      end
    end

    patch('update contribution') do
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      response(200, 'successful') do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
    end

    put('update contribution') do
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      response(200, 'successful') do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
    end

    delete('delete contribution') do
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      response(200, :success) do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
      response(404, :not_found) do
        run_test!
      end
    end
  end

  path '/' do
    get('list contributions') do
      response(200, :success) do
        run_test!
      end
    end
  end
end
