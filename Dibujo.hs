module Dibujo where

-- definir el lenguaje
--type Bas = ()

data Dibujo a =  Basica a 
               | Rotar (Dibujo a) 
               | Espejar (Dibujo a) 
               | Rot45 (Dibujo a)
               | Apilar Int Int (Dibujo a) (Dibujo a)
               | Juntar Int Int (Dibujo a) (Dibujo a)
               | Encimar (Dibujo a) (Dibujo a)
{-
type Bas = Trian1
ejemplo :: Dibujo Bas
ejemplo = (Basica Trian1)

interpBas :: Output Bas
interpBas Trian1 = trian1
-}




