import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

builder = Gtk.Builder()
builder.add_from_file("main.glade")

window = builder.get_object("mainWindow")
window.connect("destroy", Gtk.main_quit)
window.show_all()

Gtk.main()
