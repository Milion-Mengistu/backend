import "dotenv/config";

import { z } from "zod";

const envSchema = z.object({
  OPENAI_API_KEY: z.string().min(1, "OPENAI_API_KEY is required"),
  OPENAI_MODEL: z.string().min(1).default("gpt-5.5"),
  AI_RUNTIME: z.enum(["python", "node"]).default("python")
});

const parsed = envSchema.safeParse(process.env);

if (!parsed.success) {
  console.error("AI environment is incomplete.");
  for (const issue of parsed.error.issues) {
    console.error(`- ${issue.path.join(".") || "env"}: ${issue.message}`);
  }
  process.exit(1);
}

console.log("AI environment looks ready.");
console.log(`runtime=${parsed.data.AI_RUNTIME}`);
console.log(`model=${parsed.data.OPENAI_MODEL}`);
