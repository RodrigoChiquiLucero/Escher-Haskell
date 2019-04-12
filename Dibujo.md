# Laboratorio 1 - Paradigmas de la programación (un lenguaje que vale más que mil dibujos)

Nosotros empezamos al revés de los demás grupos. Lo hicimos sin querer porque en vez de hacer todas las funciones en Dibujo.hs las hicimos en Interp.hs. O sea al data Dibujo sí lo hicimos en Dibujo.hs pero a todo el resto de las funciones no. 
Lo que primero queríamos hacer era mostrar los dibujos. Entonces pedimos ayuda a los profes y fue ahí que cambiamos muchas cosas en interprete, en ejemplo, y solamente un poco un Main.hs para que nos imprimiera un dibujo. 

Empezamos a hacer todos los constructores de Dibujo. Se nos complicó un poco porque para sumar, restar, multiplicar y dividir vectores teníamos que crear funciones auxiliares. Cuando ya pensamos una y salió, las otras salieron rapidísimo. Después ,el problema fue la unión de figuras. Lo pensamos justo una clase antes de que el profe dijera que había un famoso "pictures". Buscamos horas y horas, (y en serio horas y horas) en la documentación hasta que encontramos el pictures. Y ahí anduvo bien.

Cuando terminamos de hacer los constructores empezamos a hacer las otras funciones (r180 por ejemplo) en Interp.hs. Pero hacíamos trampa, lo hacíamos que tomaba Floating Pic en vez de Dibujo a. Lo bueno de esto es que lo íbamos probando siempre y podíamos ver si lo que estábamos haciendo estaba bien o no. Pero pasaban los días y teníamos esa incertidumbre de por qué todos podían hacer que tomara Dibujo a y no un Floating Pic. 

Entonces le preguntamos a los profes, y nos dijeron que todas estas funciones deberían ir en Dibujo.hs. Pero no teníamos idea cómo pasar todas esas funciones a que tomen Dibujo a. Pensamos bastante y nos dimos cuenta de cómo hacerlo. En realidad nuestro "problema" era que queríamos probar todo en Ejemplo.hs. Por eso hicimos el pureDib antes que nada, tuvimos que crear un data Bas para que funcione y ahí empezamos a probar todas nuestras funciones que teníamos en Dibujo.hs.

Menos mal que uno de los profes explicó bien en clase lo que hacía sem y dió un ejemplo, porque estábamos muy perdidos con eso. Después hacer que las otras funciones no usen pattern matching usando sem no nos fue tan complicado. 

---
***Algunas aclaraciones:** como veníamos diciendo, queríamos probar cada función que hacíamos. Entonces a continuación vamos a detallar cuál es la forma en la que nosotros comprobábamos las funciones:* 

 - Para compilar: **ghci Main.hs**

	 - **cambia** :  cambia fCambia (Encimar (Rotar (Basica T1)) (Basica T1)). 
	                           Resultado: Encimar (Rotar (Basica T1)) (Basica T1)
		 > Donde fCambia es: 
	         >  fCambia :: a -> Dibujo Bas
	         >  fCambia x = (Basica T1)
	  - **limpia** :  limpia gVerEqDib F (Encimar (Rotar (Basica T1)) (Basica T2))
                Resultado: Encimar (Rotar (Basica F)) (Basica T2)
           > Donde gVerEqDib es: 
	    >  gVerEqDib :: Bas -> Bool
	    >  gVerEqDib a = a == T1
	   - **anyDib** : anyDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
	   Resultado: True
          > Donde gVerEqDib es: 
	     >  gVerEqDib :: Bas -> Bool
	     >  gVerEqDib a = a == T1
	  - **allDib** : anyDib g (cuarteto (pureDibe T1) (pureDibe R) (pureDibe R) (pureDibe R))
	   Resultado: False
          > Donde gVerEqDib es: 
	     >  gVerEqDib :: Bas -> Bool
	     >  gVerEqDib a = a == T1

	   - **desc** : desc desc basic_to_string (Rotar (Basica T1))
	   Resultado: "rot ( Trian1 )"
---
Y al final llegó el momento de Escher. No teníamos idea qué hacer, cómo empezar ni nada. Preguntamos y nos dijeron que teníamos que hacer el dibujo que aparecía en el paper de Henderson, pero el de los triángulos (porque ya nos habían dado esos dibujos).

Tuvimos muchos, pero **MUCHOS** problemas con esta parte. Habíamos entendido mal lo que tendríámos que haber hecho. Lo que hicimos fue hardcodear el dibujo para que se imprimiera, pero los profes nos dijeron que a escher le debíamos pasar un entero y el dibujo debería cambiar. Entonces nuestra forma no funcionaba. 

Entonces pedimos ayuda el último día de clase, y la profe Mili nos ayudó muchísimo porque nos explicó con ejemplos cómo deberían quedar los dibujos. Por ejemplo cómo debería quedar: `escher 1 trian2`, `escher 3 trian2`. Después de pensarlo todo el día, preguntar muchísimo, sacarnos dudas del paper de Henderson y demás, salió. Era lo único que nos faltaba pero estuvimos las 4 horas del viernes haciéndolo. 