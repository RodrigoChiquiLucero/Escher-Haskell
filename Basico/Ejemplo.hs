module Basico.Ejemplo where
import Dibujo
import Interp
import Basico.Escher

ejemplo :: Escher
--ejemplo = r180 $ pureDibe T1
--ejemplo = r270 $ pureDibe T1
--ejemplo = figSobreOtra (pureDibe T1) (pureDibe T2)
--ejemplo = encimar4 (pureDibe T1)
--ejemplo = figAlLado (pureDibe F) (pureDibe TD)
--ejemplo = superponeDosFig (pureDibe F) (pureDibe TD)
--ejemplo = cuarteto (r180(pureDibe F)) (pureDibe TD) (pureDibe F) (pureDibe TD)
--ejemplo = ciclar (pureDibe F)

ejemplo = noneto p q r s t u v w x

interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan
