class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found
    def index
        render json: Spice.all, status: :ok
    end
    def create
        spice = Spice.create!(spice_params)
        render json: spice, status: :created
    end
    def update
        spice = find_spice
        if spice.update(spice_params)
            render json: spice, status: :ok
        else
            render json: {error: "Could Not Update Spice"}
        end
    end
    def destroy
        spice = find_spice
        if spice.destroy
            render json: spice, status: :ok
        else
            render json: {error: "Could Not Delete Spice"}
        end
    end

    private
    def respond_with_not_found
        render json: {error: "Spice Not Found"}, status: :not_found
    end
    def find_spice
        Spice.find(params[:id])
    end
    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
