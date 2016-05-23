
# a = [10, 8, 6, 9, 12, 5, 3, 8, 4, 10, 7, 9, 6, 10, 4] #coeficientes de la funcion objetivo
# b = Array.new(a.size, 0)

a = {x11: 10, x12: 8, x13: 6, x14: 9, x15: 12, 
     x21: 5, x22: 3, x23: 8, x24: 4, x25: 10,
     x31: 7, x32: 9, x33: 6, x34: 10, x35: 4}

b = {x11: 0, x12: 0, x13: 0, x14: 0, x15: 0, 
     x21: 0, x22: 0, x23: 0, x24: 0, x25: 0,
     x31: 0, x32: 0, x33: 0, x34: 0, x35: 0}

c = {x21: 5, x22: 3, x23: 8, x24: 4, x25: 10}

d = {x15: 12, x25: 10, x35: 4}

z = {"x0" => 10, "x1" => 8, "x2" => 6, "x3" => 9, "x4" => 12, 
     "x5" => 5, "x6" => 3, "x7" => 8, "x8" => 4, "x9" => 10,
     "x10" => 7, "x11" => 9, "x12" => 6, "x13" => 10, "x14" => 4}

input = []
File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    input.push(line)
  end
end

=begin    
  Eliminamos la primera y las 2 ultimas lineas para dejar solo los coeficientes
  de la funcion objetivo, luego los combinamos en un string y eliminamos los saltos
  de linea para volverlo a convertir en un array de numeros
=end

funcion_objetivo = input.slice(1, input.size - 3).reduce(:+).tr("\n", ' ').split.map(&:to_i)

RHS = input.slice(input.size - 2, input.size - 1).reduce(:+).tr("\n", ' ').split.map(&:to_i)

# p funcion_objetivo
# p RHS
# puts input

cantidad_aldeas = input[0][0].to_i
tipos_aviones = input[0][2].to_i

hash_basico = {}

(cantidad_aldeas*tipos_aviones).times do |i|
  hash_basico["x#{i}"] = 0
end

restriccion = {} # Variable temporal donde se almacena la restriccion actual
restricciones_verticales = []
restricciones_horizontales = []
restricciones = [] # Variable donde se almacenan todas las restricciones

# Variable donde se almacenan las restricciones la funcion obejtivo y
# los RHS listo para crear el objeto de tipo Simplex
modelo = [] 

tipos_aviones.times do |i|
  cantidad_aldeas.times do |j|
    indice = "x#{(i+j)+(tipos_aviones * j - j)}"
    restriccion[indice] = z[indice]
  end
  restricciones_verticales.push(restriccion)
  restriccion = {}
end

cantidad_aldeas.times do |i|
  tipos_aviones.times do |j|
    restriccion["x#{j+(tipos_aviones * i)}"] = z["x#{j+(tipos_aviones * i)}"]
  end
  restricciones_horizontales.push(restriccion)
  restriccion = {}
end

cantidad_aldeas.times do |i|
  restricciones.push(hash_basico.merge(restricciones_horizontales[i]).values)
end

tipos_aviones.times do |i|
  restricciones.push(hash_basico.merge(restricciones_verticales[i]).values)  
end

modelo[0] = funcion_objetivo
modelo[1] = restricciones
modelo[2] = RHS

class Modelo

  attr_accessor :input, :cantidad_aldeas, :tipos_aviones, :hash_basico, :restricciones,
                :hash_variables, :funcion_objetivo, :RHS

  def initialize()
    @input = []
    @hash_basico = {}
    @hash_variables = {}
    @funcion_objetivo = []
    @RHS = []
    @restricciones = []
    @modelo = []


    leerArchivo

    @cantidad_aldeas = @input[0][0].to_i
    @tipos_aviones = @input[0][2].to_i

    iniciar_hash_basico
    iniciar_hash_variables
  end

  def cargar
    return obtenerFuncionObjetivo, obtenerRestricciones, obtenerRHS
  end

  private

  def leerArchivo
    File.open('input.txt', 'r') do |f|
      f.each_line do |line|
        @input.push(line)
      end
    end
  end

  def obtenerFuncionObjetivo
    @funcion_objetivo = @input.slice(1, @input.size - 3).reduce(:+).tr("\n", ' ').split.map(&:to_i)
  end

  def obtenerRHS
    @RHS = @input.slice(@input.size - 2, @input.size - 1).reduce(:+).tr("\n", ' ').split.map(&:to_i)
  end

  def obtenerRestricciones
    restriccion = {} # Variable temporal donde se almacena la restriccion actual
    restricciones_verticales = []
    restricciones_horizontales = []

    @tipos_aviones.times do |i|
      @cantidad_aldeas.times do |j|
        indice = "x#{(i+j)+(@tipos_aviones * j - j)}"
        restriccion[indice] = hash_variables[indice]
      end
      restricciones_verticales.push(restriccion)
      restriccion = {}
    end

    @cantidad_aldeas.times do |i|
      @tipos_aviones.times do |j|
        restriccion["x#{j+(@tipos_aviones * i)}"] = hash_variables["x#{j+(@tipos_aviones * i)}"]
      end
      restricciones_horizontales.push(restriccion)
      restriccion = {}
    end

    @cantidad_aldeas.times do |i|
      @restricciones.push(hash_basico.merge(restricciones_horizontales[i]).values)
    end

    @tipos_aviones.times do |i|
      @restricciones.push(hash_basico.merge(restricciones_verticales[i]).values)  
    end
    return @restricciones
  end

  def iniciar_hash_basico
    (@cantidad_aldeas * @tipos_aviones).times do |i|
      @hash_basico["x#{i}"] = 0
    end
  end

  def iniciar_hash_variables
    variables = input.slice(1, @input.size - 3).reduce(:+).tr("\n", ' ').split.map(&:to_i)
    (@cantidad_aldeas * @tipos_aviones).times do |i|
      @hash_variables["x#{i}"] = variables[i]
    end
  end

end

modelo = Modelo.new

puts modelo.cargar == modelo2
