require 'swagger_helper'

RSpec.describe 'comments', type: :request do

  path '/comments' do
    # You'll want to customize the parameter types...
    post('create comment') do
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      parameter name: 'comment', in: :body, schema: {
        type: :object,
        properties: {
          comment: {
            type: :object,
            properties: {
              contribution_id: { type: :integer },
              text: { type: :string },
              replayedComment_id: { type: :integer,  nullable: true },
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

  path '/comments/{id}/like' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
    put('like comment') do
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

  path '/comments/{id}/dislike' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'

    put('dislike comment') do
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


  path '/comments/{id}/show_upvoted_comments' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show_upvoted_comments comment') do
      response(200, :success) do
        run_test!
      end
      response(422, :unprocessable_entity) do
        run_test!
      end
    end
  end

  path '/comments/{id}/show_comments' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show_comment comment') do
      response(200, :success) do
        run_test!
      end
      response(422, :unprocessable_entity) do
        run_test!
      end
    end
  end

  path '/comments/new' do

    get('new comment') do
      response(200, :success) do
        run_test!
      end
    end
  end


  path '/comments/{id}' do

    delete('delete comment') do
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
end
