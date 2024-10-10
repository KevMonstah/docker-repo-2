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

# am not at all sure this is necessary, as app worked already and deployed.
# EXPOSE 80  this is NOT NEEDED now.  onld "Linux 1" platform it was, but "Linux 2", it is not.

# copy from build, and to correct place served up by nginx
COPY --from=builder /app/build  /usr/share/nginx/html

# default command in nginx container is to start it
