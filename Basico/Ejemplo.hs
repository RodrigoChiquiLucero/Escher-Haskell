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
ejemplo = ciclar (pureDibe F)

interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan