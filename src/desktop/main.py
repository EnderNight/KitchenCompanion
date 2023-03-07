import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk


class Handler:
    def onFoodButtonClicked(self, stack):
        stack.set_visible_child_name("foodsPage")

    def onAddFoodClicked(self, args):
        pass



builder = Gtk.Builder()
builder.add_from_file("main.glade")
builder.connect_signals(Handler())

window = builder.get_object("mainWindow")

listsList = builder.get_object("listsList")
listsList.add(Gtk.Label.new("Shopping list"))

foodsList = builder.get_object("foodsList")
foodsList.add(Gtk.Label.new("Foods list"))

window.connect("destroy", Gtk.main_quit)
window.show_all()

Gtk.main()
