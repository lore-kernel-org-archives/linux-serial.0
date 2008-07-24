From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCH] 8250: Add PowerPC-style MMIO support to the 8250 driver
Date: Thu, 24 Jul 2008 14:11:15 +0200
Message-ID: <200807241411.15735.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3842573.kqRf6bcGW7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:43045 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756846AbYGXMLR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:11:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk

--nextPart3842573.kqRf6bcGW7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds support for memory-mapped 8250-like UARTs on PowerPC platfo=
rms.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/serial/8250.c       |   10 ++++++++++
 include/linux/serial_core.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index be95e55..5e0e382 100644
=2D-- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -380,6 +380,10 @@ static unsigned int serial_in(struct uart_8250_port *u=
p, int offset)
 		} else
 			return readb(up->port.membase + offset);
=20
+#ifdef CONFIG_PPC
+	case UPIO_PPC_MMIO:
+		return in_8(up->port.membase + offset);
+#endif
 	default:
 		return inb(up->port.iobase + offset);
 	}
@@ -429,6 +433,12 @@ serial_out(struct uart_8250_port *up, int offset, int =
value)
 			value =3D serial_in(up, UART_IER);
 		break;
=20
+#ifdef CONFIG_PPC
+	case UPIO_PPC_MMIO:
+		out_8(up->port.membase + offset, value);
+		break;
+#endif
+
 	default:
 		outb(value, up->port.iobase + offset);
 	}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d8f31de..1d8b940 100644
=2D-- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -261,6 +261,7 @@ struct uart_port {
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 #define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 #define UPIO_RM9000		(7)			/* RM9000 type IO */
+#define UPIO_PPC_MMIO		(8)			/* PowerPC-style MMIO */
=20
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
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

--nextPart3842573.kqRf6bcGW7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIcWMACgkQ8y9gWxC9vpebcgCeOdLUfomPdNucCE6pLlrKUH12
ZxEAniC7QuULudYYjuuWcX98A/ww0FUp
=bcNA
-----END PGP SIGNATURE-----

--nextPart3842573.kqRf6bcGW7--
