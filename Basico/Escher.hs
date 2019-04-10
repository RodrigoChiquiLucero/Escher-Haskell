module Basico.Escher where
import Dibujo
import Interp

type Escher = Dibujo Bas

a :: Bas
a = T2

t :: Escher
t = (encimar4 (pureDibe a))

arribaDer :: Escher 
arribaDer = superponeDosFig (pureDibe a) (superponeDosFig (Rot45 (pureDibe a)) (r180 (pureDibe a)))

arribaIzq :: Escher 
arribaIzq = Rotar arribaDer

abajoIzq :: Escher 
abajoIzq = Rotar arribaIzq

abajoDer :: Escher 
abajoDer = Rotar abajoIzq

abaDerIzq :: Escher
abaDerIzq = Juntar 1 1 abajoIzq abajoDer

abaDerIzqT :: Escher
abaDerIzqT = Apilar 333 667 t abaDerIzq

abaDerIzqI :: Escher
abaDerIzqI = Apilar 333 667 abajoIzq abaDerIzq

abaDerIzqD :: Escher
abaDerIzqD = Apilar 333 667 abajoDer abaDerIzq

esqAbajoIzq :: Escher
esqAbajoIzq = Apilar 667 333 arribaIzq (Apilar 333 333 abajoIzq t)

v :: Escher
v = Juntar 667 333 esqAbajoIzq abaDerIzqT

x :: Escher
x = Rotar v

r :: Escher
r = Rotar x

p :: Escher
p = Rotar r

w :: Escher
w = Juntar 1 1 abaDerIzqI abaDerIzqD

q :: Escher
q = Espejar (r180 w)

u :: Escher
u = Rotar w

s :: Escher
s = Espejar u

noneto p q r s t u v w x =  Apilar 7 3 (Juntar 7 3 p (Juntar 3 4 q r)) (Apilar 3 4 (Juntar 7 3 s (Juntar 3 4 t u)) (Juntar 7 3 v (Juntar 3 4 w x)))