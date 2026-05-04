import express from 'express';

import { env } from './config/env';
import { prisma } from './lib/prisma';

export const app = express();

app.use(express.json());

app.get('/health', (_request, response) => {
  response.json({
    status: 'ok',
    appName: env.appName,
    environment: env.appEnv,
    prismaConfigured: env.prismaConfigured,
    clientReady: Boolean(prisma),
  });
});
