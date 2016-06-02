require "simplex"

class Modelo

  attr_accessor :input, :cantidad_aldeas, :tipos_aviones, :hash_basico, :restricciones,
                :hash_variables, :funcion_objetivo, :RHS, :z, :solucion, :entero
                
  def initialize()
    @input = []
    @hash_basico = {} # Hash lleno de 0 para hacer merge con las restricciones
    @hash_variables = {} # Hash que contiene todas las variables de las restricciones
    @funcion_objetivo = [] # Arreglo con los coeficientes de la funcion objetivo
    @RHS = [] # Arreglo con los valores a la derecha de las desigualdades
    @restricciones = [] # Arreglo con los coeficientes de las restricciones

  end

  def inicializar(archivo)
    leerArchivo(archivo)

    @cantidad_aldeas = @input[0][0].to_i
    @tipos_aviones = @input[0][2].to_i

    iniciar_hash_basico
    iniciar_hash_variables

    obtenerFuncionObjetivo 
    obtenerRestricciones
    obtenerRHS
  end

  def calcular_solucion
    simplex = Simplex.new(@funcion_objetivo, @restricciones, @RHS)
    @solucion = simplex.solution
    calcular_z
    @entero = @solucion.all? { |variable| variable.modulo(1) == 0 }
  end

  def agregar_restriccion(coeficiente, variable, valor)
    restriccion = hash_basico
    restriccion[variable] = coeficiente
    @restricciones.push(restriccion.values)
    @RHS.push(valor)
  end

  private

  def leerArchivo(archivo)
    # File.open('archivo', 'r') do |f|
    #   f.each_line do |line|
    #     @input.push(line)
    #   end
    # end

     IO.foreach(archivo) {|x| @input.push(x) }
  end

  def obtenerFuncionObjetivo
    @funcion_objetivo = @input.slice(1, @input.size - 3).reduce(:+).tr("\n", ' ').split.map(&:to_f)
  end

  def obtenerRHS
    @RHS = @input.slice(@input.size - 2, @input.size - 1).reduce(:+).tr("\n", ' ').split.map(&:to_f)
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
    (@cantidad_aldeas * @tipos_aviones).times do |i|
      @hash_variables["x#{i}"] = 1
    end
  end

  def calcular_z
    @z = (0...@funcion_objetivo.count).inject(0) {|r, i| r + @funcion_objetivo[i] * @solucion[i]}
  end
end

# m = Modelo.new
# m.inicializar("input.txt")
# m.calcular_solucion
# p m.solucion