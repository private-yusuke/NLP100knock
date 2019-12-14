from knock05 import n_gram

X = set(n_gram("paraparaparadise"))
Y = set(n_gram("paragraph"))

print("X or Y: {}".format(X | Y))
print("X and Y: {}".format(X & Y))
print("X - Y: {}".format(X - Y))
print("Y - X: {}".format(Y - X))
print("'se' in X?: {}".format("se" in X))
print("'se' in Y?: {}".format("se" in Y))