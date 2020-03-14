#Bitcoin in the Big Data Era - Assignment 3 (Path within a Network)

def numEdges(a, b, c, d, e, f, g):
    print((a + b + c + d + f + g) + (a * e) + (b * e) + (c * e) + (c * f) + (d * f) + (e * g))

def numPaths(a, b, c, d, e, f, g):
    print(g * e * (a + b + c) + f * (c + d), end='') #end='' exists so that the program does not print unnecessary new line

a = int(input())
b = int(input())
c = int(input())
d = int(input())
e = int(input())
f = int(input())
g = int(input())

numEdges(a, b, c, d, e, f, g)
numPaths(a, b, c, d, e, f, g)
