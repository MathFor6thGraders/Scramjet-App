FROM node:18-alpine

ENV NODE_ENV=production
# Changed to use pnpm for production install
ARG NPM_BUILD="pnpm install --prod"
EXPOSE 8080/tcp

LABEL maintainer="Mercury Workshop"
LABEL summary="Scramjet Demo Image"
LABEL description="Example application of Scramjet"

WORKDIR /app

# 1. Fixed: Copy pnpm-lock.yaml instead of package-lock.json
COPY ["package.json", "pnpm-lock.yaml", "./"]

# 2. Fixed: Added tools and globally installed pnpm so the build works
RUN apk add --upgrade --no-cache python3 make g++ && npm install -g pnpm

RUN $NPM_BUILD

COPY . .

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
