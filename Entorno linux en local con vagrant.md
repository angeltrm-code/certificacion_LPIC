# Entorno linux en local con vagrant

Documento de referencia sobre Entorno linux en local con vagrant con formato Markdown homogéneo y navegación más clara.

**Importante:

## For MAC/Linux Users con sistema operativo base

Latest version of Virtualbox for Mac/Linux can cause issues. Create/edit the /etc/vbox/networks.conf file and add the following to avoid any network related issues.

## 0.0.0.0/0 ::/0

### or run below comandos

```bash
sudo mkdir -p /etc/vbox/
echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf
```

So that the host only networks can be in any range, not just 192.168.56.0/21 as described here: https://discuss.hashicorp.com/t/vagrant-2-2-18-osx-11-6-cannot-create-private-network/30984/23

## Tener instalado las ultimas versiones:

vagrant virtualbox

## Referencias

- https://www.virtualbox.org/wiki/Downloads

## La version de vagrant descargarla de la web, si tengo linux como sista base no utilizar el vagrant del repositorio, sino el de la web:

- https://www.vagrantup.com/downloads

## Boxes que son las mv de vagrant creadas para virtualbox

- https://app.vagrantup.com/boxes/search

**Copiar la carpeta mv-lpic1 c:\

## Iniciar las mv:

```bash
cd c:\mv-lpic1
```

vagrant up

## Parar las mv:

```bash
cd c:\mv-lpic1
```

### vagrant halt

vagrant ssh rockylinux8 vagrant ssh debian

## Destruirlas, quitarlas de VirtualBox:

```bash
cd c:\mv-lpic1
```

vagrant destroy -f

## Crea 2 mv:

rockylinux8-->192.168.33.10 debian12-->192.168.33.11

## Ususario:vagrant

## Pass: vagrant

## user:root

## pass:vagrant

## En debian12 para convertirme en root:

sudo -i
