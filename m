From: Amit Kucheria <akucheria@metricsystems.com>
Subject: persistent slip connections
Date: Fri, 26 Sep 2003 16:13:30 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1064618009.1332.14.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-PFBvdBNa6NBgJchgFxzd";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta6.algx.net ([67.92.168.235]:23853 "EHLO chimta05.algx.net")
	by vger.kernel.org with ESMTP id S261712AbTIZXMv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Sep 2003 19:12:51 -0400
Received: from wireless-4
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx05.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HLU00DXOGHEMJ@chimmx05.algx.net> for
 linux-serial@vger.kernel.org; Fri, 26 Sep 2003 18:12:50 -0500 (CDT)
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>


--=-PFBvdBNa6NBgJchgFxzd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I currently use 'slattach' (actually a modified version) to setup a SLIP
connection between two machines. But when I unplug the cable and replug
it back in, I have to reconfigure the connection at both end.

Could this be handled in the slattach program, so that it does not
'hangup' due to loss of DCD or DSR?

TIA.

Regards,
Amit

--=20
     .| Amit Kucheria                       |.
   ...| Wireless Systems Engineer           |...
 .....| Metric Systems Corp., San Diego, CA |.....
......| www.metricsystems.com               |......

--=-PFBvdBNa6NBgJchgFxzd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/dMgZtLg6PvU36DYRAjNgAKCmjit41XJ3euinFW0wAikDOF2dNwCaAhhM
LWPMO1ChkXbfjccKm7fpHdY=
=Os1L
-----END PGP SIGNATURE-----

--=-PFBvdBNa6NBgJchgFxzd--

