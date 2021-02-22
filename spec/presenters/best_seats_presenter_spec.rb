require 'rails_helper'

describe BestSeatsPresenter do
  context 'when there are 0 rows in available seats venue layout' do
    let(:seats) { 1 }
    let(:available_seats) {
      { 
        "venue": { 
          "layout": { 
            "rows": 0, 
            "columns": 15
          } 
        }, 
        "seats": { 
          "a1": { 
            "id": "a1", 
            "row": "a", 
            "column": 1, 
            "status": "AVAILABLE" 
          },
          "a2": { 
            "id": "a2", 
            "row": "a", 
            "column": 2, 
            "status": "AVAILABLE" 
          }
        } 
      }
    }
    
    it 'returns 0 seats in the best seats result' do
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'No seats found'
    end
  end

  context 'when there are available seats in the a and b rows' do
    let(:available_seats) {
      { 
        "venue": { 
          "layout": { 
            "rows": 2, 
            "columns": 15
          } 
        }, 
        "seats": { 
          "a1": { 
            "id": "a1", 
            "row": "a", 
            "column": 1, 
            "status": "AVAILABLE" 
          },
          "a2": { 
            "id": "a2", 
            "row": "a", 
            "column": 2, 
            "status": "AVAILABLE" 
          },
          "b1": { 
            "id": "b1", 
            "row": "b", 
            "column": 1, 
            "status": "AVAILABLE" 
          },
          "b2": { 
            "id": "b2", 
            "row": "b", 
            "column": 2, 
            "status": "AVAILABLE" 
          },
          "b3": { 
            "id": "b3", 
            "row": "b", 
            "column": 3, 
            "status": "AVAILABLE" 
          }
        } 
      }
    }
    
    it 'returns 1 seat in the best seats result in row a' do
      seats = 1
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: a2'
    end

    it 'returns 2 seats in the best seats result in row a' do
      seats = 2
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: a2, a1'
    end
    
    it 'returns 3 seats in the best seats result in row b' do
      seats = 3
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: b3, b2, b1'
    end
  end

  context 'when there are available seats in the a and h rows' do
    let(:available_seats) {
      { 
        "venue": { 
          "layout": { 
            "rows": 20, 
            "columns": 30
          } 
        }, 
        "seats": { 
          "a4": { 
            "id": "a4", 
            "row": "a", 
            "column": 4, 
            "status": "AVAILABLE" 
          },
          "a12": { 
            "id": "a12", 
            "row": "a", 
            "column": 12, 
            "status": "AVAILABLE" 
          },
          "h5": { 
            "id": "h5", 
            "row": "h", 
            "column": 5, 
            "status": "AVAILABLE" 
          },
          "h6": { 
            "id": "h6", 
            "row": "h", 
            "column": 6, 
            "status": "AVAILABLE" 
          },
          "h7": { 
            "id": "h7", 
            "row": "h", 
            "column": 7, 
            "status": "AVAILABLE" 
          }
        } 
      }
    }
    
    it 'returns 1 seat in the best seats result in row a correctly' do
      seats = 1
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: a12'
    end

    it 'returns 2 seats in the best seats result in row h correctly' do
      seats = 2
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: h7, h6'
    end

    it 'returns 3 seats in the best seats result in row h correctly' do
      seats = 3
      expect(BestSeatsPresenter.new(seats, available_seats.to_json).best_seats).to eq 'Best seats: h7, h6, h5'
    end
  end
end
