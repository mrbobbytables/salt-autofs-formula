=======
Aautofs
=======

Formula for managing autofs, currently only nfs is supported.

Tested with the following platforms:

- CentOS 7
- Debian 7 (Wheezy)
- Debian 8 (Jessie)
- Fedora 22
- Fedora 23
- Oracle Linux 7
- Ubuntu 12.04 (Precise)
- Ubuntu 14.04 (Trusty)

----

.. contents::

Pillar Example

:: 

  autofs:
    lookup:
      nfs:
        key: /mnt/nfs
        file: /etc/auto.nfs
        options: --timeout 60
        map:
          - mount: meda
            options: -fstype=nfs,vers=3,rw,soft,intr,rsize=8192,wsize=8192,noexec,nosuid,tcp
            location: 192.168.0.101:/share/media
          - mount: app
            options: -fstype=nfs4,ver4,rw,soft
            location: 192.168.0.105:/share/app


States
======

``autofs``
----------

Meta state for ``autofs.install``, ``autofs.config``, and ``autofs.service``


``autofs.install``

Installs both autofs and any dependencies needed for the mount type.


``autofs.config``

Configures the ``auto.master`` file and includes states for any subsequent mount types.


``autofs.service``

Enables the autofs service.


``autofs.ntfs``
Conigures nfs for use with autofs.

