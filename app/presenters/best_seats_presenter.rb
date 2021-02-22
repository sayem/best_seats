class BestSeatsPresenter

  def initialize(seats, available_seats)
    @seats = seats
    @available_seats = available_seats
  end

  def best_seats
    seats_number = @seats.to_i
    seats_json = JSON.parse(@available_seats)

    rows = seats_json['venue']['layout']['rows'].to_i
    columns = seats_json['venue']['layout']['columns'].to_i
    seats = seats_json['seats']
    
    middle = columns.even? ? columns / 2 : (columns / 2 ) + 1
    available_seats = seats.values.select {|x| x['status'] == 'AVAILABLE' }
                                  .select {|x| x['column'] <= columns }

    result = best_seats_result(available_seats, seats_number, rows, middle)
    result_ids = result.any? ? result.map {|x| x['id'] }.join(', ') : 'No seats found'
  end

  private
  
  def best_seats_result(available_seats, seats_number, rows, middle)
    best_seats = []
    n = 0
    
    ('a'..'z').each do |row|
      if n < rows
        row_seats = available_seats.select {|x| x['row'] == row }
        
        if row_seats.length >= seats_number
          row_seats.each do |seat|
            seat['distance'] = (seat['column'] - middle).abs
          end

          sorted_seats = row_seats.sort_by {|x| x['distance'] }
          best_seats = best_sorted_seats(sorted_seats, best_seats, seats_number)
          
          best_seats.clear if best_seats.length < seats_number
        end

        break if best_seats.length == seats_number
      else
        break
      end
      
      n += 1
    end

    best_seats
  end

  def best_sorted_seats(sorted_seats, best_seats, seats_number)
    sorted_seats.each do |seat|
      if best_seats.length < seats_number
        if best_seats.empty?
          best_seats.push(seat)
        else
          sorted_columns = best_seats.sort_by {|x| x['column'] }
          first_seat = sorted_columns.first
          last_seat = sorted_columns.last
          seats_left = sorted_seats - best_seats
          
          if seat_differences(seat, first_seat, last_seat)
            best_seats.push(seat)
          else
            if seats_left.none? {|x| seat_differences(x, first_seat, last_seat) }
              best_seats.clear
              best_seats.push(seat)
            end
          end
        end
      else
        break
      end
    end

    best_seats
  end

  def seat_differences(seat, first_seat, last_seat)
    ((seat['column'] - first_seat['column']).abs == 1) || ((seat['column'] - last_seat['column']).abs == 1)
  end
end
