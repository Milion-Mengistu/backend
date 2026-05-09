import { PrismaClient } from '@prisma/client';

import { env } from '../config/env';

export const prisma = env.prismaConfigured
  ? new PrismaClient({
      datasources: {
        db: {
          url: env.supabasePrismaUrl,
        },
      },
    })
  : null;
