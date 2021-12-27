# lahr.codes website code

The site is deployed to [lahr.codes](lahr.codes)
The site is built with the static site generator Hugo.

## Local Development

1. Prerequisites are [hugo](https://gohugo.io/) and `npm`.

2. clone this repository: `git clone https://github.com/codeforlahr/lahr.codes/`
3. We need npm for postcss and some of its plugins (See: https://gohugo.io/hugo-pipes/postcss/)

```bash
npm install postcss-cli autoprefixer postcss-custom-media postcss-preset-env postcss-import
```

4. Start development server with: `hugo server`

### Alternative: Docker development environment

First build the image.
This will install npm dependencies and initialize the app with the current state of your local repository.
```bash
cd <checked-out repository>
docker build -t lahr.codes .
```

Start the docker container. This automatically mounts your working directory through the option ``-v `pwd`:/usr/src/app/site``:
```bash
docker run -ti --name lahr.codes -v `pwd`/site:/usr/src/app/site -p 1313:1313 -d  lahr.codes:latest
```

Browse to [0.0.0.0:1313](0.0.0.0:1313)

## Layouts

The template is based on small, content-agnostic partials that can be mixed and matched. The pre-built pages showcase just a few of the possible combinations. Refer to the `site/layouts/partials` folder for all available partials.

Use Hugo’s `dict` functionality to feed content into partials and avoid repeating yourself and creating discrepancies.

## CSS

The template uses a custom fork of Tachyons and PostCSS with cssnext and cssnano. To customize the template for your brand, refer to `src/css/imports/_variables.css` where most of the important global variables like colors and spacing are stored.

## SVG

All SVG icons stored in `site/static/img/icons` ~~are automatically optimized with SVGO (gulp-svgmin) and concatenated into a single SVG sprite stored as a a partial called `svg.html`. Make sure you use consistent icons in terms of viewport and art direction for optimal results. Refer to an SVG via the `<use>` tag like so:~~

```
<svg width="16px" height="16px" class="db">
  <use xlink:href="#SVG-ID"></use>
</svg>
```

are currently not optimized. The optimization was removed somewhere during template development.
An [issue](https://github.com/netlify-templates/one-click-hugo-cms/issues/213) was created, but was not fixed yet.
If someone with npm experience, wants to fix this, feel free to do so.
But I think gulp is no longer used in this template, and you'd have to use another tool.
Currently the icons are loaded as simple svg files.


## About the Theme 

The Kaldi Theme templete from Netlify is used. 
This is a small business template built with [Victor Hugo](https://github.com/netlify/victor-hugo).