/**
 * Definiciones de Tipos TypeScript para Backend API
 * Exportadas desde el frontend - manteniendo compatibilidad
 */

// ============================================
// TIPOS DE MODELOS DE DATOS
// ============================================

export interface CabanaModel {
  id: string;
  name: string;
  slug: string;
  description: string;
  dimensions: {
    area: number;
    bedrooms: number;
    bathrooms: number;
    floors: number;
  };
  features: string[];
  price: {
    amount: number;
    currency: string;
    period?: string;
  };
  images: {
    main: string;
    gallery: string[];
    thumbnail: string;
  };
  specifications: {
    label: string;
    value: string;
  }[];
  available: boolean;
}

export interface CompanyFeature {
  id: string;
  title: string;
  subtitle: string;
  description: string;
  icon: string;
}

export interface Benefit {
  id: string;
  title: string;
  description: string;
  icon: string;
  details?: string;
}

export interface GalleryImage {
  id: string;
  src: string;
  alt: string;
  category: 'exterior' | 'interior' | 'amenities' | 'landscape';
  width: number;
  height: number;
  thumbnail?: string;
}

export interface SocialLink {
  id: string;
  platform: 'facebook' | 'instagram' | 'twitter' | 'youtube' | 'whatsapp' | 'email';
  url: string;
  label: string;
  icon: string;
}

export interface NavItem {
  id: string;
  label: string;
  href: string;
  external?: boolean;
}

export interface SiteConfig {
  name: string;
  description: string;
  url: string;
  ogImage: string;
  keywords: string[];
  author: {
    name: string;
    email: string;
  };
  social: SocialLink[];
}

// ============================================
// TIPOS DE FORMULARIOS
// ============================================

export interface ContactFormData {
  name: string;
  email: string;
  phone: string;
  message: string;
  preferredModel?: string;
  privacyAccepted: boolean;
}

export interface ContactFormErrors {
  name?: string;
  email?: string;
  phone?: string;
  message?: string;
  privacyAccepted?: string;
}

// ============================================
// TIPOS DE RESPUESTAS API
// ============================================

export interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data?: T;
  error?: {
    code: string;
    details?: unknown;
  };
}

export interface PaginatedResponse<T> {
  success: boolean;
  data: T[];
  pagination: {
    page: number;
    perPage: number;
    total: number;
    totalPages: number;
  };
}

// ============================================
// TIPOS DE BASE DE DATOS
// ============================================

export interface DBCabana {
  id: string;
  name: string;
  slug: string;
  description: string;
  area: number;
  bedrooms: number;
  bathrooms: number;
  floors: number;
  price_amount: number;
  price_currency: string;
  price_period: string;
  main_image: string;
  thumbnail: string;
  available: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBCabanaFeature {
  id: number;
  cabana_id: string;
  feature: string;
  order_index: number;
}

export interface DBCabanaSpecification {
  id: number;
  cabana_id: string;
  label: string;
  value: string;
  order_index: number;
}

export interface DBCabanaGallery {
  id: number;
  cabana_id: string;
  image_url: string;
  order_index: number;
}

export interface DBCompanyFeature {
  id: string;
  title: string;
  subtitle: string;
  description: string;
  icon: string;
  order_index: number;
  active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBBenefit {
  id: string;
  title: string;
  description: string;
  icon: string;
  details?: string;
  order_index: number;
  active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBGalleryImage {
  id: string;
  src: string;
  alt: string;
  category: 'exterior' | 'interior' | 'amenities' | 'landscape';
  width: number;
  height: number;
  thumbnail?: string;
  order_index: number;
  active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBSocialLink {
  id: string;
  platform: string;
  url: string;
  label: string;
  icon: string;
  order_index: number;
  active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBNavigation {
  id: string;
  label: string;
  href: string;
  order_index: number;
  external: boolean;
  active: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface DBContactMessage {
  id: number;
  name: string;
  email: string;
  phone: string;
  message: string;
  preferred_model?: string;
  ip_address?: string;
  status: 'pending' | 'read' | 'replied' | 'archived';
  created_at: Date;
  updated_at: Date;
}

export interface DBAdminUser {
  id: number;
  username: string;
  email: string;
  password_hash: string;
  role: 'admin' | 'super_admin';
  active: boolean;
  last_login?: Date;
  created_at: Date;
  updated_at: Date;
}

// ============================================
// TIPOS DE AUTENTICACIÓN
// ============================================

export interface LoginRequest {
  username: string;
  password: string;
}

export interface LoginResponse {
  success: boolean;
  token?: string;
  user?: {
    id: number;
    username: string;
    email: string;
    role: string;
  };
  error?: string;
}

export interface JWTPayload {
  userId: number;
  username: string;
  role: string;
  iat: number;
  exp: number;
}

// ============================================
// TIPOS DE REQUEST
// ============================================

export interface CreateCabanaRequest {
  name: string;
  slug: string;
  description: string;
  dimensions: {
    area: number;
    bedrooms: number;
    bathrooms: number;
    floors: number;
  };
  features: string[];
  price: {
    amount: number;
    currency: string;
    period?: string;
  };
  images: {
    main: string;
    gallery: string[];
    thumbnail: string;
  };
  specifications: {
    label: string;
    value: string;
  }[];
  available: boolean;
}

export interface UpdateCabanaRequest extends Partial<CreateCabanaRequest> {}

export interface UploadImageRequest {
  file: File | Buffer;
  alt: string;
  category: 'exterior' | 'interior' | 'amenities' | 'landscape';
}

export interface UpdateSiteConfigRequest {
  name?: string;
  description?: string;
  url?: string;
  ogImage?: string;
  keywords?: string[];
  author?: {
    name: string;
    email: string;
  };
}

// ============================================
// TIPOS UTILITARIOS
// ============================================

export type LoadingState = 'idle' | 'loading' | 'success' | 'error';

export interface AsyncState<T = unknown> {
  status: LoadingState;
  data?: T;
  error?: Error | null;
}

export interface QueryParams {
  page?: number;
  perPage?: number;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
  [key: string]: unknown;
}

// ============================================
// TIPOS DE VALIDACIÓN
// ============================================

export interface ValidationError {
  field: string;
  message: string;
}

export interface ValidationResult {
  valid: boolean;
  errors?: ValidationError[];
}

// ============================================
// TIPOS DE CONFIGURACIÓN
// ============================================

export interface EmailConfig {
  from: string;
  to: string;
  subject: string;
}

export interface RateLimitConfig {
  maxRequests: number;
  windowMs: number;
}

export interface DatabaseConfig {
  host: string;
  port: number;
  database: string;
  user: string;
  password: string;
}

export interface ServerConfig {
  port: number;
  host: string;
  cors: {
    origin: string | string[];
    credentials: boolean;
  };
}

// ============================================
// EXPORTS
// ============================================

export type SectionId = 
  | 'hero'
  | 'about'
  | 'benefits'
  | 'models'
  | 'gallery'
  | 'location'
  | 'contact'
  | 'footer';
