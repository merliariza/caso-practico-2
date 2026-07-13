# Caso Práctico 2 - Automatización de despliegues en entornos Cloud

## Descripción

Este proyecto implementa una solución DevOps basada en Microsoft Azure, aplicando infraestructura como código y automatización de despliegues.

La solución utiliza:

* Terraform para la creación de infraestructura en Azure.
* Ansible para la configuración automática y despliegue de aplicaciones.
* Azure Container Registry (ACR) como registro privado de imágenes.
* Podman para ejecutar una aplicación web sobre una máquina virtual Linux.
* Azure Kubernetes Service (AKS) para desplegar una aplicación con almacenamiento persistente.

El objetivo principal es construir un entorno reproducible donde la infraestructura y las aplicaciones puedan desplegarse sin realizar configuraciones manuales desde el portal de Azure.

---

# Arquitectura de la solución

La solución está formada por dos despliegues independientes:

## Aplicación desplegada con Podman

Ejecutada sobre una máquina virtual Ubuntu Server 22.04:

* Máquina virtual: `vm-casopractico2`
* Contenedor gestionado mediante Podman.
* Imagen almacenada en Azure Container Registry:

```
web-podman-nginx:casopractico2
```

Características:

* Servidor web Nginx.
* Comunicación HTTPS mediante certificado x.509 autofirmado.
* Autenticación básica.
* Gestión del contenedor mediante systemd.

---

## Aplicación desplegada sobre Kubernetes

Ejecutada sobre Azure Kubernetes Service:

* Clúster: `aks-casopractico2`
* Imagen utilizada:

```
web-k8s:casopractico2
```

Incluye:

* Deployment Kubernetes.
* Secret para acceso al registro privado ACR.
* PersistentVolumeClaim de 1 GiB.
* Service tipo LoadBalancer para acceso externo.

---

# Estructura del proyecto

```
caso-practico-2/

├── terraform/
│   ├── network.tf
│   ├── vm.tf
│   ├── acr.tf
│   ├── aks.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── ansible/
│   ├── playbook.yml
│   └── playbook-k8s.yml
│
├── app-podman-nginx/
│   ├── Dockerfile
│   └── configuración Nginx
│
├── app-k8s-image/
│   └── Dockerfile
│
└── app-k8s/
    ├── deployment.yaml
    ├── service.yaml
    └── pvc.yaml
```

---

# Requisitos previos

Para ejecutar el proyecto se requiere:

* Suscripción activa de Microsoft Azure.
* Azure CLI.
* Terraform.
* Ansible.
* kubectl.
* Docker o Podman.

Autenticación en Azure:

```bash
az login
```

---

# Guía de despliegue

El despliegue completo se realiza mediante Terraform y Ansible.

## 1. Creación de infraestructura con Terraform

Ingresar al directorio de Terraform:

```bash
cd terraform
```

Inicializar Terraform:

```bash
terraform init
```

Validar la configuración:

```bash
terraform validate
```

Revisar el plan de ejecución:

```bash
terraform plan
```

Crear los recursos en Azure:

```bash
terraform apply
```

Este proceso crea automáticamente:

* Resource Group `rg-casopractico2`.
* Máquina virtual `vm-casopractico2`.
* Azure Container Registry `acrmerliarizacp2`.
* Clúster AKS `aks-casopractico2`.
* Recursos de red asociados.

---

## 2. Publicación de imágenes en Azure Container Registry

Las aplicaciones utilizan imágenes privadas almacenadas en ACR:

```
acrmerliarizacp2.azurecr.io/web-podman-nginx:casopractico2

acrmerliarizacp2.azurecr.io/web-k8s:casopractico2
```

Antes de publicar las imágenes se realiza la autenticación:

```bash
az acr login --name acrmerliarizacp2
```

Posteriormente se construyen las imágenes desde los directorios:

```
app-podman-nginx
app-k8s-image
```

y se publican en el registro privado.

---

## 3. Despliegue de aplicación Podman

Desde el directorio `ansible` ejecutar:

```bash
ansible-playbook playbook.yml
```

Este playbook realiza automáticamente:

* Instalación de Podman.
* Configuración del acceso a ACR.
* Descarga de la imagen privada.
* Creación del contenedor.
* Configuración del servicio mediante systemd.

---

## 4. Despliegue de aplicación Kubernetes

Obtener las credenciales del clúster:

```bash
az aks get-credentials \
--resource-group rg-casopractico2 \
--name aks-casopractico2
```

Ejecutar el playbook:

```bash
ansible-playbook playbook-k8s.yml
```

Este proceso crea:

* Secret `acr-credentials`.
* PersistentVolumeClaim `cp2-storage`.
* Deployment de Kubernetes.
* Service `cp2-web-service`.

---

# Validación del despliegue

Para comprobar el estado del clúster:

```bash
kubectl get nodes
```

Ver los pods ejecutándose:

```bash
kubectl get pods
```

Ver los servicios publicados:

```bash
kubectl get svc
```

Ver el almacenamiento persistente:

```bash
kubectl get pvc
```

Para validar la aplicación desplegada con Podman:

```bash
podman ps
```

y comprobar el servicio:

```bash
systemctl status <servicio>
```

---

# Problemas encontrados

Durante el desarrollo se presentó una restricción de Azure Policy relacionada con las regiones disponibles en Azure for Students.

La solución aplicada fue cambiar la región de despliegue a:

```
mexicocentral
```

También se corrigió un problema relacionado con el almacenamiento persistente en Kubernetes. Inicialmente el volumen reemplazaba el contenido principal de Nginx, por lo que la aplicación no encontraba el archivo web.

La solución fue montar el volumen únicamente en:

```
/usr/share/nginx/html/data
```

permitiendo separar el contenido de la aplicación y los datos persistentes.

---

# Tecnologías utilizadas

* Microsoft Azure
* Terraform
* Ansible
* Azure Container Registry
* Azure Kubernetes Service
* Kubernetes
* Podman
* Nginx
* Ubuntu Server 22.04

---

# Licencias

Las herramientas utilizadas pertenecen a proyectos de código abierto:

* Terraform - Mozilla Public License 2.0
* Ansible - GNU General Public License v3
* Podman - Apache License 2.0
