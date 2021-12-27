FROM klakegg/hugo:ext-alpine

# Use this app directory moving forward through this file
WORKDIR /usr/src/app/

# We need npm for postcss and some of its plugins (See: https://gohugo.io/hugo-pipes/postcss/)
RUN apk add --update npm
RUN npm cache clean --force
RUN npm install -g postcss-cli autoprefixer
RUN npm install postcss-custom-media postcss-preset-env postcss-import

# Copy over the host's project files
COPY . /usr/src/app/site
# This provides a starting point, but will later be overridden by `docker run -v...`

EXPOSE 1313
CMD [ "server", "-s", "./site" ]

