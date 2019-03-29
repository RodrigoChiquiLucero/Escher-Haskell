module Dibujo where

data Dibujo a =  Basica a 
               | Rotar (Dibujo a) 
               | Espejar (Dibujo a) 
               | Rot45 (Dibujo a)
               | Apilar Float Float (Dibujo a) (Dibujo a)
               | Juntar Float Float (Dibujo a) (Dibujo a)
               | Encimar (Dibujo a) (Dibujo a)


comp :: (a -> a) -> Int -> (a -> a)
comp f n = if n > 0 then f . comp f (n-1) else f

pureDibe :: a -> Dibujo a
pureDibe x = Basica x

r180 :: Dibujo a -> Dibujo a
r180 x = Rotar (Rotar x)

r270 :: FloatingPic -> FloatingPic
r270 x = (comp rotar 2) x

{-
-- Pone una figura sobre la otra, ambas ocupan el mismo espacio
figSobreOtra :: FloatingPic -> FloatingPic -> FloatingPic
figSobreOtra x y = apilar 1 1 x y

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio
figAlLado :: FloatingPic -> FloatingPic -> FloatingPic
figAlLado x y = juntar 1 1 x y

-- Superpone una figura con otra
superponeDosFig :: FloatingPic -> FloatingPic -> FloatingPic
superponeDosFig x y = encimar x y

cuarteto :: FloatingPic -> FloatingPic -> FloatingPic -> FloatingPic -> FloatingPic
cuarteto x y z w = figSobreOtra (figAlLado x y) (figAlLado z w)

encimar4 :: FloatingPic -> FloatingPic
encimar4 x = encimar (x) (encimar (r90 x) (encimar (r180 x) (r270 x)))

ciclar :: FloatingPic -> FloatingPic
ciclar x = cuarteto x (r90 x) (r180 x) (r270 x)
-}

mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basica x) = Basica (f x)
mapDib f (Rotar d) = Rotar $ mapDib f d
mapDib f (Espejar d) = Espejar $ mapDib f d
mapDib f (Rot45 d) = Rot45 $ mapDib f d
mapDib f (Encimar d h) = Encimar (mapDib f d) (mapDib f h)
mapDib f (Apilar n m d h) = Apilar n m (mapDib f d) (mapDib f h)
mapDib f (Juntar n m d h) = Juntar n m (mapDib f d) (mapDib f h)





{-ESTO ES SEM

ACA ESTAMOS DEFINIENDO LA FUNCION
--a -> b    basica
--b -> b    rotar; espejar;rot45
-- (Int -> Int -> b -> b -> b)  APILAR
-- (Int -> Int -> b -> b -> b) JUNTAR 
-- (b -> b -> b) -> ENCIMAR 
--Dibujo a -> b    d



ACA ES PARA INVOCAR A LA FUNCION (COMO EN C, PARA QUE SE EJECUTE)
--sem bas rotar espejar rot45 apilar juntar encimar (Basica a) = bas a
													 (Rotar d) = rotar sem d
													 (Encimar d1 d2) = enc (sem d1) (sem d2)	

-}






-- composición n-veces de una función con sí misma.
--comp :: (a -> a) -> Int -> a -> a
--comp f n x = if n==0 then x else comp f (n-1) (f x)
--comp f n x = if n==0 then id else comp f (n-1) f



{-- rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r270 :: Dibujo a -> Dibujo a

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio
(///) :: Dibujo a -> Dibujo a -> Dibujo a

-- Superpone una figura con otra
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a

-- dada una figura la repite en cuatro cuadrantes
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
  
-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a 
  
-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
-}
