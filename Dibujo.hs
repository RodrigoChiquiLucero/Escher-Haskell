module Dibujo where

data Dibujo a =  Basica a 
               | Rotar (Dibujo a) 
               | Espejar (Dibujo a) 
               | Rot45 (Dibujo a)
               | Apilar Float Float (Dibujo a) (Dibujo a)
               | Juntar Float Float (Dibujo a) (Dibujo a)
               | Encimar (Dibujo a) (Dibujo a)

data Bas = T1 | T2 | TD | F | R

f :: Bas -> Bas
f x = T1

comp :: (a -> a) -> Int -> (a -> a)
comp f n = if n > 0 then f . comp f (n-1) else f


r180 :: Dibujo a -> Dibujo a
r180 x = comp Rotar 1 x

r270 :: Dibujo a -> Dibujo a
r270 x = comp Rotar 2 x

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio
figSobreOtra :: Dibujo a -> Dibujo a -> Dibujo a
figSobreOtra x y = Apilar 1 1 x y

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 x = Encimar (x) (Encimar (Rotar x) (Encimar (r180 x) (r270 x)))

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio
figAlLado :: Dibujo a -> Dibujo a -> Dibujo a
figAlLado x y = Juntar 1 1 x y

-- Superpone una figura con otra
superponeDosFig :: Dibujo a -> Dibujo a -> Dibujo a
superponeDosFig x y = Encimar x y

-- dada una figura la repite en cuatro cuadrantes
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto x y z w = figSobreOtra (figAlLado x y) (figAlLado z w)

-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!ciclar :: Dibujo a -> Dibujo a
ciclar :: Dibujo a -> Dibujo a
ciclar x = cuarteto x (Rotar x) (r180 x) (r270 x)

-- ver un a como una figura
pureDibe :: a -> Dibujo a
pureDibe x = Basica x

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basica x) = Basica (f x)
mapDib f (Rotar d) = Rotar $ mapDib f d
mapDib f (Espejar d) = Espejar $ mapDib f d
mapDib f (Rot45 d) = Rot45 $ mapDib f d
mapDib f (Encimar d h) = Encimar (mapDib f d) (mapDib f h)
mapDib f (Apilar n m d h) = Apilar n m (mapDib f d) (mapDib f h)
mapDib f (Juntar n m d h) = Juntar n m (mapDib f d) (mapDib f h)

cambia :: (a -> a) -> Dibujo a -> Dibujo a
cambia f x = mapDib f x



sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
sem bas rotar espejar rot45 apilar juntar encimar (Basica a) = bas a
sem bas rotar espejar rot45 apilar juntar encimar (Rotar d0) = rotar (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Espejar d0) = espejar (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Rot45 d0) = rot45 (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Encimar d0 d1) = encimar (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)
sem bas rotar espejar rot45 apilar juntar encimar (Apilar n m d0 d1) = apilar n m (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)
sem bas rotar espejar rot45 apilar juntar encimar (Juntar n m d0 d1) = juntar n m (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)

{-
cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
cambia f (Basica d) = f d
cambia f (Rotar d) = Rotar $ cambia f d
cambia f (Espejar d) = Espejar $ cambia f d
cambia f (Rot45 d) = Rot45 $ cambia f d
cambia f (Apilar n m d0 d1) = Apilar n m (cambia f d0) (cambia f d1)
cambia f (Juntar n m d0 d1) = Juntar n m (cambia f d0) (cambia f d1)
cambia f (Encimar d0 d1) = Encimar (cambia f d0) (cambia f d1)
-}

type Pred a = a -> Bool

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
