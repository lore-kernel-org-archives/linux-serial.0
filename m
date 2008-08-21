From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 14/39] pcmcia: use pcmcia_loop_config in misc pcmcia
	drivers
Date: Thu, 21 Aug 2008 17:57:33 +0800
Message-ID: <20080821095733.GH4988@prithivi.gnumonks.org>
References: <20080818185025.GA11647@comet.dominikbrodowski.net> <1219085610-12289-14-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:54451 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbYHUKBA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Aug 2008 06:01:00 -0400
Content-Disposition: inline
In-Reply-To: <1219085610-12289-14-git-send-email-linux@dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-parport@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ed Okerson <eokerson@quicknet.net>, linux-serial@vger.kernel.org, boti@rocketmail.com, linux-usb@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for your patch, Dominik,

On Mon, Aug 18, 2008 at 08:53:05PM +0200, Dominik Brodowski wrote:

> Use the config loop helper in misc pcmcia drivers.

This looks fine to me (for cm4000_cs and cm4040_cs), although I cannot test=
 it
since I'm currently travelling for more than a month and don't have the dev=
ice
with me.

Can you (or anyone else who has the hardware) give it a short test if it
actually still enumerates the hardware correctly?

Thanks.
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIrTwNXaXGVTD0i/8RAjJMAJ4owSmKy9q6MO79+OeN8EJZKqXVNgCfQhf1
Ftinn55gbIwgaEb55a+k1UQ=
=MZ+s
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
