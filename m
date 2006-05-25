From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] Late console
Date: Thu, 25 May 2006 17:26:50 +0200
Message-ID: <20060525152650.GA31742@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:25533 "EHLO
	goldrake.enneenne.com") by vger.kernel.org with ESMTP
	id S965203AbWEYP0x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 May 2006 11:26:53 -0400
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FjHfs-0004Jg-EP
	for linux-serial@vger.kernel.org; Thu, 25 May 2006 17:22:59 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FjHje-0002lE-L7
	for linux-serial@vger.kernel.org; Thu, 25 May 2006 17:26:50 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: multipart/mixed; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

due my job on sleep mode for MIPS au1x00 I need the serial console
till sleep time so let me propose this patch that disables serial port
suspend if a console is running on it and the kernel has
CONFIG_DEBUG_KERNEL flag on.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1x00-late-console
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9e27aee..27ed4f2 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1919,6 +1919,14 @@ int uart_suspend_port(struct uart_driver
 {
 	struct uart_state *state =3D drv->state + port->line;
=20
+#ifdef CONFIG_DEBUG_KERNEL
+	if (uart_console(port)) {
+		printk(KERN_INFO "warning! Serial console %s%d is not disabled in debug =
kernel mode\n",
+			drv->dev_name, port->line);
+		return 0;
+	}
+#endif
+
 	mutex_lock(&state->mutex);
=20
 	if (state->info && state->info->flags & UIF_INITIALIZED) {

--3uo+9/B/ebqu+fSQ--

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEdcy6QaTCYNJaVjMRAt74AKCru9/pOPJCp/q5SY+a9vsm+X7/0QCgjFOC
5KHZabf9dxbHIsk5oofOFpI=
=DIrB
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
