module Basico.Ejemplo where
import Dibujo
import Interp


ejemplo :: Dibujo ()
ejemplo = Basica ()

interpBas :: Output ()
--interpBas () = trian1
--interpBas () = apilar 1 1 fShape trian1
interpBas () = apilar 1 1 (juntar 1 1 fShape fShape) (juntar 1 1 fShape fShape) --cuarteto

--interpBas () = juntar 3 3 fShape trian1
--interpBas () = encimar fShape trian1
--interpBas () = rot45 fShape
--interpBas () = espejar fShape
--interpBas () = rotar fShape
--interpBas () = juntar 1 1 fShape fShape
 