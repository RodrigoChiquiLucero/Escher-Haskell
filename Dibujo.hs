module Dibujo where
import Data.Functor.Classes
import Data.Either


data Dibujo a =  Basica a 
               | Rotar (Dibujo a) 
               | Espejar (Dibujo a) 
               | Rot45 (Dibujo a)
               | Apilar Float Float (Dibujo a) (Dibujo a)
               | Juntar Float Float (Dibujo a) (Dibujo a)
               | Encimar (Dibujo a) (Dibujo a)
               deriving Show


data Bas = T1 | T2 | TD | F | R | B deriving Show

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
cuarteto x y z w = figSobreOtra (figAlLado x y) (figAlLado w z)

-- cuadrado con la misma figura rotada $i$ por $90$ para $i \in \{1..3\}$.
-- No confundir con encimar4!ciclar :: Dibujo a -> Dibujo a
ciclar :: Dibujo a -> Dibujo a
ciclar x = cuarteto (Rotar x) x (r180 x) (r270 x)

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
cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
cambia f (Basica d) = f d
cambia f (Rotar d) = Rotar $ cambia f d
cambia f (Espejar d) = Espejar $ cambia f d
cambia f (Rot45 d) = Rot45 $ cambia f d
cambia f (Encimar d0 d1) = Encimar (cambia f d0) (cambia f d1)
cambia f (Apilar n m d0 d1) = Apilar n m (cambia f d0) (cambia f d1)
cambia f (Juntar n m d0 d1) = Juntar n m (cambia f d0) (cambia f d1)

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
limpia p a d = cambia g d 
    where g d' = if p d' then (Basica a) else (Basica d')


-------Estos ejemplos se corren en ghci Main.hs------
{- alguna básica satisface el predicado
allDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
True
-}

anyDib :: Pred a -> Dibujo a -> Bool
anyDib f d = sem b r e r45 ap j en d
    where b a = f a
          r a = a
          e a = a
          r45 a = a
          ap x y a b = a || b
          j x y a b = a || b
          en a b = a || b 

{-todas las básicas satisfacen el predicado
allDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
False
-}

allDib :: Pred a -> Dibujo a -> Bool
allDib f d = sem b r e r45 ap j en d
    where b a = f a
          r a = a
          e a = a
          r45 a = a
          ap x y a b = a && b
          j x y a b = a && b
          en a b = a && b 


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
--desc basic_to_string (cuarteto (pureDibe R) (pureDibe R) (pureDibe R) (r180 (pureDibe T1)))
--"api ((junt (( Rectang )( Rectang )))(junt (( Rectang )(rot (rot ( Trian1 ))))))"

desc :: (a -> String) -> Dibujo a -> String
desc f d = sem b r e r45 ap j en d
    where b a = f a
          r a = "rot (" ++ a ++ ")"
          e a = "esp (" ++ a ++ ")"
          r45 a = "rot45 (" ++ a ++ ")" 
          ap x y a b = "api ((" ++ a ++ ")" ++ "(" ++ b ++ "))"
          j x y a b = "junt ((" ++ a ++ ")" ++ "(" ++ b ++ "))"
          en a b = "enc ((" ++ a ++ ")" ++ "(" ++ b ++ "))"
{-junta todas las figuras básicas de un dibujo
--every (cuarteto (pureDibe R) (pureDibe R) (pureDibe R) (r180 (pureDibe T1)))
--[R,R,R,T1]
-}

every :: Dibujo a -> [a]
every d = sem b r e r45 ap j en d
    where b a = [a]
          r a = a
          e a = a
          r45 a = a
          ap x y a b = a ++ b 
          j x y a b = a ++ b
          en a b = a ++ b 

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
esRot360 (Juntar 1 2  (Rotar (Rotar (Espejar (Rotar (Basica T1))))) (Basica T1))
False
esRot360 (Juntar 1 2  (Rotar (Rotar (Rotar (Rotar (Basica T1))))) (Basica T1))
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
esFlip2 (Juntar 1 1 (Espejar(Basica T1)) (Basica T1))
False
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
-- la cadena que se toma como parámetro es la descripción
-- del error.

check :: Pred (Dibujo a) -> String -> Dibujo a -> Either String (Dibujo a)
check p s a = if p a then Left s else Right a

--check esRot360 "Tiene 4 rotaciones" (Juntar 1 2  (Rotar (Rotar (Espejar (Rotar (Basica T1))))) (Basica T1)) #False
--check esRot360 "Tiene 4 rotaciones" (Juntar 1 2  (Rotar (Rotar (Rotar (Rotar (Basica T1))))) (Basica T1)) #True

--Devuelve el Dibujo si no tiene 360s o Flips dentro
--todoBien (Juntar 1 2  (Rotar (Rotar (Rotar (Rotar (Basica T1))))) (Espejar (Espejar (Basica T1)))) #Te devuelve los errores

todoBien :: Dibujo a -> Either [String] (Dibujo a)
todoBien d = if isLeft (check esRot360 "360" d) || isLeft (check esFlip2 "Flip" d) 
            then Left (lefts ((check esFlip2 "Flip" d):(check esRot360 "360" d):[]))
            else Right d

--Devuelve el Dibujo sin las rotaciones
noRot360 :: Dibujo a -> Dibujo a
noRot360 (Basica a) = Basica a
noRot360 (Rotar (Rotar (Rotar (Rotar d)))) = d
noRot360 (Rotar d) = Rotar (noRot360 d)
noRot360 (Espejar d) = Espejar (noRot360 d)
noRot360 (Rot45 d) = Rot45 (noRot360 d)
noRot360 (Encimar d0 d1) = Encimar (noRot360 d0) (noRot360 d1)
noRot360 (Apilar n m d0 d1) = Apilar n m (noRot360 d0) (noRot360 d1)
noRot360 (Juntar n m d0 d1) = Juntar n m (noRot360 d0) (noRot360 d1)

--noRot360 (Juntar 1 2  (Rotar (Rotar (Rotar (Rotar (Basica T1))))) (Basica T1)) 
--Devuelve el Dibujo sin los Flips

noFlip2 :: Dibujo a -> Dibujo a
noFlip2 (Basica a) = Basica a
noFlip2 (Espejar (Espejar d)) = d
noFlip2 (Rotar d) = Rotar (noFlip2 d)
noFlip2 (Espejar d) = Espejar (noFlip2 d)
noFlip2 (Rot45 d) = Rot45 (noFlip2 d)
noFlip2 (Encimar d0 d1) = Encimar (noFlip2 d0) (noFlip2 d1)
noFlip2 (Apilar n m d0 d1) = Apilar n m (noFlip2 d0) (noFlip2 d1)
noFlip2 (Juntar n m d0 d1) = Juntar n m (noFlip2 d0) (noFlip2 d1)
--noFlip2 (Juntar 1 1 (Espejar(Espejar (Basica T1))) (Basica T1))


























