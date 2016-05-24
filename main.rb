require_relative "modelo.rb"

modelo = Modelo.new

p modelo.z
p modelo.solucion




# indice_cambio = 0
# solucion1.each do |e| 
#   if e.modulo(1) != 0  
#     indice_cambio = solucion1.index(e)
#     break
#   end
# end


# # restriccion1 = {"x#{indice_cambio}" => - solucion1[indice_cambio].ceil}
# # restriccion2 = {"x#{indice_cambio}" => solucion1[indice_cambio].floor}

# # puts restriccion1
# # puts restriccion2


# puts "Solucion: #{simplex.solution}"