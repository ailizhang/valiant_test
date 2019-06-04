class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  protected

  def render_bad_request(message)
    render json: { success: false, error: message }, status: :bad_request
  end
end
