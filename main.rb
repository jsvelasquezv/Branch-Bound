require_relative "modelo.rb"

modelo = Modelo.new
modelo.inicializar
modelo.calcular_solucion
solucion = modelo.solucion

# modelo2 = modelo.clone()
# modelo.agregar_restriccion(-1, "x14", 20)
# modelo.calcular_solucion
# solucion = modelo.solucion

# puts modelo.solucion
=begin
print modelo.restricciones
print modelo.RHS
modelo.agregar_restriccion(-1, "x14", 20)
print modelo.restricciones
print modelo.RHS
=end

# p modelo.z
# p modelo.solucion

problemas = []
no_entero = []

puts solucion

# solucion.each_with_index { |valor, indice| break if valor.modulo(1) != 0; no_entero[indice] = valor }

# puts solucion.select { |item| item.modulo(1) != 0}



# puts no_entero[0]
# puts no_entero[1]
# puts no_entero[2]

# restriccion1 = {"x#{no_entero[0]}" => -no_entero[1].ceil}
# restriccion2 = {"x#{no_entero[0]}" => no_entero[1].floor}

=begin
problema1 = modelo.clone()
problema2 = modelo.clone()

problema1.agregar_restriccion(-1, "x#{no_entero[0]}", -no_entero[1].ceil)
problema2.agregar_restriccion(1, "x#{no_entero[0]}", no_entero[1].floor)

problemas.push(problema1)
problemas.push(problema2)

problemas[0].calcular_solucion
problemas[1].calcular_solucion

puts problemas[0].solucion
puts problemas[1].solucion
=end



# puts restriccion1
# puts restriccion2
