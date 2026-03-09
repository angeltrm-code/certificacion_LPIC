# Laboratorio LPIC-1: Configuracion de red en Red Hat y Debian

## Objetivo
Configurar una interfaz de red con IP estatica en:
- Red Hat usando `nmcli` (NetworkManager).
- Debian usando `/etc/network/interfaces`.

## Datos del laboratorio
- Hostname: `ser1.curso.local`
- Interfaz: `eth2`
- IP: `192.168.33.200`
- Mascara: `255.255.255.0` (`/24`)
- Gateway: `192.168.33.1`
- DNS1: `8.8.8.8`
- DNS2: `8.8.4.4`

## 1. Verificacion inicial (ambos sistemas)
Ejecuta estos comandos antes de cambiar nada:

```bash
ip a show eth2
ip route
cat /etc/resolv.conf
```

## 2. Configuracion en Red Hat (con nmcli)
1. Revisar conexiones disponibles:
   ```bash
   nmcli connection show
   ```

2. Configurar la conexion de `eth2` en modo estatico:
   ```bash
   sudo nmcli connection modify eth2 \
     ipv4.method manual \
     ipv4.addresses 192.168.33.200/24 \
     ipv4.gateway 192.168.33.1 \
     ipv4.dns "8.8.8.8 8.8.4.4" \
     connection.autoconnect yes
   ```

3. Aplicar cambios:
   ```bash
   sudo nmcli connection up eth2
   ```

4. Configurar hostname:
   ```bash
   sudo hostnamectl set-hostname ser1.curso.local
   ```

5. Verificar:
   ```bash
   ip a show eth2
   ip route
   nmcli device show eth2
   cat /etc/resolv.conf
   ```

## 3. Configuracion en Debian (ifupdown)
1. Hacer copia de seguridad:
   ```bash
   sudo cp /etc/network/interfaces /etc/network/interfaces.bak
   ```

2. Editar `/etc/network/interfaces` y dejar la configuracion de `eth2` asi:
   ```bash
   auto lo
   iface lo inet loopback

   auto eth2
   iface eth2 inet static
       address 192.168.33.200
       netmask 255.255.255.0
       gateway 192.168.33.1
       dns-nameservers 8.8.8.8 8.8.4.4
   ```

3. Configurar DNS (si aplica en tu entorno):
   ```bash
   sudo tee /etc/resolv.conf >/dev/null <<EOF
   nameserver 8.8.8.8
   nameserver 8.8.4.4
   EOF
   ```

4. Configurar hostname:
   ```bash
   echo "ser1.curso.local" | sudo tee /etc/hostname
   sudo hostnamectl set-hostname ser1.curso.local
   ```

5. Reiniciar la red:
   ```bash
   sudo ifdown eth2 2>/dev/null; sudo ifup eth2
   # alternativa:
   # sudo systemctl restart networking
   ```

6. Verificar:
   ```bash
   ip a show eth2
   ip route
   cat /etc/resolv.conf
   ```

## 4. Pruebas finales de conectividad
Ejecuta en ambos sistemas:

```bash
ping -c 4 192.168.33.1
ping -c 4 8.8.8.8
ping -c 4 google.com
```

## 5. Evidencias a entregar
- Salida de `ip a show eth2`.
- Salida de `ip route`.
- Salida de `cat /etc/resolv.conf`.
- Resultado de los 3 `ping`.
