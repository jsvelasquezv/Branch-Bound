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

# p solucion

no_entero[0] = solucion.each_with_index { |valor, indice| break valor if valor.modulo(1) != 0}
no_entero[1] = solucion.find_index(no_entero[0])
# p no_entero


problema1 = Marshal.load(Marshal.dump(modelo))
problema2 = Marshal.load(Marshal.dump(modelo))
# problema1.inicializar
# problema2 = Modelo.new
# problema2.inicializar

# p problema1.restricciones
# puts "\n"

problema1.agregar_restriccion(-1, "x#{no_entero[1]}", -no_entero[0].ceil)
problema2.agregar_restriccion(1, "x#{no_entero[1]}", no_entero[0].floor)

# p problema1.restricciones

# p problema1.restricciones
# p problema1.RHS
# puts "\n"
problema1.calcular_solucion
problema2.calcular_solucion

p problema1.solucion
puts problema1.z
p problema2.solucion
puts problema2.z

# problemas.push(problema1)
# problemas.push(problema2)

# problemas[0].calcular_solucion
# problemas[1].calcular_solucion

# p problemas[0].solucion
# p problemas[1].solucion

# puts restriccion1
# puts restriccion2
