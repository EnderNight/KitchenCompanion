from PyQt6.QtWidgets import QApplication, QMainWindow
from PyQt6 import uic



class MainWindow(QMainWindow):
    def __init__(self)  -> None:
        super().__init__()
        uic.loadUi("mainwindow.ui", self)



if __name__ == "__main__":
    app = QApplication([])
    window = MainWindow()
    window.show()
    app.exec()
