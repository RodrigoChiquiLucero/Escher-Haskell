
module Basico.Ejemplo where
import Dibujo
import Interp


ejemplo :: Dibujo Bas
--ejemplo = r180 $ pureDibe T1
--ejemplo = r270 $ pureDibe T1
--ejemplo = figSobreOtra (pureDibe T1) (pureDibe T2)
--ejemplo = encimar4 (pureDibe T1)
--ejemplo = figAlLado (pureDibe F) (pureDibe TD)
--ejemplo = superponeDosFig (pureDibe F) (pureDibe TD)
--ejemplo = cuarteto (r180(pureDibe F)) (pureDibe TD) (pureDibe F) (pureDibe TD)
--ejemplo = ciclar (pureDibe F)

a :: Bas
a = T2

t :: Dibujo Bas
t = (encimar4 (pureDibe a))

qqq :: Dibujo Bas --arriba der
qqq = superponeDosFig (pureDibe a) (superponeDosFig (Rot45 (pureDibe a)) (r180 (pureDibe a)))

yyy :: Dibujo Bas --arriba izq
yyy = Rotar qqq

ttt :: Dibujo Bas --abajo izq
ttt = Rotar yyy

www :: Dibujo Bas --abajo der
www = Rotar ttt

hola :: Dibujo Bas
hola = Juntar 1 1 ttt www

hola1 :: Dibujo Bas
hola1 = Apilar 333 667 t hola

hola2 :: Dibujo Bas
hola2 = Apilar 333 667 ttt hola

hola3 :: Dibujo Bas
hola3 = Apilar 3.33 6.67 www hola

esqAbajoIzq :: Dibujo Bas
esqAbajoIzq = Apilar 667 333 yyy (Apilar 333 333 ttt t)

esqAbajoDer :: Dibujo Bas
esqAbajoDer = Espejar esqAbajoIzq

abajo :: Dibujo Bas
abajo =  Juntar 9 1 esqAbajoIzq (Juntar 7 2 hola1 (Juntar 5 2 hola2 (Juntar 3 2 hola3 (Juntar 1 2 hola1 esqAbajoDer))))

arriba :: Dibujo Bas
arriba = r180 abajo

m1 :: Dibujo Bas
m1 = Juntar 667 333 (Apilar 5 5 yyy ttt) ttt

m3 :: Dibujo Bas
m3 = r180 m1

m2 :: Dibujo Bas
m2 = Espejar m3

m4 :: Dibujo Bas
m4 = Espejar m1

medio:: Dibujo Bas
medio = Juntar 3 7 (Juntar 4 3 (Apilar 1 1 m2 m1) t) (Apilar 1 1 m3 m4)

escher :: Dibujo Bas
escher = Apilar 7 3 arriba (Apilar 3 4 medio abajo) 

ejemplo = escher


interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan
