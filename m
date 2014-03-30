From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 1/2] TTY: pmac_zilog, check existence of ports in
 pmz_console_init()
Date: Sun, 30 Mar 2014 17:46:27 +0100
Message-ID: <1396197987.2898.107.camel@deadeye.wl.decadent.org.uk>
References: <1385135247-9068-1-git-send-email-geert@linux-m68k.org>
	 <CAMuHMdVcqiNQiMHD3pgRWUzt7n3+F0dwmeXVnmZtgCxyo=GmFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QLTcni1/4CI/WtFmZlQx"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVcqiNQiMHD3pgRWUzt7n3+F0dwmeXVnmZtgCxyo=GmFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, stable <stable@vger.kernel.org>, linux-serial@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Finn Thain <fthain@telegraphics.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-serial@vger.kernel.org


--=-QLTcni1/4CI/WtFmZlQx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-12-24 at 15:39 +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 22, 2013 at 4:47 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > When booting a multi-platform m68k kernel on a non-Mac with "console=3D=
ttyS0"
> > on the kernel command line, it crashes with:
>=20
> Can we please get this in stable, too?
>=20
> commit dc1dc2f8a5dd863bf2e79f338fc3ae29e99c683a
[...]

I've queued this up for 3.2; sorry for the delay.

Ben.

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-QLTcni1/4CI/WtFmZlQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUzhKY+e/yOyVhhEJAQoCgQ//d0eD2jEhagQ3aCkR/zgGpuaFKr8abPwy
DnkrD2cXoFZ+ULvFK5mWlGsqR/rnwCjCfkZQ7W4MVUCb7zSOXZbPGTKbiwgmrrjr
7KOZxtQqRlBdg1bEan5ZDzz1K0koJ+/7fXJHbweGfWZP1vLOT8uAW3C4Ltl58jJJ
4iPceV6iKl35S+PLkCXwh+IPAV7Zv+KdQHkpE/U1ElGLvBI1RH1md1hzk4uBQ7me
BomNsZjMcH1eN0tH+dfhMXPhHBE1ylstMG8FHvrVgC69q7Y7/cfRRtSIxTWP3rwL
YjZvSiBy4skIEpB6MTqT1aYMtZY2vOuNrmnqhqabqWQJgKPRQRoszmLstCVniDob
ruGXZlDLZ0w9GUHTlaSb8JmxTsOM1X7VdykIkaJto3VO20aHcmHAuoMrIogmG8ha
fxO9XU21dAYLsvdAmkfu6SghUZngkke8YpTLPsxjIjqL+QGEgUMlRRY1Cz3/MrOv
J8sc375x/U/gDSn6jMmLMXktlE1LezNXh7bi0bsONUuGouMPiuEGiL48vcnBr1IY
uZCMW99vDY579UGbxBQHhs189xtAutx7zSB5g6nQUWVwfqKx3qobsqZelI/2fDHo
Fs2ssq/7Lp8QyUjdIohEgmC+RjFza/4mjYYmxecY7v8A/5od2NaEBSUPGrf6ak8s
tBvdUtaLxGk=
=wZdD
-----END PGP SIGNATURE-----

--=-QLTcni1/4CI/WtFmZlQx--
