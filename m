From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: interrupt programming
Date: Mon, 26 Jul 2004 10:08:08 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040726080808.GW18676@lug-owl.de>
References: <BAY15-F21ZXn97cvZvK00022be7@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BjOm3tsK/2NdfZj2"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:6382 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265027AbUGZIIJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2004 04:08:09 -0400
Content-Disposition: inline
In-Reply-To: <BAY15-F21ZXn97cvZvK00022be7@hotmail.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--BjOm3tsK/2NdfZj2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-26 09:24:42 +0200, Sayang Oin <sayangoin@hotmail.com>
wrote in message <BAY15-F21ZXn97cvZvK00022be7@hotmail.com>:
>=20
> I have to use timer because I have to communicate with other programm via=
=20
> filestream
> and I use this timer also for scheduling the time that I have to send dat=
a=20
> to my device.

That's quite DOSsish thinking. You've got several variants you can
choose from:

	1. Use non-blocking I/O with select() and toggle between your
	   two (or several) tasks.
	2. Separate all workplaces into one thread each.
	2b. Mix both variants.

> people said if I use interrupt so I can be sure I will not lose my datas.

You can't be *sure* to not loose data. Even with using interrupts, there
are possible conditions in which you'd loose some bytes of data due to
overflows. Think eg. about long-running IDE interrupts. While they're
running, no other IRQs will be serviced (unless you've got several
CPUs--it may be different in that case). That is, if eg. a 16byte FIFO
of a serial UART fills up, it'll overrun. At 115200 Baud, you need
little less than 1.5ms -- IDE interrupts can go up over 500ms easily, at
least with no DMA:)

> here is my routine
> ....
>=20
>  while(1)
>  {
> 		res=3Dselect(fd+1, &rfds, NULL, NULL, &tv);

Hopefully you re-initialize tv before each call to select:)

>  return rd;
> }


But that's all not your problem. Your UART (or it's driver) thinks it's
not allowed to send out data. There's the problem.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--BjOm3tsK/2NdfZj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBLvoHb1edYOZ4bsRAhAIAJ9O4hkNc5GlvVLcItUpIvuw3+inWACfSMEF
iZACLyPl2rV02GyxXRJDvHA=
=5mfE
-----END PGP SIGNATURE-----

--BjOm3tsK/2NdfZj2--
