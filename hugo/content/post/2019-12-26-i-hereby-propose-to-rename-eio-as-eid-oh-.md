---
date: 2019-01-26T02:33:47+03:00
title: I Hereby Propose to Rename EIO as EID'oh!
url: /2019-12-26/i-hereby-propose-to-rename-eio-as-eid-oh-
---
If you are implementing a Fuse filesystem it easier than usual to commit to making silly mistakes over and over again. Case in point; obviously any dirent structure couldn't have a name with a `/` in it. However that simple fact might not be apparent if you forget the fact that a filesystem is supposed to be hiearchical. And it that case the error you get isn't very clear (at first):

```
$ ls /tmp/.passfuse/aardvardk
ls: reading directory '/tmp/.passfuse/aardvardk': Input/output error
```

The above output is from where the victim culprit filesystem is mounted on `/tmp/.passfuse`.

And according the strace the `getdents64` is the system call getting the `EIO` (output of `strace -tf ls`):

```strace
388296 01:17:55 getdents64(3, 0x557842209460, 32768) = -1 EIO (Input/output error)
```

That should narrow it down, so after some more 100 tries you can finally try to grep for the definition of `getdents64` in the Linux Kernel source. Which should lead to `fs/readdir.c` files and finally to this verification function:

```c
/*
 * POSIX says that a dirent name cannot contain NULL or a '/'.
 * <snip>
 */
static int verify_dirent_name(const char *name, int len)
{
	if (!len)
		return -EIO;
	if (memchr(name, '/', len))
		return -EIO;
	return 0;
}
```

Available in the latest stable Kernel source from:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/readdir.c?h=v5.4#n111

And doing to obvious fix of avoiding the logical mistake of putting slashes in the dirents fixes the issue:

```bash
$ ls /tmp/.passfuse/aardvardk
foo.gpg
```

This has been a head-against-wall courtesy of [passfuse][passfuse]

[passfuse]: https://github.com/femnad/passfuse
