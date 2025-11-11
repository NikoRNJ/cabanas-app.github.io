# Cabañas para Francisco.



Sitio web profesional para promoción de cabañas modulares, construido con Next.js 15, TypeScript, Tailwind CSS y Framer Motion.



## 🚀 Características al iniciar:



### Frontend```bash

- ✨ **Next.js 15** con App Router npm run dev

- 🎨 **Tailwind CSS** para estilos

- 🎭 **Framer Motion** para animaciones suavesyarn dev

- 📱 **Diseño 100% Responsive**

- ⚡ **TypeScript** para type-safetypnpm dev

- 🎯 **SEO Optimizado** con metadata dinámica


### Backend```

- 📧 **Sistema de Envío de Emails** con Nodemailer

- ✅ **Validación con Zod**Abrir [http://localhost:3000](http://localhost:3000).

- 🛡️ **Rate Limiting** para protección contra spam

### Secciones

1. Hero - Banner principal con CTA.

2. About - Sobre la compañía

3. Benefits - Ventajas y garantías

4. Models - Catálogo de modelos

5. Gallery - Galería con lightbox

6. Location - Ubicación con mapa

7. Contact - Formulario de contacto.


## 🛠️ Instalación


# Instalar dependencias## Deploy on Vercel

npm install

# Configurar variables de entorno

cp .env.example .env.local


# Ejecutar en desarrollo
npm run dev
```

## 📧 Configuración de Email

Edita `.env.local`:
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tu-email@gmail.com
SMTP_PASS=tu-contraseña-de-aplicación
```

## 🚀 Despliegue

```bash
npm run build
npm start
```

O despliega en Vercel con un click.

## 🔄 Migración a Backend

Este proyecto incluye documentación completa para migrar el frontend a un backend con API REST.

**📚 Documentación de Migración:**

- **[EXTRACTION_SUMMARY.md](./EXTRACTION_SUMMARY.md)** - **START HERE** - Resumen ejecutivo
- **[BACKEND_MIGRATION.md](./BACKEND_MIGRATION.md)** - Guía completa de migración
- **[MIGRATION_DIAGRAM.md](./MIGRATION_DIAGRAM.md)** - Diagramas visuales
- **[backend-export/](./backend-export/)** - Datos, especificaciones y guías

**¿Qué incluye?**
- ✅ 34 registros de datos exportados a JSON
- ✅ 18 endpoints de API documentados (OpenAPI 3.0)
- ✅ 11 tablas de base de datos con scripts SQL
- ✅ Guía de implementación con ejemplos de código
- ✅ Tipos TypeScript para el backend

**Inicio rápido:**
```bash
# 1. Lee el resumen
open EXTRACTION_SUMMARY.md

# 2. Revisa los datos exportados
ls backend-export/*.json

# 3. Crea la base de datos
createdb cabanas_db
psql -d cabanas_db < backend-export/migration-scripts.sql

# 4. Implementa la API usando:
open backend-export/api-spec.yaml
```

## 📝 Licencia

Privado y confidencial.
