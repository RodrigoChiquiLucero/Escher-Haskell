module Interp where
import Graphics.Gloss
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Geometry.Angle
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo
type FloatingPic = Vector -> Vector -> Vector -> Picture
type Output a = a -> FloatingPic
-- type Output a = a -> (Vector -> Vector -> Vector -> Picture)
-- el vector nulo
zero :: Vector
zero = (0,0)

half :: Vector -> Vector
half = (0.5 V.*)

-- comprender esta función es un buen ejericio.
hlines :: Vector -> Float -> Float -> [Picture]
hlines v@(x,y) mag sep = map (hline . (*sep)) [0..]
  where hline h = line [(x,y+h),(x+mag,y+h)] 

-- Una grilla de n líneas, comenzando en v con una separación de sep y
-- una longitud de l (usamos composición para no aplicar este
-- argumento)
grid :: Int -> Vector -> Float -> Float -> Picture
grid n v sep l = pictures [ls,translate 0 (l*toEnum n) (rotate 90 ls)]
  where ls = pictures $ take (n+1) $ hlines v sep l

-- figuras adaptables comunes
blanco :: FloatingPic
blanco a b c = blank

(x,y) .+ (x',y') = (x+x',y+y')
s .* (x,y) = (s*x,s*y)
(x,y) .- (x',y') = (x-x',y-y')
negar (x,y) = (-x,-y)

curvita :: FloatingPic
curvita a b c = line $ bezier a (a .+ b .+((1/3) .* c)) (a .+ b .+ c) 10

bezier :: Vector -> Vector -> Vector -> Int -> [Vector]
bezier p0 p1 p2 n = [ p1 .+ (((1-t)^2) .* (p0 .+ (negar p1))) .+ ((t^2) .* (p2 .+ (negar p1))) | t <- ts]
 where ts = 0:map (divF n) [1..n]
       divF :: Int -> Int -> Float
       divF j i = toEnum i / toEnum j

trian1 :: FloatingPic
trian1 a b c = line $ map (a V.+) [zero, half b V.+ c , b , zero]

trian2 :: FloatingPic
trian2 a b c = line $ map (a V.+) [zero, c, b,zero]

trianD :: FloatingPic
trianD a b c = line $ map (a V.+) [c, half b , b V.+ c , c]

rectan :: FloatingPic
rectan a b c = line [a, a V.+ b, a V.+ b V.+ c, a V.+ c,a]

simple :: Picture -> FloatingPic
simple p _ _ _ = p

fShape :: FloatingPic
fShape a b c = line . map (a V.+) $ [ zero,uX, p13, p33, p33 V.+ uY , p13 V.+ uY 
                 , uX V.+ 4 V.* uY ,uX V.+ 5 V.* uY, x4 V.+ y5
                 , x4 V.+ 6 V.* uY, 6 V.* uY, zero]    
  where p33 = 3 V.* (uX V.+ uY)
        p13 = uX V.+ 3 V.* uY
        x4 = 4 V.* uX
        y5 = 5 V.* uY
        uX = (1/6) V.* b
        uY = (1/6) V.* c

-- Dada una función que produce una figura a partir de un a y un vector
-- producimos una figura flotante aplicando las transformaciones
-- necesarias. Útil si queremos usar figuras que vienen de archivos bmp.
transf :: (a -> Vector -> Picture) -> a -> Vector -> FloatingPic
transf f d (xs,ys) a b c  = translate (fst a') (snd a') .
                             scale (magV b/xs) (magV c/ys) .
                             rotate ang $ f d (xs,ys)
  where ang = radToDeg $ argV b
        a' = a V.+ half (b V.+ c)

--------------------Definimos operaciones para vectores--------------------
--Def de suma de vectores
sumarvec :: Vector -> Vector -> Vector
sumarvec (a,b) (x,y) = (a+x, b+y)


--Def resta de vectores
resvec :: Vector -> Vector -> Vector
resvec (a,b) (x,y) = (a-x, b-y)

--Def de multiplicacion de numero por vector
multvec :: Float -> Vector -> Vector
multvec x (a,b) = (a*x, b*x)

--Def de division de vectores
divvec :: Float -> Vector -> Vector
divvec x (a,b) = (a/x, b/x)
---------------------------------------------------------------------------

--Rotar ya lo tenemos como construcor 
rotar :: FloatingPic -> FloatingPic
rotar p a b c = p (sumarvec a b) c (multvec (-1) b)

--Espejar ya lo tenemos como construcor 
espejar :: FloatingPic -> FloatingPic
espejar p a b c = p (sumarvec a b) (multvec (-1) b) c

--Rot45 ya lo tenemos como constructor
rot45 :: FloatingPic -> FloatingPic
rot45 p a b c = p (sumarvec a (divvec 2 (sumarvec b c))) (divvec 2 (sumarvec b c)) (divvec 2 (resvec c b))
--p(a + (b + c)/2, (b + c)/2, (c − b)/2 

--Encimar
--encimar :: FloatingPic  -> (Vector -> Vector -> Vector -> Picture) -> FloatingPic
--preguntar porque rayos machea
encimar :: FloatingPic -> FloatingPic -> FloatingPic
encimar p r a b c = pictures [p a b c, r a b c]


apilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
apilar n m p q a b c = pictures[p (sumarvec a c') b (multvec r c), q a b c']
  where r' = n/(n+m)
        r = m/(n+m)
        c' = multvec r' c

juntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
juntar n m p q a b c = pictures[p a b' c, q (sumarvec a b') (multvec r' b) c]
  where r' = n/(n+m)
        r = m/(n+m)
        b' = multvec r b

-----------------------------------------------------------------------------------


--inter :: (() -> (Vector -> Vector -> Vector -> Picture)) -> ((Dibujo ()) -> (Vector -> Vector -> Vector -> Picture)))
interp :: Output a -> Output (Dibujo a)
interp f (Basica a) = f a
interp f (Rotar d) = rotar $ interp f d
interp f (Espejar d) = espejar $ interp f d
interp f (Rot45 d) = rot45 $ interp f d
interp f (Encimar d h) = encimar (interp f d) (interp f h)
interp f (Apilar n m d h) = apilar n m (interp f d) (interp f h)
interp f (Juntar n m d h) = juntar n m (interp f d) (interp f h)


