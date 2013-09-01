From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] serial: pch_uart: Add MODULE_DEVICE_TABLE
Date: Sun, 01 Sep 2013 19:26:37 +0100
Message-ID: <1378059997.25743.37.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JncwDUS9Pcpv7vubXDQK"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59587 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756170Ab3IAS0q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Sep 2013 14:26:46 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org


--=-JncwDUS9Pcpv7vubXDQK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pch_uart currently isn't auto-loaded if built as a module.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
Compile-tested only.

Ben.

 drivers/tty/serial/pch_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 572d481..bead25c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1975,6 +1975,8 @@ module_exit(pch_uart_module_exit);
=20
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel EG20T PCH UART PCI Driver");
+MODULE_DEVICE_TABLE(pci, pch_uart_pci_id);
+
 module_param(default_baud, uint, S_IRUGO);
 MODULE_PARM_DESC(default_baud,
                  "Default BAUD for initial driver state and console (defau=
lt 9600)");


--=-JncwDUS9Pcpv7vubXDQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUiOG3ee/yOyVhhEJAQoPuhAAxPkA9hDvDdZ17xtS1PQOEw0Uu/RXt0Cz
kzWO8tf9/2D4td6XCDXPNe3rMNwuzcdJQZ6nFiSgW44Re+mad5P/XB6kvlMMRoev
gNyBsrxzW/Xipz50qna5okKqZzhMuP9Wf8w5KtBLzlJYAaInjqYLmkRvfnIy5ELy
b/KEPgDfTbQ3PXToZK44GgR1qVnGTjLXrjHItLsL+a5Uw9vjLNgQko84RvxW5IeK
TO192vKGN5wyT+dMMBcMiLtNxiYuVhar3zE7ECeqMk6Z/4Vs75XvDjEheh2ojig7
WqS8q+ANhEvi+vR2iXTMja4MIm8ABTzBjw5YVdmSQI8LwKgqKND0y8Y2igpKjYCD
hT2YitBh+g3gUcqVlaxtW1zy7s4ZFCacXIj554hCu+9UdRMT5FQL+zkI5HzZok8L
kN+1ba28JKgzTpMpaObfCCgICYzT1mC+QQOHIikgH9MQLDU7AUeaTZBqtM9sXIRC
RbzJIDrcPZYcEXJtQMyEEi7vjaVXA+TSsdq1JRYFg3AUwj+h50csquHp0VRIq0Zz
YKFdpl7hKONgqpa7wTIY6qaBoz5XTsWSnXZqvvRFXWUO5+lwx32OxD4awmi78Pr+
P26pZR1RhuR1xvdK3sZee0iPYs+y+iPSkG6wPFU5dAl42OD8IqJwbscNjU1KEeV1
jrJ4CWMZJZY=
=GQJr
-----END PGP SIGNATURE-----

--=-JncwDUS9Pcpv7vubXDQK--
