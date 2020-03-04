class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def as_json(model)
    {
      json: model,
      status: :ok,
      except: %i[created_at updated_at]
    }
  end

  def render_record_invalid(exception)
    render json: { message: exception.message }, status: 422
  end

  def render_record_not_found(exception)
    render json: { message: exception.message }, status: 404
  end
end
