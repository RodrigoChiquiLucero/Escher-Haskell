module Basico.Ejemplo where
import Dibujo
import Interp


ejemplo :: Dibujo ()
ejemplo = Basica ()

--let empty = Basica ()
interpBas :: Output ()
--interpBas () = trian1
--interpBas () = juntar 3 3 fShape trian1
--interpBas () = apilar 1 1 fShape trian1
--interpBas () = encimar fShape trian1
--interpBas () = rot45 fShape
--interpBas () = espejar fShape
--interpBas () = rotar fShape
--interpBas () = (comp (rotar) 2) fShape
--interpBas () = r180 ejemplo
--interpBas () = apilar 1 1 trian1 (juntar 3 3 (espejar (rot45 fShape)) trian1)
interpBas () = r180 trian1
