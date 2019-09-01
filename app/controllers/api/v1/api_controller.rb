class Api::V1::ApiController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :render_basic
    private
    def render_basic
        render json: 'Não encontrado', status: 404
    end
end