require 'swagger_helper'

RSpec.describe 'comments', type: :request do

  path '/comments' do
    # You'll want to customize the parameter types...
    post('create comment') do
      tags 'Comments'
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
      tags 'Comments'
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
      tags 'Comments'
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
      tags 'Comments'
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
      tags 'Comments'
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
      tags 'Comments'
      response(200, :success) do
        run_test!
      end
    end
  end


  path '/comments/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    put('update comment') do
      tags 'Comments'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization'
      parameter name: 'comment', in: :body, schema: {
        type: :object,
        properties: {
          comment: {
            type: :object,
            properties: {
              text: { type: :string }
            }
          }
        }
      }
      response(200, :ok) do
        run_test!
      end
      response(401, :unauthorized) do
        run_test!
      end
      response(422, :unprocessable_entity) do
        run_test!
      end
    end
    delete('delete comment') do
      tags 'Comments'
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
