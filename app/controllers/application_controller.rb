

class ApplicationController < ActionController::API
  
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = Customer.find(@decoded[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: 401
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: 401
    end
  end
end
