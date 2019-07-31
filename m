From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: xilinx_uartps.c: suppress "may be used uninitialised" warning
Date: Wed, 31 Jul 2019 16:05:57 +1000
Message-ID: <20190731160557.6a09c3e1@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oMq6rKwzq4yIYumawKzTc/R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PPC Development List <linuxppc-dev@lists.ozlabs.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, Linux Serial List <linux-serial@vger.kernel.org>, Linus ARM List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

--Sig_/oMq6rKwzq4yIYumawKzTc/R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

=46rom 31753a44c62c4fdf6e8a72994ae6861dbde49c11 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 Jul 2019 16:00:52 +1000
Subject: [PATCH] xilinx_uartps.c: suppress "may be used uninitialised" warn=
ing

A powerpc allyesconfig build produces this warning:

In file included from include/linux/radix-tree.h:16,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:13,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/device.h:16,
                 from include/linux/platform_device.h:13,
                 from drivers/tty/serial/xilinx_uartps.c:16:
drivers/tty/serial/xilinx_uartps.c: In function 'cdns_uart_console_write':
include/linux/spinlock.h:288:3: warning: 'flags' may be used uninitialized =
in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/xilinx_uartps.c:1197:16: note: 'flags' was declared here
  unsigned long flags;
                ^~~~~

It looks like gcc just can't track the relationship between "locked"
and "flags", and it is obvious that "flags" won't be used when "locked"
is zero, so the simplest thing is to initialise flags.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This has been like this for a very long time, but this is now one of
the few remaining warnings produced by the powerpc allyesconfig build,
so it would be good to get rid of it.

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index f145946f659b..da4563aaaf5c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1194,7 +1194,7 @@ static void cdns_uart_console_write(struct console *c=
o, const char *s,
 				unsigned int count)
 {
 	struct uart_port *port =3D console_port;
-	unsigned long flags;
+	unsigned long flags =3D 0;
 	unsigned int imr, ctrl;
 	int locked =3D 1;
=20
--=20
2.22.0

--=20
Cheers,
Stephen Rothwell

--Sig_/oMq6rKwzq4yIYumawKzTc/R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1BL8UACgkQAVBC80lX
0Gx3MAf+NgUfGWvdNoyBkiRwgAqA7uddSSYmPi/mZ/JfJp7uN+yVTM4AAaDJmkaI
lu52irRBVHp6J20zZjIrF0Nm1taHmDxNoyJacpkM1Za5klHa8DOxvLx01xLUGd7G
91gq2/j2oJYC+pJ3CBkRgt9Vj5GpOwiH+Sirmt71H+Hyno3pyQhQKasUXByHiMtr
RHLewYnj6OgEiU7aVh1Zy+w4JBpnycEETfeONFrI/WWDBsMupTBgeyhqilPsTh9C
hqZx4uJmKwmVsuxOc8We0+HTNCGPEbDV6GrX4hHCzn0EguoAyMjKNOCY11ZSy6SV
esnxLc4sHMDqCMAE4EWD5niCLtNxuQ==
=M6BN
-----END PGP SIGNATURE-----

--Sig_/oMq6rKwzq4yIYumawKzTc/R--
