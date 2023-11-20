greeting = "Testing Python inside jenkins"

def say_hello():
    sayIt = "Hello"
    return sayIt 

say_hello()

def getingHello():
    getSay = say_hello()
    if getSay == "Hello":
        print(f"Probando Geting {getSay} and then ", getSay, greeting)

getingHello()