# Laboratorio LPIC-1 - 40 preguntas prácticas (resuelto)

Este documento incluye cada pregunta con su comando de respuesta.

## Parte 1 - Interfaces de red (Linux)

1. **Muestra todas las interfaces de red disponibles en el sistema usando el comando moderno de Linux.**

   **Respuesta:**
   ```bash
   ip link show
   ```

2. **Muestra únicamente la información de la interfaz `eth0`.**

   **Respuesta:**
   ```bash
   ip addr show dev eth0
   ```

3. **Asigna la dirección IP `192.168.1.50/24` a la interfaz `eth0` sin reiniciar el sistema.**

   **Respuesta:**
   ```bash
   sudo ip addr add 192.168.1.50/24 dev eth0
   ```

4. **Elimina la dirección IP `192.168.1.50/24` de la interfaz `eth0`.**

   **Respuesta:**
   ```bash
   sudo ip addr del 192.168.1.50/24 dev eth0
   ```

5. **Activa la interfaz de red `eth1` desde la línea de comandos.**

   **Respuesta:**
   ```bash
   sudo ip link set eth1 up
   ```

6. **Desactiva la interfaz `eth1` utilizando el comando `ip`.**

   **Respuesta:**
   ```bash
   sudo ip link set eth1 down
   ```

7. **Muestra la tabla de rutas del sistema.**

   **Respuesta:**
   ```bash
   ip route show
   ```

8. **Añade una ruta estática hacia la red `192.168.3.0/25` a través de `172.16.1.36` usando `eth1`.**

   **Respuesta:**
   ```bash
   sudo ip route add 192.168.3.0/25 via 172.16.1.36 dev eth1
   ```

9. **Elimina la ruta anterior del sistema.**

   **Respuesta:**
   ```bash
   sudo ip route del 192.168.3.0/25 via 172.16.1.36 dev eth1
   ```

10. **Añade una puerta de enlace por defecto hacia `192.168.1.1`.**

    **Respuesta:**
    ```bash
    sudo ip route add default via 192.168.1.1
    ```

## Parte 2 - Configuración de red en RedHat

11. **Indica en qué directorio se encuentran los archivos de configuración de interfaces de red en RedHat.**

    **Respuesta:**
    ```text
    /etc/sysconfig/network-scripts/
    ```

12. **Edita el fichero de configuración de `eth0` para asignarle la IP `192.168.1.5`.**

    **Respuesta:**
    ```bash
    sudo vi /etc/sysconfig/network-scripts/ifcfg-eth0
    ```

    Contenido mínimo:
    ```ini
    DEVICE=eth0
    BOOTPROTO=none
    ONBOOT=yes
    IPADDR=192.168.1.5
    PREFIX=24
    ```

13. **Configura la interfaz `eth1` para obtener IP mediante DHCP.**

    **Respuesta:**
    ```bash
    sudo vi /etc/sysconfig/network-scripts/ifcfg-eth1
    ```

    Contenido mínimo:
    ```ini
    DEVICE=eth1
    BOOTPROTO=dhcp
    ONBOOT=yes
    ```

14. **Reinicia el servicio de red usando NetworkManager.**

    **Respuesta:**
    ```bash
    sudo systemctl restart NetworkManager
    ```

15. **Instala la herramienta `nmtui` en un sistema basado en RedHat.**

    **Respuesta:**
    ```bash
    sudo dnf install -y NetworkManager-tui
    ```

16. **Ejecuta la herramienta gráfica en terminal para configurar la red.**

    **Respuesta:**
    ```bash
    sudo nmtui
    ```

17. **Lista todas las conexiones administradas por NetworkManager usando `nmcli`.**

    **Respuesta:**
    ```bash
    nmcli connection show
    ```

18. **Crea una conexión de red llamada `eth2` con IP `192.168.33.250/24` usando `nmcli`.**

    **Respuesta:**
    ```bash
    sudo nmcli connection add type ethernet ifname eth2 con-name eth2 ipv4.addresses 192.168.33.250/24 ipv4.method manual
    ```

