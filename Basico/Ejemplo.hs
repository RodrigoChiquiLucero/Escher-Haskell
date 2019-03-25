module Basico.Ejemplo where
import Dibujo
import Interp


ejemplo :: Dibujo ()
ejemplo = Basica ()

interpBas :: Output ()
--interpBas () = trian1
--interpBas () = juntar 3 3 fShape trian1
--interpBas () = encimar fShape trian1
--interpBas () = rot45 fShape
--interpBas () = espejar fShape
--interpBas () = rotar fShape
--interpBas () = (comp (rotar) 2) fShape
interpBas () = r180 (simple fShape)
