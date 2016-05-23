require 'simplex'

=begin

  max 3x +  2y
  
  Sujeto a:

    x + 2y <= 6
    2x + y <= 8
    -x + y <= 1
         y <= 2
     x, y >= 0

=end

simplex = Simplex.new(
  [3, 2], #coeficientes de la funcion objetivo
  [
    [1, 2], # Coeficientes de las restricciones
    [2, 1],
    [-1, 1],
    [0, 1]
  ],
  [6, 8, 1, 2] #RHS de las restricciones
)

simplex2 = Simplex.new(
  [10, 8, 6, 9, 12, 5, 3, 8, 4, 10, 7, 9, 6, 10, 4], #coeficientes de la funcion objetivo
  [
    [10, 8, 6, 9, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # Coeficientes de las restricciones
    [0, 0, 0, 0, 0, 5, 3, 8, 4, 10, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 9, 6, 10, 4],
    [10, 0, 0, 0, 0, 5, 0, 0, 0, 0, 7, 0, 0, 0, 0],
    [0, 8, 0, 0, 0, 0, 3, 0, 0, 0, 0, 9, 0, 0, 0],
    [0, 0, 6, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6, 0, 0],
    [0, 0, 0, 9, 0, 0, 0, 0, 4, 0, 0, 0, 0, 10, 0],
    [0, 0, 0, 0, 12, 0, 0, 0, 0, 10, 0, 0, 0, 0, 4]
  ],
  [50, 90, 60, 100, 80, 70, 40, 20] #RHS de las restricciones
)



=begin
while simplex.can_improve?
  puts simplex.formatted_tableau
  puts "\n"
  simplex.pivot
end
=end



puts "Solucion: #{simplex2.solution}"