19. **Verifica que la IP se ha configurado correctamente usando el comando `ip`.**

    **Respuesta:**
    ```bash
    ip addr show dev eth2
    ```

20. **Reinicia NetworkManager para aplicar cambios.**

    **Respuesta:**
    ```bash
    sudo systemctl restart NetworkManager
    ```

## Parte 3 - Configuración de red en Debian

21. **Indica cuál es el archivo principal donde se configuran las interfaces de red en Debian.**

    **Respuesta:**
    ```text
    /etc/network/interfaces
    ```

22. **Configura la interfaz `eth0` con IP estática `192.168.1.60/24` y gateway `192.168.1.1`.**

    **Respuesta:**
    ```bash
    sudo vi /etc/network/interfaces
    ```

    Bloque de ejemplo:
    ```ini
    auto eth0
    iface eth0 inet static
        address 192.168.1.60
        netmask 255.255.255.0
        gateway 192.168.1.1
    ```

23. **Configura la interfaz `eth1` para obtener IP mediante DHCP.**

    **Respuesta:**
    ```bash
    sudo vi /etc/network/interfaces
    ```

    Bloque de ejemplo:
    ```ini
    auto eth1
    iface eth1 inet dhcp
    ```

24. **Reinicia el servicio de red en Debian usando `systemctl`.**

    **Respuesta:**
    ```bash
    sudo systemctl restart networking
    ```

25. **Activa la interfaz `eth0` usando `ifup`.**

    **Respuesta:**
    ```bash
    sudo ifup eth0
    ```

26. **Desactiva la interfaz `eth0` usando `ifdown`.**

    **Respuesta:**
    ```bash
    sudo ifdown eth0
    ```

27. **Crea una interfaz virtual `eth1:0` con IP `192.168.33.43`.**

    **Respuesta:**
    ```bash
    sudo ifconfig eth1:0 192.168.33.43 netmask 255.255.255.0 up
    ```

28. **Muestra el nombre del host del sistema.**

    **Respuesta:**
    ```bash
    hostname
    ```

29. **Cambia el hostname del sistema a `server.curso.lab`.**

    **Respuesta:**
    ```bash
    sudo hostnamectl set-hostname server.curso.lab
    ```

30. **Configura los servidores DNS `8.8.8.8` y `8.8.4.4` en `/etc/resolv.conf`.**

    **Respuesta:**
    ```bash
    sudo tee /etc/resolv.conf > /dev/null << 'EOF'
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    EOF
    ```

## Parte 4 - Resolución de nombres y diagnóstico de red

31. **Comprueba la resolución DNS de `www.google.com` usando `nslookup`.**

    **Respuesta:**
    ```bash
    nslookup www.google.com
    ```

32. **Realiza un `ping` al host `8.8.8.8` enviando solo 3 paquetes.**

    **Respuesta:**
    ```bash
    ping -c 3 8.8.8.8
    ```

33. **Muestra todas las conexiones TCP activas usando `ss`.**

    **Respuesta:**
    ```bash
    ss -tan
    ```

34. **Muestra los puertos en escucha en el sistema.**

    **Respuesta:**
    ```bash
    ss -tuln
    ```

35. **Utiliza `traceroute` para ver la ruta hacia `google.com`.**

    **Respuesta:**
    ```bash
    traceroute google.com
    ```

## Parte 5 - Seguridad del sistema

36. **Busca todos los archivos con permiso SUID en el sistema.**

    **Respuesta:**
    ```bash
    find / -type f -perm -4000 2>/dev/null
    ```

37. **Bloquea la contraseña del usuario `operador`.**

    **Respuesta:**
    ```bash
    sudo passwd -l operador
    ```

38. **Fuerza al usuario `operador` a cambiar su contraseña en el próximo login.**

    **Respuesta:**
    ```bash
    sudo chage -d 0 operador
    ```

39. **Muestra todos los puertos abiertos en el sistema usando `lsof`.**

    **Respuesta:**
    ```bash
    sudo lsof -i -P -n
    ```

40. **Muestra los últimos usuarios que se han conectado al sistema usando `last`.**

    **Respuesta:**
    ```bash
    last
    ```
