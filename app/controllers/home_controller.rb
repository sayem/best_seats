class HomeController < ApplicationController

  def index
    @seats = params['seats']
    @available_seats = params['available_seats']

    if valid_seats(@seats) && valid_available_seats(@available_seats)
      @result = BestSeatsPresenter.new(@seats, @available_seats).best_seats
      flash.clear
    elsif @seats || @available_seats
      flash[:notice] = "Not valid inputs for number of seats and available seats."
    else
      flash.clear
    end
  end

  private
  
  def valid_seats(seats)
    seats.present? && seats == seats.to_i.to_s
  end

  def valid_available_seats(available_seats)
    json = JSON.parse(available_seats) rescue nil
    available_seats.present? && json && json['venue'] && json['seats']
  end
end
