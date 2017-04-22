From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] serial: exar: Fix stuck MSIs
Date: Sat, 22 Apr 2017 11:36:32 +0200
Message-ID: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mtm2ea0IcWAwAl8jNxpDfHT6SRvD9RajE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mtm2ea0IcWAwAl8jNxpDfHT6SRvD9RajE
Content-Type: multipart/mixed; boundary="RG306MB0vmN7k9TeqVQ8v735xAdu1KERr";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-serial@vger.kernel.org,
 Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
Subject: [PATCH] serial: exar: Fix stuck MSIs

--RG306MB0vmN7k9TeqVQ8v735xAdu1KERr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Jan Kiszka <jan.kiszka@siemens.com>

After migrating 8250_exar to MSI in 172c33cb61da, we can get stuck
without further interrupts because of the special wake-up event these
chips send. They are only cleared by reading INT0. As we fail to do so
during startup and shutdown, we can leave the interrupt line asserted,
which is fatal with edge-triggered MSIs.

Add the required reading of INT0 to startup and shutdown. Also account
for the fact that a pending wake-up interrupt means we have to return 1
from exar_handle_irq.

An alternative approach would have been disabling the wake-up interrupt.
Unfortunately, this feature (REGB[17] =3D 1) is not available on the
XR17D15X.

Fixes: 172c33cb61da ("serial: exar: Enable MSI support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Regression of upcoming 4.11.

 drivers/tty/serial/8250/8250_port.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
index 6119516ef5fc..3a3667880fcf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -47,6 +47,7 @@
 /*
  * These are definitions for the Exar XR17V35X and XR17(C|D)15X
  */
+#define UART_EXAR_INT0		0x80
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
=20
@@ -1869,17 +1870,13 @@ static int serial8250_default_handle_irq(struct u=
art_port *port)
 static int exar_handle_irq(struct uart_port *port)
 {
 	unsigned int iir =3D serial_port_in(port, UART_IIR);
-	int ret;
+	int ret =3D 0;
=20
-	ret =3D serial8250_handle_irq(port, iir);
+	if (((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D PORT_XR17D=
15X)) &&
+	    serial_port_in(port, UART_EXAR_INT0) !=3D 0)
+		ret =3D 1;
=20
-	if ((port->type =3D=3D PORT_XR17V35X) ||
-	   (port->type =3D=3D PORT_XR17D15X)) {
-		serial_port_in(port, 0x80);
-		serial_port_in(port, 0x81);
-		serial_port_in(port, 0x82);
-		serial_port_in(port, 0x83);
-	}
+	ret |=3D serial8250_handle_irq(port, iir);
=20
 	return ret;
 }
@@ -2177,6 +2174,8 @@ int serial8250_do_startup(struct uart_port *port)
 	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
+	if ((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D PORT_XR17D1=
5X))
+		serial_port_in(port, UART_EXAR_INT0);
=20
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2335,6 +2334,8 @@ int serial8250_do_startup(struct uart_port *port)
 	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
+	if ((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D PORT_XR17D1=
5X))
+		serial_port_in(port, UART_EXAR_INT0);
 	up->lsr_saved_flags =3D 0;
 	up->msr_saved_flags =3D 0;
=20
--=20
2.12.0


--RG306MB0vmN7k9TeqVQ8v735xAdu1KERr--

--mtm2ea0IcWAwAl8jNxpDfHT6SRvD9RajE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlj7JCUACgkQitSsb3rl5xTLIgCgtVfgCSSYiBPzLqipfUdxZ+SU
mdgAn3T/gUDwRJzDXGOXuvKa217T2jj9
=ehrG
-----END PGP SIGNATURE-----

--mtm2ea0IcWAwAl8jNxpDfHT6SRvD9RajE--
