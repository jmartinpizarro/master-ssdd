# master-ssdd

## Compilar y ejecutar

Necesitas tener SimGrid instalado. Con la instalación indicada abajo, la biblioteca
queda en `/directorio_install` y el proyecto se compila con:

```bash
make clean
make
```

Si SimGrid está instalada en otra ruta, pásala explícitamente:

```bash
make INSTALL_PATH=/ruta/de/simgrid
```

La prueba básica se ejecuta indicando la plataforma y la tasa de llegada:

```bash
./practica platform-cluster.xml 0.2
```

También pueden probarse las tasas `0.5`, `0.7` y `0.9`. Al finalizar, el programa
muestra el tiempo medio de servicio, el tamaño medio de la cola y el número medio
de tareas en el sistema.

El código base está configurado actualmente con un servidor y distribuye todas las
tareas al servidor `0`; los algoritmos y políticas descritos en el enunciado deben
implementarse como parte del trabajo.
