From: Stephan Fabel <sfabel@hawaii.edu>
Subject: Intel 82801 DB LPC I/O ports trouble
Date: Mon, 15 Feb 2010 10:40:22 -1000
Message-ID: <4B79B136.3000506@hawaii.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig4A3323C16F4387896A33DFD4
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta11.its.hawaii.edu ([128.171.224.147]:33793 "EHLO
	mta11.its.hawaii.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab0BOVk1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Feb 2010 16:40:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A3323C16F4387896A33DFD4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I've been banging my head on this issue for a couple of days now and
would appreciate any help or pointers in the right direction. I've got
an Intel-based motherboard with the above mentioned LPC bus integrated.
There is one regular serial port included (DB 9), the rest is on the
bus. I've got several motor controllers hanging on that bus. Under
Windows, they are attached to COM4, 5 and 6.

Under Linux (2.6.31/Ubuntu stock kernel), I only get /dev/ttyS{0,1,2,3}
initially. Ports 0-2 are dead, under ttyS3 I can access one motor. So I
used the boot parameter 8250.nr_uarts=3D6 to try and see if that changes
anything, and it does: I've got /dev/ttyS{4,5} now. But the I/O ports
are messed up.

A quick look in the BIOS revealed that serial port 5 lives at I/O 0x4e8
and port 6 at 0x4f8.

However, dmesg shows these ports in reverse:
-----snip-----
[    1.015356] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.015479] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    1.015619] serial8250: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
[    1.015729] serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) is a 16550A
[    1.016355] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.016584] 00:10: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    1.016763] 00:11: ttyS2 at I/O 0x3e8 (irq =3D 3) is a 16550A
[    1.016937] 00:12: ttyS3 at I/O 0x2e8 (irq =3D 4) is a 16550A
[    1.017113] 00:13: ttyS4 at I/O 0x4f8 (irq =3D 5) is a 16550A
[    1.017289] 00:14: ttyS5 at I/O 0x4e8 (irq =3D 9) is a 16550A
-----snip-----

So I made sure I did not oversee anything; but I did not. Every time I
change this in the BIOS, it shows up in reverse in dmesg; I cannot use
setserial to change it, either. I should mention that the IRQs are set
correctly and I've tried changing them (with one eye on the
Serial-HOWTO), and these changes get accepted.

Now the above only shows the first four as output from serial8250, and
then lists them again, this time all 6 of them.

What can I do? Is there a way to move /dev/ttyS{0-2} to wherever my
motor controllers are? Do I recompile the kernel with some option
enabled or changed? To I have to rewire the LPC port? Is support for the
Intel 82801 DB LPC broken?

Thanks for any help on this.

Stephan


--------------enig4A3323C16F4387896A33DFD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt5sToACgkQR5gdo7STZJh9SACg1K+lSxh4CRHqtyb6RkRk08Ur
K2sAoLLJLN3TMhHWKg3j8U5A3nROVQA+
=FCe3
-----END PGP SIGNATURE-----

--------------enig4A3323C16F4387896A33DFD4--
