# Guía de Implementación - Ejemplo con Express.js

Esta guía muestra cómo implementar el backend usando Node.js + Express + PostgreSQL como ejemplo.

## 📦 Instalación de Dependencias

```bash
npm install express pg cors helmet dotenv bcrypt jsonwebtoken multer
npm install -D @types/express @types/pg @types/cors @types/bcrypt @types/jsonwebtoken @types/multer typescript ts-node nodemon
```

## 🗂️ Estructura del Proyecto Backend

```
backend/
├── src/
│   ├── config/
│   │   ├── database.ts          # Configuración de PostgreSQL
│   │   └── env.ts               # Variables de entorno
│   ├── controllers/
│   │   ├── cabanas.controller.ts
│   │   ├── features.controller.ts
│   │   ├── gallery.controller.ts
│   │   ├── contact.controller.ts
│   │   └── auth.controller.ts
│   ├── middleware/
│   │   ├── auth.middleware.ts    # Verificación JWT
│   │   ├── validation.middleware.ts
│   │   └── rateLimit.middleware.ts
│   ├── models/
│   │   ├── cabana.model.ts
│   │   ├── feature.model.ts
│   │   └── gallery.model.ts
│   ├── routes/
│   │   ├── cabanas.routes.ts
│   │   ├── features.routes.ts
│   │   ├── gallery.routes.ts
│   │   ├── contact.routes.ts
│   │   └── auth.routes.ts
│   ├── services/
│   │   ├── email.service.ts      # Nodemailer
│   │   └── upload.service.ts     # Cloudinary
│   ├── utils/
│   │   ├── validation.ts         # Schemas Zod
│   │   └── errors.ts
│   └── index.ts                  # Punto de entrada
├── .env
├── .env.example
├── package.json
└── tsconfig.json
```

## 🚀 Ejemplo: Endpoint GET /api/cabanas

### 1. Modelo (src/models/cabana.model.ts)

```typescript
import { Pool } from 'pg';
import { CabanaModel } from '../types';

export class CabanaModelDB {
  constructor(private pool: Pool) {}

  async findAll(): Promise<CabanaModel[]> {
    const client = await this.pool.connect();
    
    try {
      // Obtener cabañas
      const cabanasResult = await client.query(
        'SELECT * FROM cabanas WHERE available = true ORDER BY name'
      );

      const cabanas = await Promise.all(
        cabanasResult.rows.map(async (row) => {
          // Obtener features
          const featuresResult = await client.query(
            'SELECT feature FROM cabana_features WHERE cabana_id = $1 ORDER BY order_index',
            [row.id]
          );

          // Obtener specifications
          const specsResult = await client.query(
            'SELECT label, value FROM cabana_specifications WHERE cabana_id = $1 ORDER BY order_index',
            [row.id]
          );

          // Obtener galería
          const galleryResult = await client.query(
            'SELECT image_url FROM cabana_gallery WHERE cabana_id = $1 ORDER BY order_index',
            [row.id]
          );

          return {
            id: row.id,
            name: row.name,
            slug: row.slug,
            description: row.description,
            dimensions: {
              area: row.area,
              bedrooms: row.bedrooms,
              bathrooms: row.bathrooms,
              floors: row.floors,
            },
            features: featuresResult.rows.map(f => f.feature),
            price: {
              amount: parseFloat(row.price_amount),
              currency: row.price_currency,
              period: row.price_period,
            },
            images: {
              main: row.main_image,
              gallery: galleryResult.rows.map(g => g.image_url),
              thumbnail: row.thumbnail,
            },
            specifications: specsResult.rows,
            available: row.available,
          };
        })
      );

      return cabanas;
    } finally {
      client.release();
    }
  }

  async findById(id: string): Promise<CabanaModel | null> {
    // Similar a findAll pero con WHERE id = $1
    // ... implementación
  }

  async findBySlug(slug: string): Promise<CabanaModel | null> {
    // Similar a findAll pero con WHERE slug = $1
    // ... implementación
  }
}
```

### 2. Controlador (src/controllers/cabanas.controller.ts)

```typescript
import { Request, Response } from 'express';
import { CabanaModelDB } from '../models/cabana.model';
import { pool } from '../config/database';

const cabanaModel = new CabanaModelDB(pool);

export const getCabanas = async (req: Request, res: Response) => {
  try {
    const cabanas = await cabanaModel.findAll();
    
    res.json({
      success: true,
      data: cabanas,
    });
  } catch (error) {
    console.error('Error fetching cabanas:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener las cabañas',
      error: {
        code: 'INTERNAL_ERROR',
      },
    });
  }
};

export const getCabanaById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const cabana = await cabanaModel.findById(id);

    if (!cabana) {
      return res.status(404).json({
        success: false,
        message: 'Cabaña no encontrada',
        error: {
          code: 'NOT_FOUND',
        },
      });
    }

    res.json({
      success: true,
      data: cabana,
    });
  } catch (error) {
    console.error('Error fetching cabana:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener la cabaña',
      error: {
        code: 'INTERNAL_ERROR',
      },
    });
  }
};

export const getCabanaBySlug = async (req: Request, res: Response) => {
  try {
    const { slug } = req.params;
    const cabana = await cabanaModel.findBySlug(slug);

    if (!cabana) {
      return res.status(404).json({
        success: false,
        message: 'Cabaña no encontrada',
        error: {
          code: 'NOT_FOUND',
        },
      });
    }

    res.json({
      success: true,
      data: cabana,
    });
  } catch (error) {
    console.error('Error fetching cabana:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener la cabaña',
      error: {
        code: 'INTERNAL_ERROR',
      },
    });
  }
};
```

