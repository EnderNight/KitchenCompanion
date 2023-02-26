import sqlite3

def connect():
    print("Connecting to database...")
    con = sqlite3.connect("kitchenDB.db")

    print("Getting cursor...")
    cur = con.cursor()

    print("Connection sucessful.")
    return (cur, con)


def printHelp():
    print()
    print("Modes (Description, input): ")
    print("Quit => stops the program, 'quit'")

    # Foods
    print("List foods => lists saved food items, 'list foods'")
    print("Add food => adds a food item to the database, 'add food'")
    print("Update food => update a food item inside the database, 'update food'")
    print("Delete food => delete a food item inside the database, 'delete food'")
    print("Get food => get a food item info, 'get food'")

    # recipes
    print("List recipes => lists saved receipts, 'list receipts'")
    print("Add recipe => adds a receipt item to the database, 'add receipt'")
    print("Update recipe => update a receipt item inside the database, 'update receipt'")
    print("Delete recipe => delete a receipt item inside the database, 'delete receipt'")
    print("Get recipe => get a receipt item info, 'get receipt'")


def createFoodTable(cur):
    cur.execute('''
    CREATE TABLE IF NOT EXISTS foods(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    quantity REAL NOT NULL
    )
    ''')

def createRecipeTable(cur):
    cur.execute('''
    CREATE TABLE IF NOT EXISTS recipes(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
    )
    ''')


def addFood(con, cur):
    print()
    print("Add food mode")
    name = str(input("Enter the food's name: "))
    quantity = float(input("Enter the quantity: "))

    print()
    print(f"Adding ({quantity} {name}) inside 'food' table...")
    cur.execute('''
    INSERT INTO foods(name, quantity) VALUES(?,?)
    ''', (name, quantity,))
    con.commit()
    print("Done")
    print()

def addRecipe(con, cur):
    print()
    print("Add recipe mode")
    name = str(input("Enter the recipe's name: "))

    print()
    print(f"Adding ({name}) inside 'recipe' table...")
    cur.execute('''
    INSERT INTO recipes(name) VALUES(?)
    ''', (name,))
    con.commit()
    print("Done")
    print()

def listFood(cur):
    print()
    print("Listing remaining foods...")
    print()

    foods = cur.execute('''
    SELECT * FROM foods
    ''').fetchall()

    for food in foods:
        print(f"food {food[0]}: name => {food[1]} | quantity => {food[2]}")

    print("Done")
    print()

def listRecipe(cur):
    print()
    print("Listing saved recipes...")
    print()

    recipes = cur.execute('''
    SELECT * FROM recipes
    ''').fetchall()

    for recipe in recipes:
        print(f"recipe {recipe[0]}: name => {recipe[1]}")

    print("Done")
    print()


def main():
    mainLoop = True

    cur, con = connect()
    createFoodTable(cur)
    createRecipeTable(cur)


    while mainLoop:
        res = input("Enter a mode (enter 'help' for help): ")

        match res:
            case "help":
                printHelp()
            case "quit":
                mainLoop = False
            case "add food":
                addFood(con, cur) 
            case "list foods":
                listFood(cur)
            case "add recipe":
                addRecipe(con, cur)
            case "list recipes":
                listRecipe(cur)
            case _:
                print("Error: mode not recognized.")

    con.close()
















if __name__ == "__main__":
    main()
