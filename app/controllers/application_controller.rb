class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  JSON = 'application/json'.freeze

  def render_json(model)
    render(
      json: model,
      status: :ok,
      except: %i[created_at updated_at]
    )
  end

  def render_record_invalid(exception)
    render json: { message: exception.message }, status: 422
  end

  def render_record_not_found(exception)
    render json: { message: exception.message }, status: 404
  end

  def render_created
    render status: :created, content_type: JSON
  end

  def render_no_content
    render status: :no_content, content_type: JSON
  end

  def render_not_found
    render status: 404, content_type: JSON
  end
end
