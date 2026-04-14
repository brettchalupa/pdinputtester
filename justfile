bin := "YOURGAME.pdx"

default:
    @just choose

setup:
    git submodule update --init --recursive

build:
    pdc source {{ bin }}

run: build
    open {{ bin }}

clean:
    rm -rf {{ bin }}

release:
    ruby release.rb
