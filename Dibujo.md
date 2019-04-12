# Laboratorio 1 - Paradigmas de la programación

Nosotros empezamos al revés de los demás grupos. Lo hicimos sin querer porque en vez de hacer todas las funciones en Dibujo.hs las hicimos en Interp.hs. O sea al data Dibujo sí lo hicimos en Dibujo.hs pero a todo el resto de las funciones no. 
Lo que primero queríamos hacer era mostrar los dibujos. Entonces pedimos ayuda a los profes y fue ahí que cambiamos muchas cosas en interprete, en ejemplo, y solamente un poco un Main.hs para que nos imprimiera un dibujo. 

Empezamos a hacer todos los constructores de Dibujo. Se nos complicó un poco porque para sumar, restar, multiplicar y dividir vectores teníamos que crear funciones auxiliares. Cuando ya pensamos una y salió, las otras salieron rapidísimo. Después ,el problema fue la unión de figuras. Lo pensamos justo una clase antes de que el profe dijera que había un famoso "pictures". Buscamos horas y horas, (y en serio horas y horas) en la documentación hasta que encontramos el pictures. Y ahí anduvo bien.

Cuando terminamos de hacer los constructores empezamos a hacer las otras funciones (r180 por ejemplo) en Interp.hs. Pero hacíamos trampa, lo hacíamos que tomaba Floating Pic en vez de Dibujo a. Lo bueno de esto es que lo íbamos probando siempre y podíamos ver si lo que estábamos haciendo estaba bien o no. Pero pasaban los días y teníamos esa incertidumbre de por qué todos podían hacer que tomara Dibujo a y no un Floating Pic. 

Entonces le preguntamos a los profes, y nos dijeron que todas estas funciones deberían ir en Dibujo.hs. Pero no teníamos idea cómo pasar todas esas funciones a que tomen Dibujo a. Pensamos bastante y nos dimos cuenta de cómo hacerlo. En realidad nuestro "problema" era que queríamos probar todo en Ejemplo.hs. Por eso hicimos el pureDib antes que nada, tuvimos que crear un data Bas para que funcione y ahí empezamos a probar todas nuestras funciones que teníamos en Dibujo.hs.

Menos mal que uno de los profes explicó bien en clase lo que hacía sem y dió un ejemplo, porque estábamos muy perdido con eso. Después hacer que las otras funciones no usen pattern matching usando sem no nos fue tan complicado. 

Y al final llegó el momento de Escher. No teníamos idea qué hacer, cómo empezar ni nada. Preguntamos y nos dijeron que teníamos que hacer el dibujo que aparecía en el paper de Henderson, pero el de los triángulos (porque ya nos habían dado esos dibujos). 

Tuvimos muchos, pero **MUCHOS** problemas con este dibujo. No sabíamos como encararlo. Al principio lo encaramos de una manera, lo logramos hacer pero nos dio un dibujo como tridimensional. Y era porque algunos cuadrados que deberían ser cuadrados, eran rectángulos. Y las líneas que se "unían" no eran perfectas estaban medias curvadas. 

Y después nos dimos cuenta de hacerlo de una forma y nos dio PERFECTO. Todos eran cuadrados. La magia fue que nuestros Juntar y Apilar usan números para que los acomodemos en la grilla. Los entendimos tarde cómo funcionaban. Empezamos a usarlos como si fuesen "centímetros" en la grilla. Entonces por ejemplo Juntar 4 6 ... hacía que el primer dibujo dado midiera 4 cm (o 4 cuadrados de la grilla) y lo mismo con 6 pero con el segundo dibujo dado. Entonces empezamos a pensar cada dibujo que hacíamos de esta forma. 
