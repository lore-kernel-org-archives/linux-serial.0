From: Craig Shelley <craig@microtron.org.uk>
Subject: tx_loadsz setserial bug?
Date: Fri, 11 Mar 2005 15:40:20 +0000
Message-ID: <1110555620.7777.19.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6CT/nRn4eXRbi7/42j5F"
Received: from i-195-137-47-43.freedom2surf.net ([195.137.47.43]:60168 "EHLO
	microtron.org.uk") by vger.kernel.org with ESMTP id S263381AbVCKPkU
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Mar 2005 10:40:20 -0500
Received: from [192.168.1.201] (helo=teratron.lan.etheus.net)
	by microtron.org.uk with asmtp Microtron Mail Server (Exim)
	id 1D9mFP-0004uO-00
	for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2005 15:40:19 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--=-6CT/nRn4eXRbi7/42j5F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
I think there may be a bug in 8250.c (linux 2.6.10) whereby tx_loadsz
(and possibly other info) is not updated when changing the uart type
using setserial eg

# setserial /dev/ttyS4
/dev/ttyS4, UART: 16550A, Port: 0xd000, IRQ: 5

# setserial /dev/ttyS4 uart 16550

# setserial /dev/ttyS4
/dev/ttyS4, UART: 16550, Port: 0xd000, IRQ: 5

Since tc_loadsz only gets set during autoconfig, it doesn't reflect the
port settings made using setserial

Replacing
	count =3D up->tx_loadsz;
With
	count =3D uart_config[up->port.type].tx_loadsz;

On line 1122 seemed to cure my problem as a temporary bodge fix, but it
looks like a more significant alteration is required in order to fix it
properly.



--=20
Craig Shelley
EMail: craig@microtron.org.uk
Jabber: shell@jabber.earth.li

--=-6CT/nRn4eXRbi7/42j5F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCMbvk5OI9vmOoVqERApwWAKDr52YKyddhelvy2WPjgGtUjGptUwCfbE9i
XwMnfDBEBXr+0egVA+0aBrc=
=KPXS
-----END PGP SIGNATURE-----

--=-6CT/nRn4eXRbi7/42j5F--

