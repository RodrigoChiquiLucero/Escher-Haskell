module Basico.Ejemplo where
import Dibujo
import Interp
import Basico.Escher

ejemplo :: Dibujo Bas
--ejemplo = r180 $ pureDibe T1
--ejemplo = r270 $ pureDibe T1
--ejemplo = figSobreOtra (pureDibe T1) (pureDibe T2)
--ejemplo = encimar4 (pureDibe T1)
--ejemplo = figAlLado (pureDibe F) (pureDibe TD)
--ejemplo = superponeDosFig (pureDibe F) (pureDibe TD)
--ejemplo = (cuarteto ((pureDibe F)) (pureDibe TD) (pureDibe R) (pureDibe T2))
--ejemplo = cuarteto (pureDibe F) (pureDibe B) (Rotar (pureDibe R)) (pureDibe T2)
--ejemplo = lado 3 (pureDibe T2)
--ejemplo = dibujo_t (pureDibe T2)
--ejemplo = r270(pureDibe F)
--ejemplo = esquina 2 (pureDibe T2)
--ejemplo = escher 2 T2
--ejemplo = cambia f_cambia_a_triangulo (cuarteto ((pureDibe F)) (pureDibe TD) (pureDibe R) (pureDibe T2))
--ejemplo = limpia f_predicado F (cuarteto ((pureDibe F)) (pureDibe T1) (pureDibe R) (pureDibe T2))
ejemplo = escher 5 T2



interpBas :: Output Bas
interpBas T1 = trian1 
interpBas T2 = trian2
interpBas TD = trianD
interpBas F = fShape
interpBas R = rectan
interpBas B = blanco
