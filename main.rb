require "simplex"
require_relative "modelo.rb"

modelo = Modelo.new

carga = modelo.cargar

funcion_objetivo = carga[0]
restricciones = carga[1]
rhs = carga[2]

simplex = Simplex.new(funcion_objetivo, restricciones, rhs)

puts "Solucion: #{simplex.solution}"