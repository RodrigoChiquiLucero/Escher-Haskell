
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

--Escher--
--Este es el MedioT
a :: Bas
a = T2

t :: Dibujo Bas
t = (encimar4 (pureDibe a))

--Este es el 3
u :: Dibujo Bas
u = figSobreOtra (superponeDosFig (pureDibe a) (superponeDosFig (Rot45 (pureDibe a)) (r180 (pureDibe a)))) (r270(superponeDosFig (pureDibe a) (superponeDosFig (Rot45 (pureDibe a)) (r180 (pureDibe a)))))

--Este es el el T chiquito abajo y el 3 grande arriba
c :: Dibujo Bas
c = Apilar 3 7 u t

--Este es el 3 rotado, va abajo
h :: Dibujo Bas
h = r270 u

--Este es el T grande arriba y el 3 abajo
d :: Dibujo Bas
d = Apilar 3 7 t h

--Este es el X :cara_ligeramente_sonriente:
esqInfX :: Dibujo Bas
esqInfX = Juntar 3 7 d c

--Este es el V :cara_ligeramente_sonriente:
esqInfV :: Dibujo Bas
esqInfV = r270 esqInfX

--Este es el R :cara_ligeramente_sonriente:
esqSupR :: Dibujo Bas
esqSupR = r90 esqInfX

--Este es la P :cara_ligeramente_sonriente:
esqSupP :: Dibujo Bas
esqSupP = r180 esqInfX

medioV :: Dibujo Bas
medioV = Juntar 3 7 u (Apilar 1 1 u u)

medioW :: Dibujo Bas
medioW = (r270 (medioV))

medioS :: Dibujo Bas
medioS = (r180 (medioV))

medioQ :: Dibujo Bas
medioQ = r90 (medioV)

medioSTV :: Dibujo Bas
medioSTV = Juntar 6 2 medioS (Juntar 3 5 t medioV)

infVWX :: Dibujo Bas
infVWX = Juntar 6 2 esqInfV (Juntar 3 5 medioW esqInfX)

supPQR :: Dibujo Bas
supPQR = Juntar 6 2 esqSupP (Juntar 3 5 medioQ esqSupR)

escher :: Dibujo Bas
escher = Apilar 6 2 supPQR (Apilar 3 5 medioSTV infVWX)

ejemplo = escher
--superponeDosFig (pureDibe T2) (superponeDosFig (Rot45 (pureDibe T2)) (r180 (pureDibe T2)))

interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan
