# ── Stage 1: Install production dependencies only ────────────────────────────
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# ── Stage 2: Minimal runtime image ───────────────────────────────────────────
FROM node:20-alpine
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY server.js .
EXPOSE 8081
CMD ["node", "server.js"]
