# README

This application determines the best available seats from a given JSON input of available seats and number of grouped seats needed.

Navigate to the root url and enter how many seats you need in the first form field and the available seats JSON in the second form field. The available seats JSON should be in the following format:

`{ 
 "venue": { 
 "layout": { 
 "rows": 10, 
 "columns": 50 
 } 
 }, 
 "seats": { 
 "a1": { 
 "id": "a1", 
 "row": "a", 
 "column": 1, 
 "status": "AVAILABLE" 
 }, 
 "b5": { 
 "id": "b5", 
 "row": "b", 
 "column": 5, 
 "status": "AVAILABLE" 
 }, 
 "h7": { 
 "id": "h7", 
 "row": "h", 
 "column": 7, 
 "status": "AVAILABLE" 
 } 
 } 
}`

There is also a link to a movie catalog where you can add and list movies, and edit / remove them as well.

To start the application locally, go to the project directory and run: `rails server`

To run all tests in the application, go to the project directory and run: `rspec spec`
