#!/usr/bin/env elvish

nop ?(rm posts/*.md)

rg 'aca.github.io' ~/src/zk --files-with-matches | from-lines | each { |x| 
    cp -v $x src/posts/
}

pnpm run build
