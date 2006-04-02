From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Hang in uart_block_til_ready()
Date: Sun, 2 Apr 2006 15:51:38 +0200
Message-ID: <20060402135138.GC2954@hansmi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:52508 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932339AbWDBNvp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Apr 2006 09:51:45 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Russell

I've discovered a problem where I'm not sure wether it's an error in the
kernel or in the hardware.

The hardware I'm using for the serial console is a HP Lights-Out 100
Management. It provides a (virtual) serial port which then can be used
for remote administration over the network and is available as ttyS2 in
Linux. I'm using it for a serial console.

When doing open("/dev/ttyS2", O_RDWR) from userland, like it's done by
screen(1) and by my test program, the kernel "hangs" in the schedule()
call in the function uart_block_til_ready of serial_core.c.

The patch below fixes it, but I'm not sure wether it is the correct way,
nor if it might create other problems.

The problem was reproducable with 2.6.15.6, 2.6.16 and 2.6.16-git20 (all
vanilla). I've not been able to reproduce it on another box where the
serial console is on ttyS0 and done by a common 16550A-compatible chip.

Do you or somebody else have an idea what's going on here and how to fix
it correctly?

Thanks,
Michael

---
--- linux-2.6.16-hardened/drivers/serial/serial_core.c.orig	2006-04-02 15:0=
7:43.000000000 +0200
+++ linux-2.6.16-hardened/drivers/serial/serial_core.c	2006-04-02 15:24:52.=
000000000 +0200
@@ -1456,6 +1456,10 @@ uart_block_til_ready(struct file *filp,=20
 			break;
 		}
=20
+		/* hansmi: fixes a hang on open("/dev/ttyS2", O_RDWR) for me */
+		if (uart_console(port) && (port->cons->flags & CON_ENABLED))
+			break;
+
 		/*
 		 * Set DTR to allow modem to know we're waiting.  Do
 		 * not set RTS here - we want to make sure we catch

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL9bq6J0saEpRu+oRAvn7AJ9cj5Tlw6iyJIrlI6DnFH8JnqgqzwCeInSJ
dQ0UtEXD6xknG85yLvNy1ck=
=gT89
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
