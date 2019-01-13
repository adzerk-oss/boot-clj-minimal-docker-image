# boot-clj-minimal

Runs [Boot][1] in Docker, allowing the user to mount volumes from the host for
the Maven and Boot caches, and the project directory. Also creates the user in
the container and runs Boot as that user so files created by Boot will be owned
by the user and not root.

```bash
# in your project directory
cd /my/project

# run boot watch build
docker run --rm adzerk/boot-clj-minimal:latest watch build |bash
```

[1]: https://github.com/boot-clj/boot
