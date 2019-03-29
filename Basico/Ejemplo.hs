module Basico.Ejemplo where
import Dibujo
import Interp

data Bas = T1 | T2 | TD | F | R
ejemplo :: Dibujo Bas
--ejemplo = r180 $ pureDibe ()
--ejemplo = r270 $ pureDibe T1
--ejemplo = figSobreOtra (pureDibe T1) (pureDibe T2)
--ejemplo = encimar4 (pureDibe T1)
--ejemplo = figAlLado (pureDibe F) (pureDibe TD)
--ejemplo = superponeDosFig (pureDibe F) (pureDibe TD)
--ejemplo = cuarteto (pureDibe F) (pureDibe TD) (pureDibe F) (pureDibe TD)
--ejemplo = ciclar (pureDibe F)


interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan

{-
interpBas () = juntar 3 3 fShape trian1
interpBas () = apilar 1 1 fShape trian1
interpBas () = encimar fShape trian1
interpBas () = rot45 fShape
interpBas () = espejar fShape
interpBas () = rotar fShape
interpBas () = (comp (rotar) 2) fShape
interpBas () = r180 ejemplo
interpBas () = apilar 1 1 trian1 (juntar 3 3 (espejar (rot45 fShape)) trian1)
interpBas () = r180 trian1
interpBas () = r270 fShape
interpBas () = r90 fShape
interpBas () = cuarteto fShape trian1 trian2 fShape
interpBas () = encimar4 trian1
interpBas () = figSobreOtra fShape trian2
interpBas () = figAlLado fShape trian2
interpBas () = superponeDosFig fShape trian1
interpBas () = ciclar fShape
interpBas () = pureDibe trian1
cuarteto y encimar4 como ejemplos 
interpBas () = apilar 1 1 (juntar 1 1 fShape fShape) (juntar 1 1 fShape fShape) --cuarteto
interpBas () = encimar (rotar fShape) (encimar ((comp (rotar) 1) fShape) (encimar ((comp (rotar) 2) fShape) ((comp (rotar) 3) fShape)))  -- encimar4
interpBas () = r180 (pureDibe trian1)
-}
