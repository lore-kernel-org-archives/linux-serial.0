From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Suggested patch for linux
Date: Fri, 18 Jul 2008 12:19:50 +0200
Message-ID: <200807181219.54170.laurentp@cse-semaphore.com>
References: <487546D5.8050908@freesurf.ch> <20080710095904.16dfdb08@the-village.bc.nu> <487619C8.7080509@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2391049.2xdlQkOe23";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:61720 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752577AbYGRNS0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jul 2008 09:18:26 -0400
In-Reply-To: <487619C8.7080509@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Axel Hosemann <axel.hosemann@freesurf.ch>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

--nextPart2391049.2xdlQkOe23
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 10 July 2008, Matt Schulte wrote:
>=20
> > The big problem is that the kernel does not know what is a "transmissio=
n"
> > it just sees a series of writes to the device. In many cases the
> > multi-drop or radio systems also need the caller to wait for a
> > transmission slot either by beacon, by timing or by monitoring the
> > carrier detect to avoid collisions.
> I believe that he is referring to something much simpler than you are=20
> thinking.  He is talking about 2-wire RS485 transmissions in which the=20
> RTS signal is used to enable the driver chips just before transmitting=20
> data and disabling (tri-stating) them just after transmitting data. =20
> There are some UARTs that have this behavior built into them.

And that feature is currently not supported by Linux, even with UARTs that =
have hardware support for "Auto RS485" mode, such as the 8250-compatible XR=
16C2850.

The issue is that no flag is defined for the c_cflag field of the termios s=
tructure to enable that feature. The following patch is an example of what =
would be required.

=2D------------------------------------------------------------------------=
=2D---
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
=2D------------------------------------------------------------------------=
=2D---

As we need a new flag which isn't Posix-compliant as far as I know, the sco=
pe of this change can be broader than just the Linux kernel.

Would the above patch be acceptable (I'm open to changes to the CARTS name)=
 as-is, or does it have to be discussed with userspace developers first ?

> > That seems to best be done in user space as the algorithms are quite
> > variable and some are complex.
> >
> > Do we really benefit from having this in kernel ?
> The problem that can come up when executing this feature in user-land=20
> (though not exactly common) is when the hardware on the other end=20
> responds to your message faster than your user app was able to detect=20
> that the UART is finished and then toggle RTS.  When this happens both=20
> ends are trying to drive the line and you have bus contention, lost data=
=20
> and possibly damage to the driver chips themselves.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2391049.2xdlQkOe23
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiAbkoACgkQ8y9gWxC9vpeQLgCfcLxpZgLB7lMkl+l7HBIop7Yi
TmcAoKCEmYENegrgxAg3TbOB9kdxoKGw
=WjFc
-----END PGP SIGNATURE-----

--nextPart2391049.2xdlQkOe23--
