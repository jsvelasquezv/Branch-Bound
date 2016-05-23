class Modelo

  attr_accessor :input, :cantidad_aldeas, :tipos_aviones, :hash_basico, :restricciones,
                :hash_variables, :funcion_objetivo, :RHS

  def initialize()
    @input = []
    @hash_basico = {} # Hass lleno de 0 para hacer merge con las restricciones
    @hash_variables = {} # Hash que contiene todas las variables de las restricciones
    @funcion_objetivo = [] # Arreglo con los coeficientes de la funcion objetivo
    @RHS = [] # Arreglo con los valores a la derecha de las desigualdades
    @restricciones = [] # Arreglo con los coeficientes de las restricciones
    @modelo = [] # Arreglo que contiene: funcion objetivo, restricciones, RHS

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