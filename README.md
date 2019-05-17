# Hugo (Extended) + npm + Gulp

Docker image derived from Alpine Linux that includes [Hugo](https://gohugo.io/), plus [npm](https://www.npmjs.com/) and [Gulp](https://gulpjs.com/). Enables building Hugo-based static sites that may include npm and Gulp as part of the workflow. Usable with Bitbucket Pipelines, Gitlab CI, and other automated deployment tools that support Docker.

This image was made specifically for use on a particular type of project. It's meant to enable the use of Hugo Pipes, Sass, and critical CSS with the help of Gulp.

---

Dependencies are kept to a minimum. Submit a pull request for any additional npm packages that you believe could be useful to most Hugo sites. Please refrain from suggesting packages specific to only yourself. For that, I would suggest a fork to customize for your needs.