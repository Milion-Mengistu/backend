import { app } from './app';
import { env } from './config/env';

app.listen(env.port, env.host, () => {
  const displayHost = env.host === '0.0.0.0' ? 'localhost' : env.host;
  process.stdout.write(`Server listening on http://${displayHost}:${env.port}\n`);
});
