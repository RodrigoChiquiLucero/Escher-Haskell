module Basico.Escher where
import Dibujo
import Interp

type Escher = Bas

dibujo_u :: Dibujo Escher -> Dibujo Escher
dibujo_u p = encimar4 p 

dibujo_t :: Dibujo Escher -> Dibujo Escher
dibujo_t p = superponeDosFig p (superponeDosFig (r270( Rot45 p)) ( Rot45 p))--superponeDosFig  p (superponeDosFig (Rot45 p) (r180 p))

lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 p = cuarteto (pureDibe B) (pureDibe B) (Rotar (dibujo_t p)) (dibujo_t p)
lado n p = cuarteto (lado (n-1) (p)) (lado (n-1) (p)) (Rotar (dibujo_t p)) (dibujo_t p)  

esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 p = cuarteto (pureDibe B) (pureDibe B) (pureDibe B) (dibujo_u p) 
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (Rotar (lado (n-1) p)) (dibujo_u p)  

noneto p q r
       s t u
       v w x = Apilar 2 1   (Juntar 2 1 p (Juntar 1 1 q r)) 
                            (Apilar 1 1 (Juntar 2 1 s (Juntar 1 1 t u))
                            (Juntar 2 1 v (Juntar 1 1 w x)))

escher :: Int -> Escher -> Dibujo Escher
escher n d = noneto p q r s t u v w x
    where p = (esquina n (pureDibe d))
          q = (lado n (pureDibe d))
          t = dibujo_u (pureDibe d)
          r = Rotar x
          s = Rotar q
          u = Rotar w
          v = Rotar p
          w = Rotar s
          x = Rotar v
