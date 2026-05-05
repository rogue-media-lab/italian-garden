module Admin
  class ReservationsController < BaseController
    before_action :set_reservation, only: [ :update, :destroy ]

    def index
      @reservations = Reservation.ordered
      @reservations = @reservations.where(status: params[:status]) if params[:status].present?
    end

    def update
      if @reservation.update(reservation_params)
        redirect_to admin_reservations_path, notice: "Reservation #{@reservation.status}."
      else
        redirect_to admin_reservations_path, alert: "Could not update reservation."
      end
    end

    def destroy
      @reservation.destroy
      redirect_to admin_reservations_path, notice: "Reservation deleted."
    end

    private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:status)
    end
  end
end
