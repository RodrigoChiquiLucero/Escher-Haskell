module Basico.Ejemplo where
import Dibujo
import Interp


ejemplo :: Dibujo ()
ejemplo = Basica ()

interpBas :: Output ()
interpBas () = rot45 fShape
--interpBas () = espejar fShape
--interpBas () = rotar fShape
--interpBas () = fShape