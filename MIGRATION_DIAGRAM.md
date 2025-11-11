# Diagrama Visual de Migración Frontend → Backend

## 🔄 Estado Actual vs Estado Futuro

```
┌────────────────────────────────────────────────────────────────┐
│                    ESTADO ACTUAL                                │
└────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────┐
│   Next.js Frontend + Backend    │
│   (Todo en un solo proyecto)    │
├─────────────────────────────────┤
│                                 │
│  📁 lib/data/                   │
│    ├─ cabanas.ts       [STATIC]│  ← 3 modelos hardcodeados
│    ├─ features.ts      [STATIC]│  ← Features hardcodeadas
│    └─ gallery.ts       [STATIC]│  ← 12 imágenes hardcodeadas
│                                 │
│  📁 app/api/                    │
│    └─ contact/route.ts [WORKS] │  ← Solo 1 endpoint funcional
│                                 │
│  📁 components/                 │
│    └─ [React Components]       │
│                                 │
└─────────────────────────────────┘
```

```
┌────────────────────────────────────────────────────────────────┐
│                   ESTADO FUTURO                                 │
└────────────────────────────────────────────────────────────────┘

┌──────────────────────┐          ┌────────────────────────┐
│   Next.js Frontend   │          │   Backend API          │
│   Port: 3000         │◄────────►│   Port: 3001           │
├──────────────────────┤  HTTP    ├────────────────────────┤
│                      │  REST    │                        │
│  📁 components/      │          │  📁 api/               │
│    └─ [React]        │          │    ├─ /cabanas    GET  │
│                      │          │    ├─ /features   GET  │
│  📁 lib/             │          │    ├─ /gallery    GET  │
│    └─ [Utilities]    │          │    ├─ /config     GET  │
│                      │          │    └─ /contact   POST  │
│  ❌ No más datos     │          │                        │
│     estáticos        │          │  📁 models/            │
│                      │          │  📁 controllers/       │
│                      │          │  📁 services/          │
│                      │          │                        │
└──────────────────────┘          └────────┬───────────────┘
                                           │
                        ┌──────────────────┼──────────────────┐
                        │                  │                  │
                        ▼                  ▼                  ▼
              ┌──────────────┐   ┌─────────────┐   ┌──────────────┐
              │ PostgreSQL   │   │   Redis     │   │  Cloudinary  │
              │ Port: 5432   │   │  Port: 6379 │   │  (Images)    │
              ├──────────────┤   ├─────────────┤   ├──────────────┤
              │ • cabanas    │   │ • Cache     │   │ • Upload     │
              │ • features   │   │ • Rate Lmt  │   │ • Resize     │
              │ • gallery    │   │ • Sessions  │   │ • CDN        │
              │ • config     │   └─────────────┘   └──────────────┘
              └──────────────┘
```

## 📊 Flujo de Datos

### Antes (Estado Actual)
```
Usuario → Next.js → Datos Estáticos (TypeScript) → Renderizado
                    ↑
              (Hardcodeado en lib/data/)
```

### Después (Estado Futuro)
```
Usuario → Next.js Frontend → API REST → Base de Datos → Respuesta JSON → Renderizado
                             ↑
                        (Backend Separado)
```

## 🗃️ Mapeo de Archivos

```
FRONTEND ACTUAL              →    BACKEND FUTURO
─────────────────────────────────────────────────────────────────

📄 lib/data/cabanas.ts       →    🗄️ DB: tabla 'cabanas'
   (3 modelos)                     GET /api/cabanas
                                   GET /api/cabanas/:id
                                   GET /api/cabanas/slug/:slug

📄 lib/data/features.ts      →    🗄️ DB: tablas 'company_features' 
   (3 features + 6 benefits)              'benefits'
                                   GET /api/features
                                   GET /api/benefits

📄 lib/data/gallery.ts       →    🗄️ DB: tabla 'gallery_images'
   (12 imágenes)                   GET /api/gallery
                                   GET /api/gallery?category=X

📄 lib/config/site.ts        →    🗄️ DB: tablas 'site_config'
   (config + navegación)                  'social_links'
                                          'navigation'
                                   GET /api/config/site
                                   GET /api/config/navigation

📄 app/api/contact/route.ts  →    ✅ Mantener igual
   (Ya existe, funciona)           POST /api/contact
```

## 🔌 Arquitectura de API

