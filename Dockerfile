# the build phase
FROM node:16-alpine as builder

WORKDIR '/app'

# as production, not concerned about code changes
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# care about /app/build after run build completes
# the RUN phase

# the 'FROM' statement, one per section, marks a new phase
FROM nginx

# copy from build, and to correct place served up by nginx
COPY --from=builder /app/build  /usr/share/nginx/html

# default command in nginx container is to start it