### 3. Rutas (src/routes/cabanas.routes.ts)

```typescript
import { Router } from 'express';
import { getCabanas, getCabanaById, getCabanaBySlug } from '../controllers/cabanas.controller';
import { authenticate } from '../middleware/auth.middleware';

const router = Router();

// Rutas públicas
router.get('/', getCabanas);
router.get('/:id', getCabanaById);
router.get('/slug/:slug', getCabanaBySlug);

// Rutas protegidas (admin)
// router.post('/', authenticate, createCabana);
// router.put('/:id', authenticate, updateCabana);
// router.delete('/:id', authenticate, deleteCabana);

export default router;
```

### 4. Configuración de Base de Datos (src/config/database.ts)

```typescript
import { Pool } from 'pg';

export const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME || 'cabanas_db',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
  process.exit(-1);
});
```

### 5. Punto de Entrada (src/index.ts)

```typescript
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import dotenv from 'dotenv';

// Importar rutas
import cabanasRoutes from './routes/cabanas.routes';
import featuresRoutes from './routes/features.routes';
import galleryRoutes from './routes/gallery.routes';
import contactRoutes from './routes/contact.routes';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true,
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Rutas
app.use('/api/cabanas', cabanasRoutes);
app.use('/api/features', featuresRoutes);
app.use('/api/gallery', galleryRoutes);
app.use('/api/contact', contactRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Endpoint no encontrado',
    error: {
      code: 'NOT_FOUND',
    },
  });
});

// Error handler
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Error interno del servidor',
    error: {
      code: 'INTERNAL_ERROR',
    },
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
```

### 6. Variables de Entorno (.env.example)

```env
# Server
PORT=3001
NODE_ENV=development
FRONTEND_URL=http://localhost:3000

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=cabanas_db
DB_USER=postgres
DB_PASSWORD=tu_contraseña

# JWT
JWT_SECRET=tu-secreto-super-seguro-cambiar-en-produccion
JWT_EXPIRATION=24h

# Email
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=tu-email@gmail.com
SMTP_PASS=tu-contraseña-de-aplicacion
EMAIL_FROM=noreply@ejemplo.cl
EMAIL_TO=contacto@ejemplo.cl

# Upload (Cloudinary)
CLOUDINARY_CLOUD_NAME=tu-cloud-name
CLOUDINARY_API_KEY=tu-api-key
CLOUDINARY_API_SECRET=tu-api-secret
```

### 7. package.json

```json
{
  "name": "cabanas-backend",
  "version": "1.0.0",
  "scripts": {
    "dev": "nodemon src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "cors": "^2.8.5",
    "helmet": "^7.1.0",
    "dotenv": "^16.3.1",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "multer": "^1.4.5-lts.1",
    "nodemailer": "^7.0.10",
    "zod": "^4.1.12"
  },
  "devDependencies": {
    "@types/express": "^4.17.21",
    "@types/pg": "^8.10.9",
    "@types/cors": "^2.8.17",
    "@types/bcrypt": "^5.0.2",
    "@types/jsonwebtoken": "^9.0.5",
    "@types/multer": "^1.4.11",
    "@types/nodemailer": "^7.0.3",
    "typescript": "^5.3.3",
    "ts-node": "^10.9.2",
    "nodemon": "^3.0.2"
  }
}
```

### 8. tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
```

## 🔐 Middleware de Autenticación (src/middleware/auth.middleware.ts)

```typescript
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

interface JWTPayload {
  userId: number;
  username: string;
  role: string;
}

export const authenticate = (req: Request, res: Response, next: NextFunction) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');

    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'No autorizado',
        error: {
          code: 'UNAUTHORIZED',
        },
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as JWTPayload;
    
    // Agregar usuario al request
    (req as any).user = decoded;
    
    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: 'Token inválido',
      error: {
        code: 'INVALID_TOKEN',
      },
    });
  }
};
```

## 📝 Uso desde el Frontend

```typescript
// En el frontend Next.js, reemplazar:
// import { cabanaModels } from '@/lib/data/cabanas';

// Por:
const fetchCabanas = async () => {
  const response = await fetch('http://localhost:3001/api/cabanas');
  const data = await response.json();
  return data.data; // Array de cabañas
};

// En un componente:
export default function ModelsSection() {
  const [cabanas, setCabanas] = useState<CabanaModel[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchCabanas()
      .then(setCabanas)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <div>Cargando...</div>;

  return (
    <div>
      {cabanas.map(cabana => (
        <CabanaCard key={cabana.id} cabana={cabana} />
      ))}
    </div>
  );
}
```

## 🚀 Comandos para Ejecutar

```bash
# 1. Crear la base de datos
createdb cabanas_db

# 2. Ejecutar el esquema
psql -d cabanas_db -f backend-export/migration-scripts.sql

# 3. Instalar dependencias
npm install

# 4. Configurar .env
cp .env.example .env
# Editar .env con tus credenciales

# 5. Ejecutar en desarrollo
npm run dev

# El servidor estará en http://localhost:3001
```

## ✅ Testing

```bash
# Test endpoint
curl http://localhost:3001/api/cabanas

# Debería retornar:
{
  "success": true,
  "data": [
    {
      "id": "modelo-uno",
      "name": "Modelo Uno",
      ...
    }
  ]
}
```

Esta es una implementación básica. Para producción, considera agregar:
- Validación de entrada con Zod
- Cache con Redis
- Rate limiting
- Logging con Winston
- Tests con Jest
- Documentación con Swagger
