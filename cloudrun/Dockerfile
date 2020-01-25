from alpine:3.11.3

arg HUGO_RELEASE=0.63.1
env PORT=1313

add https://github.com/gohugoio/hugo/releases/download/v${HUGO_RELEASE}/hugo_${HUGO_RELEASE}_Linux-64bit.tar.gz /

run mkdir /hugo
run tar xf hugo_${HUGO_RELEASE}_Linux-64bit.tar.gz -C /hugo
run rm hugo_${HUGO_RELEASE}_Linux-64bit.tar.gz

run mkdir /sqrt26
copy hugo /sqrt26

workdir /sqrt26
entrypoint /hugo/hugo server --bind 0.0.0.0 --port ${PORT}
