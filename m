From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 13:47:29 +0200
Message-ID: <200807241347.33261.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4381106.WzZlGy1zZP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:57989 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693AbYGXLrg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 07:47:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk

--nextPart4381106.WzZlGy1zZP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds support for the automatic RS485 direction control feature
present in 16850 UARTs.

A new termios c_cflag, CARTS, is introduced to configure automatic direction
control from userspace.

This is a first proposal. I'm open to suggestions regarding the CARTS name.
I assume the CARTS flag will have to be added to all asm/termbits.h headers.
Why are the termios bits definitions platform specific ?

=2D--
 drivers/serial/8250.c          |   14 ++++++++++++++
 include/asm-powerpc/termbits.h |    1 +
 include/linux/serial_reg.h     |    1 +
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 62a2e49..a1351d5 100644
=2D-- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2071,6 +2071,20 @@ serial8250_set_termios(struct uart_port *port, struc=
t ktermios *termios,
 	if (up->port.type =3D=3D PORT_16750)
 		serial_outp(up, UART_FCR, fcr);
=20
+#ifdef CARTS
+	/* Auto RS485 Direction Control on 16850 UARTs */
+	if (up->port.type =3D=3D PORT_16850) {
+		unsigned char fctr;
+
+		serial_outp(up, UART_LCR, 0xbf);
+		fctr =3D serial_inp(up, UART_FCTR) & ~UART_FCTR_RS485;
+		if (termios->c_cflag & CARTS)
+			fctr |=3D UART_FCTR_RS485;
+		serial_outp(up, UART_FCTR, fctr);
+		serial_outp(up, UART_LCR, 0);
+	}
+#endif
+
 	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
 	up->lcr =3D cval;					/* Save LCR */
 	if (up->port.type !=3D PORT_16750) {
diff --git a/include/asm-powerpc/termbits.h b/include/asm-powerpc/termbits.h
index 5e79198..7b7ee27 100644
=2D-- a/include/asm-powerpc/termbits.h
+++ b/include/asm-powerpc/termbits.h
@@ -166,6 +166,7 @@ struct ktermios {
 #define HUPCL	00040000
=20
 #define CLOCAL	00100000
+#define CARTS	  004000000000		/* auto RTS control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
=20
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3c8a6aa..3db78cc 100644
=2D-- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -188,6 +188,7 @@
 #define UART_FCTR_RTS_8DELAY	0x03
 #define UART_FCTR_IRDA		0x04  /* IrDa data encode select */
 #define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
+#define UART_FCTR_RS485		0x08  /* Auto RS485 direction control */
 #define UART_FCTR_TRGA		0x00  /* Tx/Rx 550 trigger table select */
 #define UART_FCTR_TRGB		0x10  /* Tx/Rx 650 trigger table select */
 #define UART_FCTR_TRGC		0x20  /* Tx/Rx 654 trigger table select */
=2D-=20
1.5.0

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4381106.WzZlGy1zZP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIa9UACgkQ8y9gWxC9vpezPwCffn6EzMI6b4ihUFMBEW9UEBXE
wjwAoLTfU0feHk24ZMKh1wlmY+cmfztZ
=kKN6
-----END PGP SIGNATURE-----

--nextPart4381106.WzZlGy1zZP--
