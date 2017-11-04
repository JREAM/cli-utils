# CLI Utils

These are general CLI Utils used by myself in bash
to quicken things up.

Each folder is a category which you can do what you like with.


## Docker CLI

This is a utility script for allowed you to work with docker easier;
At the moment, most specifically, micro-services.

### Usage

At this moment, the only file `boot.sh` should be placed alongside
a set of several docker-servers, here is a folder example:
```sh
/app-users
  docker-compose.yml
/app-notes
  docker-compose.yml
/server-proxy
  docker-compose.yml
/server-db
  docker-compose.yml
boot.sh     <-- < Right Here >
```

Run `./boot.sh` to see a list of commands. The first thing
you'll want to do is organize the boot-order (if needed) after
your `bootlist` file is generated.

---

Open Source MIT License

(c) 2017 Jesse Boyer <(JREAM)[https://jream.com)>
