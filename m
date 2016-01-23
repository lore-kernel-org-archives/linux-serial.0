From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sat, 23 Jan 2016 08:40:52 +0100
Message-ID: <20160123084052.0d35f892@kemnade.info>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<56992959.2020204@hurleysoftware.com>
	<CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
	<744620565.20160116103445@cogentembedded.com>
	<20160116233157.GA7774@rob-hp-laptop>
	<3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com>
	<20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
	<1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com>
	<20160117193849.69d00c28@lxorguk.ukuu.org.uk>
	<37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com>
	<20160118111926.0882b422@lxorguk.ukuu.org.uk>
	<07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com>
	<20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
	<C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com>
	<9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com>
	<20160120174610.1c64239a@lxorguk.ukuu.org.uk>
	<39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com>
	<CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com>
	<20160122201229.5df0bb2d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9NejAcAJmJ5hHYY452F=WSO"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160122201229.5df0bb2d-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Tomeu Vizoso <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

--Sig_/9NejAcAJmJ5hHYY452F=WSO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Jan 2016 20:12:29 +0000
One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:

> > I would have expected that the main (and IMO sufficient) reason why
> > the kernel should do it is because the particular bus used to connect
> > a BT chip to the CPU is a hw detail that a kernel that does its job
> > should keep to itself. Same as userspace not needing to care if a BT
> > chip is behind SDIO or USB, why does it have to tell the kernel behind
> > which UART a BT chip is sitting?
>=20
> Lots of reasons, some historic some not
>=20
> 1. Different BT chips have different interfaces, especially when it gets
> to stuff like firmware reprogramming
>=20
> 2. In many cases we don't know at the kernel level where there are BT
> uarts. It's improving with recent ACPI but for many systems it's simply
> not available to the OS
>=20
Same is true for i2c devices. The solution there is that you have various
methods for providing the information to the kernel, some=20
are autoprobed, some are via board files and you can also tell via sysfs
that there is one device.

> 3. The power management for a lot of BT (especially on device tree) is
> not actually expressed, so you need a slightly customised daemon for each
> device - that one is ugly but the serial and bt layers can't fix it.
>=20
That boils down to a circular it is not there because it is not there.
If we express the power management, it can be done in kernel.

> 4. Because you don't want to just automatically load and turn on
> bluetooth just because it is there - it burns power
>=20
Exactly the same is true for wifi and for many other devices for
which drivers are automatically handled in kernel, too.
Well, do you have a list of devices which do not burn power?
I would be highly interested in those.

Regards,
Andreas

--Sig_/9NejAcAJmJ5hHYY452F=WSO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoy6HAAoJEGGrpYhZ30HuetkH/jAM2ZZOuavdcuvZR98/bsp8
1sh8GIzgTut+UHAw6Nuh4rAUYyoVv/JOLGFCo9KPtDXjJG5wWeWx8lmSaEk2xBf/
MQpAwSxPtBPL/exL3Qnn0OsDwox1AU78OiyX5DNQ4gmT93LR6eN77yl57E+MqntW
H4bkBuKkd8EsICDUeuwUA8lCeXj3pWPATp4KZZ4fwx68HaCbrWCRqmHIUEf0w5M/
oykLiU0Yv+BRjSqkP6Up9oKO7O52FfxA6ZOEb2mY6Nb+Biry2GHaAtaUeQqsqdKL
hAYm4xOYgmn0DTVQn8WAutkRZ5DkDbgFDNEGBQEdCTvbjuLNtK3yh9+27S0C5ws=
=4AF9
-----END PGP SIGNATURE-----

--Sig_/9NejAcAJmJ5hHYY452F=WSO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
