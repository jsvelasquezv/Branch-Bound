# require "tree"
require "gtk3"
require_relative "modelo.rb"

archivo = ""
solucion = ""

# def crear_restriccion(modelo)
#   no_entero = []
#   no_entero[0] = modelo.solucion.each_with_index { |valor, indice| break valor if valor.modulo(1) != 0}
#   no_entero[1] = modelo.solucion.find_index(no_entero[0])
#   return no_entero
# end

# def hijo_izquierdo(arbol, indice)
#   return arbol[2 * indice + 1]
# end

# def hijo_izquierdo(arbol, indice)
#   return arbol[2 * indice + 2]
# end

# def padre(arbol, indice)
#   return arbol[((indice - 1) / 2).ceil]
# end

# def crear_problema(problema)
#   problema = Marshal.load(Marshal.dump(problema))
#   return problema
# end

# problemas[0] = modelo
# restriccion = crear_restriccion(modelo)
# indice = 0

# 2.times do
#   if restriccion.empty?
#     break
#   else
#     restriccion = crear_restriccion(problemas[indice])

#     problemas.push(crear_problema(problemas[indice]))
#     problemas.push(crear_problema(problemas[indice]))

#     problemas[2 * indice + 1].agregar_restriccion(-1, "x#{restriccion[1]}", -restriccion[0].ceil)
#     problemas[2 * indice + 2].agregar_restriccion(1, "x#{restriccion[1]}", restriccion[0].floor)

#     problemas[2 * indice + 1].calcular_solucion
#     problemas[2 * indice + 2].calcular_solucion

#     puts "raiz"
#     p problemas[indice].RHS
#     puts "izquierdo"
#     p problemas[indice+1].RHS
#     puts "derecho"
#     p problemas[indice+2].RHS
#     puts "iteracion #{indice}"
#   end
#   indice += 1
# end

# puts problemas


# arbol = Tree::TreeNode.new("P0", modelo)
# # arbol << Tree::TreeNode.new("P1", crear_problema(modelo))
# # arbol << Tree::TreeNode.new("P2", crear_problema(modelo))
# arbol.print_tree
# indice = 1
# arbol.breadth_each {|nodo| nodo << Tree::TreeNode.new("P#{indice}", crear_problema(modelo)); i+=1}
# arbol.print_tree

# arbol["P1"].content.agregar_restriccion(-1, "x#{no_entero[1]}", -no_entero[0].ceil)
# arbol["P1"].content.calcular_solucion
# p arbol["P1"].content.RHS

# arbol["P2"].content.agregar_restriccion(1, "x#{no_entero[1]}", no_entero[0].floor)
# arbol["P2"].content.calcular_solucion
# p arbol["P2"].content.RHS

# modelo = Modelo.new
# modelo.inicializar(archivo)
# modelo.calcular_solucion
# solucion = modelo.solucion

app = Gtk::Application.new("org.gtk.example", :flags_none)

app.signal_connect "activate" do |application|
  window = Gtk::ApplicationWindow.new(application)
  window.set_title("Window")
  window.set_default_size(300, 300)

  button_box = Gtk::ButtonBox.new(:horizontal)
  window.add(button_box)

  dialog = Gtk::FileChooserDialog.new("Seleccionar archivo", window, Gtk::FileChooserAction::OPEN,
   [Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL], [Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT])
  
  button = Gtk::Button.new(label: "Cargar")
  button2 = Gtk::Button.new(label: "Resolver")
  label = Gtk::Label.new "The only victory over love is flight."
  
  
  button.signal_connect "clicked" do |widget|
    if dialog.run == Gtk::ResponseType::ACCEPT
      puts archivo = File.basename(dialog.filename)
    end
    dialog.destroy
  end

  
  button2.signal_connect "clicked" do |widget|
    modelo = Modelo.new
    modelo.inicializar(archivo)
    modelo.calcular_solucion
    p modelo.solucion
    puts modelo.z

    # md = Gtk::MessageDialog.new(window, nil, :type => :info, :buttons_type => :close, 
    #   :message => "Download completed")
  end

  button_box.add(button)
  button_box.add(button2)

  window.show_all
end

puts app.run
