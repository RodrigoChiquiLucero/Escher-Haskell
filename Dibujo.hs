module Dibujo where

data Dibujo a =  Basica a 
               | Rotar (Dibujo a) 
               | Espejar (Dibujo a) 
               | Rot45 (Dibujo a)
               | Apilar Float Float (Dibujo a) (Dibujo a)
               | Juntar Float Float (Dibujo a) (Dibujo a)
               | Encimar (Dibujo a) (Dibujo a)

data Bas = T1 | T2 | TD | F | R deriving Show


comp :: (a -> a) -> Int -> (a -> a)
comp f n = if n > 0 then f . comp f (n-1) else f

r90 :: Dibujo a -> Dibujo a
r90 x = Rotar x

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

--Funcion para aplicar en cambia
f :: a -> Bas
f x = T1

--Le cambiamos el tipo a cambia porque no puede machear b con Dibujo b
cambia :: (a -> a) -> Dibujo a -> Dibujo a
cambia f x = mapDib f x
{-f d
cambia f (Rotar d) = Rotar $ cambia f d
cambia f (Espejar d) = Espejar $ cambia f d
cambia f (Rot45 d) = Rot45 $ cambia f d
cambia f (Encimar d0 d1) = Encimar (cambia f d0) (cambia f d1)
cambia f (Apilar n m d0 d1) = Apilar n m (cambia f d0) (cambia f d1)
cambia f (Juntar n m d0 d1) = Juntar n m (cambia f d0) (cambia f d1)

-}

sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) -> (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> (b -> b -> b) -> Dibujo a -> b
sem bas rotar espejar rot45 apilar juntar encimar (Basica a) = bas a
sem bas rotar espejar rot45 apilar juntar encimar (Rotar d0) = rotar (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Espejar d0) = espejar (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Rot45 d0) = rot45 (sem bas rotar espejar rot45 apilar juntar encimar d0)
sem bas rotar espejar rot45 apilar juntar encimar (Encimar d0 d1) = encimar (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)
sem bas rotar espejar rot45 apilar juntar encimar (Apilar n m d0 d1) = apilar n m (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)
sem bas rotar espejar rot45 apilar juntar encimar (Juntar n m d0 d1) = juntar n m (sem bas rotar espejar rot45 apilar juntar encimar d0) (sem bas rotar espejar rot45 apilar juntar encimar d1)


type Pred a = a -> Bool

instance Eq Bas where  
    T1 == T1 = True  
    T2 == T2 = True  
    R == R = True  
    F == F = True  
    TD == TD = True  
    _ == _ = False  

g :: Bas -> Bool
g a = a == T1

limpia :: Pred a -> a -> Dibujo a -> Dibujo a
limpia f a (Basica d) = if f d then (Basica a) else (Basica d)
limpia f a (Rotar d) = Rotar $ limpia f a d
limpia f a (Espejar d) = Espejar $ limpia f a d
limpia f a (Rot45 d) = Rot45 $ limpia f a d
limpia f a (Apilar n m d0 d1) = Apilar n m (limpia f a d0) (limpia f a d1)
limpia f a (Juntar n m d0 d1) = Juntar n m (limpia f a d0) (limpia f a d1)
limpia f a (Encimar d0 d1) = Encimar (limpia f a d0) (limpia f a d1)


-------Estos ejemplos se corren en ghci Main.hs------


{- alguna básica satisface el predicado
allDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
True
-}
anyDib :: Pred a -> Dibujo a -> Bool
anyDib f (Basica d) = f d
anyDib f (Rotar d) = anyDib f d
anyDib f (Espejar d) = anyDib f d
anyDib f (Rot45 d) = anyDib f d
anyDib f (Apilar n m d0 d1) = (anyDib f d0)|| (anyDib f d1)
anyDib f (Juntar n m d0 d1) = (anyDib f d0) || (anyDib f d1)
anyDib f (Encimar d0 d1) = (anyDib f d0) || (anyDib f d1)


{-todas las básicas satisfacen el predicado
allDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
False
-}
allDib :: Pred a -> Dibujo a -> Bool
allDib f (Basica d) = f d 
allDib f (Rotar d) = allDib f d
allDib f (Espejar d) = allDib f d
allDib f (Rot45 d) = allDib f d
allDib f (Apilar n m d0 d1) = (allDib f d0) && (allDib f d1)
allDib f (Juntar n m d0 d1) = (allDib f d0) && (allDib f d1)
allDib f (Encimar d0 d1) = (allDib f d0) && (allDib f d1)


basic_to_string :: Bas -> String
basic_to_string T1 = " Trian1 " 
basic_to_string T2 = " Trian2 "
basic_to_string TD = " TrianD "
basic_to_string R = " Rectang "
basic_to_string F = " FShape "
  
-- describe la figura. Ejemplos: 
--   desc (Basica b) (const "b") = "b"
--   desc (Rotar fa) db = "rot (" ++ desc fa db ++ ")"
-- la descripción de cada constructor son sus tres primeros
-- símbolos en minúscula.
desc :: (a -> String) -> Dibujo a -> String
desc f (Basica a) = f a 
desc f (Rotar d) = "rot (" ++ desc f d ++ ")"
desc f (Espejar d) = "esp (" ++ desc f d ++ ")"
desc f (Rot45 d) = "rot45 (" ++ desc f d ++ ")"
desc f (Apilar n m d0 d1) = "api ("++"(" ++ desc f d0 ++ ")" ++ "(" ++ desc f d1 ++ ")" ++ ")"
desc f (Juntar n m d0 d1) = "jun ("++"(" ++ desc f d0 ++ ")" ++ "(" ++ desc f d1 ++ ")" ++ ")"
desc f (Encimar d0 d1) = "enc (" ++ "(" ++ desc f d0 ++ ")" ++ "(" ++ desc f d1 ++ ")" ++ ")"

{-junta todas las figuras básicas de un dibujo
--every (cuarteto (pureDibe R) (pureDibe R) (pureDibe R) (r180 (pureDibe T1)))
--[R,R,R,T1]
-}
every :: Dibujo a -> [a]
every (Basica a) = [a]
every (Rotar d) = every d
every (Espejar d) = every d
every (Rot45 d) = every d
every (Apilar n m d0 d1) = (every d0) ++ (every d1)
every (Juntar n m d0 d1) = (every d0) ++ (every d1)
every (Encimar d0 d1) = (every d0) ++ (every d1)

--Funcion adicional: cuenta veces que aparece cada elem de una xs.
vecesAparece :: Eq a => [a] -> [(a, Int)]
vecesAparece [] = []
vecesAparece (x:xs) = (x, length(filter (== x) xs) + 1) : vecesAparece (filter (/= x) xs)

{- cuenta la cantidad de veces que aparecen las básicas en una figura.
contar  (cuarteto (pureDibe R) (pureDibe R) (pureDibe R) (r180 (pureDibe T1)))
[(R,3),(T1,1)]
-}

contar :: Eq a => Dibujo a -> [(a,Int)]
contar x = vecesAparece (every x)


{-
Hay 4 rotaciones seguidas (empezando en el tope):

esRot360 (Juntar 1 2  (Rotar (Rotar (Espejar (Rotar (Basica T1)))))) (Basica T1))
False

esRot360 ((Juntar 1 2  (Rotar (Rotar (Rotar (Rotar (Basica T1)))))) (Basica T1))
True
-}
esRot360 :: Pred (Dibujo a)
esRot360 (Basica a) = False
esRot360 (Rotar (Rotar (Rotar (Rotar d)))) = True
esRot360 (Rotar d) = esRot360 d
esRot360 (Espejar d) = esRot360 d
esRot360 (Rot45 d) = esRot360 d
esRot360 (Encimar d0 d1) = esRot360 d0 || esRot360 d1
esRot360 (Apilar n m d0 d1) = esRot360 d0 || esRot360 d1
esRot360 (Juntar n m d0 d1) = esRot360 d0 || esRot360 d1


{-
Hay 2 espejados seguidos (empezando en el tope):

esFlip2 (Juntar 1 1 (Espejar(Espejar (Basica T1))) (Basica T1))
True

esFlip2 (Juntar 1 1 (Espejar(Espejar (Rotar (Basica T1)))) (Basica T1))
True
-}
esFlip2 :: Pred (Dibujo a)
esFlip2 (Basica a) = False
esFlip2 (Rotar d) = esFlip2 d
esFlip2 (Espejar (Espejar d)) = True
esFlip2 (Espejar d) = esFlip2 d
esFlip2 (Rot45 d) = esFlip2 d
esFlip2 (Encimar d0 d1) = esFlip2 d0 || esFlip2 d1
esFlip2 (Apilar n m d0 d1) = esFlip2 d0 || esFlip2 d1
esFlip2 (Juntar n m d0 d1) = esFlip2 d0 || esFlip2 d1