```
┌─────────────────────────────────────────────────────────────┐
│                    API ENDPOINTS                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📗 PÚBLICOS (Frontend - Sin Auth)                         │
│  ├─ GET  /api/cabanas              [Lista de cabañas]     │
│  ├─ GET  /api/cabanas/:id          [Detalle cabaña]       │
│  ├─ GET  /api/cabanas/slug/:slug   [Detalle por slug]     │
│  ├─ GET  /api/features             [Características]      │
│  ├─ GET  /api/benefits             [Beneficios]           │
│  ├─ GET  /api/gallery              [Galería completa]     │
│  ├─ GET  /api/gallery?category=X   [Galería filtrada]     │
│  ├─ GET  /api/config/site          [Configuración]        │
│  ├─ GET  /api/config/navigation    [Navegación]           │
│  └─ POST /api/contact              [Formulario] ✅ EXISTE │
│                                                             │
│  📕 ADMIN (Panel - Requiere Auth JWT)                      │
│  ├─ POST   /api/auth/login         [Login]                │
│  ├─ POST   /api/cabanas            [Crear cabaña]         │
│  ├─ PUT    /api/cabanas/:id        [Actualizar]           │
│  ├─ DELETE /api/cabanas/:id        [Eliminar]             │
│  ├─ POST   /api/gallery            [Subir imagen]         │
│  ├─ DELETE /api/gallery/:id        [Eliminar imagen]      │
│  └─ PUT    /api/config/site        [Actualizar config]    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Estructura de Base de Datos

```
┌─────────────────────────────────────────────────────────┐
│                  DATABASE SCHEMA                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  📊 CABAÑAS (1:N relationships)                         │
│  ┌────────────────┐                                     │
│  │ cabanas        │ (Main table)                        │
│  │ ├─ id (PK)     │                                     │
│  │ ├─ name        │                                     │
│  │ ├─ slug        │                                     │
│  │ ├─ price       │                                     │
│  │ └─ ...         │                                     │
│  └────────┬───────┘                                     │
│           │                                              │
│     ┌─────┼────────┬──────────────┐                    │
│     ▼     ▼        ▼              ▼                     │
│  features specs  gallery      (relations)               │
│                                                          │
│  📊 COMPANY DATA (Independent)                          │
│  ├─ company_features  (3 records)                       │
│  ├─ benefits          (6 records)                       │
│  └─ gallery_images    (12 records)                      │
│                                                          │
│  📊 SITE CONFIG (Key-Value)                             │
│  ├─ site_config                                         │
│  ├─ social_links                                        │
│  └─ navigation                                          │
│                                                          │
│  📊 ADMIN & MESSAGES                                    │
│  ├─ admin_users                                         │
│  └─ contact_messages                                    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## 🔢 Números de Migración

```
┌──────────────────────────────────────────────────┐
│           ESTADÍSTICAS DE DATOS                  │
├──────────────────────────────────────────────────┤
│                                                  │
│  Tablas de Base de Datos:              11       │
│  Endpoints de API:                     18       │
│  Archivos JSON exportados:              4       │
│  Registros a migrar:                   34       │
│    ├─ Cabañas:                          3       │
│    ├─ Features:                         3       │
│    ├─ Beneficios:                       6       │
│    ├─ Imágenes Galería:                12       │
│    ├─ Enlaces Sociales:                 4       │
│    └─ Items Navegación:                 6       │
│                                                  │
│  Líneas de Documentación:           ~1,500      │
│  Archivos de Documentación:            12       │
│                                                  │
└──────────────────────────────────────────────────┘
```

## 🛠️ Pasos de Implementación

```
FASE 1: PREPARACIÓN
├─ ✅ Exportar datos a JSON                 [COMPLETADO]
├─ ✅ Crear especificación API              [COMPLETADO]
├─ ✅ Diseñar esquema DB                    [COMPLETADO]
└─ ✅ Documentar todo                       [COMPLETADO]

FASE 2: BASE DE DATOS
├─ [ ] Crear base de datos PostgreSQL
├─ [ ] Ejecutar CREATE TABLE statements
├─ [ ] Ejecutar INSERT statements
└─ [ ] Verificar datos

FASE 3: BACKEND API
├─ [ ] Setup proyecto backend (Express/Next)
├─ [ ] Implementar 9 endpoints GET
├─ [ ] Implementar autenticación JWT
├─ [ ] Implementar 8 endpoints Admin
├─ [ ] Configurar upload de imágenes
└─ [ ] Testing

FASE 4: FRONTEND
├─ [ ] Crear API client functions
├─ [ ] Reemplazar imports estáticos
├─ [ ] Agregar loading states
├─ [ ] Agregar error handling
└─ [ ] Testing end-to-end

FASE 5: PRODUCCIÓN
├─ [ ] Configurar HTTPS
├─ [ ] Redis para rate limiting
├─ [ ] CDN para imágenes
├─ [ ] Monitoring y logs
└─ [ ] Deploy
```

## 📚 Guía de Archivos

```
Tu punto de partida:
    │
    ├─ 📄 EXTRACTION_SUMMARY.md        ← EMPIEZA AQUÍ (Resumen)
    │
    ├─ 📄 BACKEND_MIGRATION.md         ← Lee esto segundo (Detalle)
    │
    └─ 📁 backend-export/
         │
         ├─ 📄 README.md               ← Guía rápida
         │
         ├─ 📊 DATOS (JSON)
         │   ├─ cabanas-data.json      ← 3 modelos
         │   ├─ features-data.json     ← Features + beneficios
         │   ├─ gallery-data.json      ← 12 imágenes
         │   └─ config-data.json       ← Configuración
         │
         ├─ 📋 ESPECIFICACIONES
         │   ├─ api-spec.yaml          ← OpenAPI 3.0 spec
         │   ├─ DATABASE_SCHEMA.md     ← Esquema SQL
         │   ├─ migration-scripts.sql  ← Scripts INSERT
         │   └─ types.ts               ← Tipos TypeScript
         │
         └─ 📖 GUÍAS
             └─ IMPLEMENTATION_GUIDE.md ← Ejemplo Express.js
```

## 🎯 Checklist de Uso

```
☑️  He leído EXTRACTION_SUMMARY.md
☑️  He revisado los archivos JSON
☑️  He abierto api-spec.yaml en Swagger Editor
☑️  He revisado DATABASE_SCHEMA.md
☑️  He ejecutado migration-scripts.sql
☑️  He leído IMPLEMENTATION_GUIDE.md
☑️  Estoy listo para implementar el backend
```

---

**Nota**: Este diagrama es una guía visual. Consulta los documentos específicos para detalles técnicos completos.
