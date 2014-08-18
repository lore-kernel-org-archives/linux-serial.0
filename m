From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
Date: Mon, 18 Aug 2014 21:11:03 +0200
Message-ID: <20140818191103.GI15297@lukather>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-5-git-send-email-carlo@caione.org>
 <20140817142115.GB15297@lukather>
 <20140818132713.GA28819@carlo-MacBookPro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yxL3IctpgIvrN+d"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55064 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751705AbaHRTPE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 15:15:04 -0400
Content-Disposition: inline
In-Reply-To: <20140818132713.GA28819@carlo-MacBookPro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com


--6yxL3IctpgIvrN+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2014 at 03:27:13PM +0200, Carlo Caione wrote:
> On Sun, Aug 17, 2014 at 04:21:15PM +0200, Maxime Ripard wrote:
> > Hi Carlo,
>=20
> Hi Maxime,
> thank you for reviewing also these patches, I'll keep you in CC for the
> next revisions if you are interested.

Yep, sure.

> > > +static const char * const m6_common_board_compat[] =3D {
> > > +	"amlogic,8726_mx",
> > > +	"amlogic,8726_mxs",
> > > +	"amlogic,8726_mxl",
> > > +	"amlogic,meson6",
> >=20
> > Why are all those compatibles needed? Usually, you add a single one
> > per SoC (which would be the last in your case I guess.
>=20
> They are taken from the weird DTS in the original Amlogic sources but I
> guess you are right. I am actually more inclined to just leave "8726_mx"
> and "meson6" since online you can find equally both the versions for
> exactly the same SoCs.

I don't really know what's the best option here, but you should really
choose one name and stick to it. Since the mach directory is called
meson, I guess meson6 would make more sense, but it's your call.

> > > +	NULL,
> > > +};
> > > +
> > > +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> > > +	.init_machine	=3D meson_init_machine_devicetree,
> >=20
> > And since you don't need the init machine, you can just use the
> > generic machine support. I'm not sure what's been decided on this,
> > should we remove such empty machines?
>=20
> I can get rid of the .init_machine but what about the .dt_compat field?

Technically, it would work. The only drawbacks are that you don't get
the machine name in /proc/cpuinfo, and that you'll probably have to
add this file at some point in the future anyway.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--6yxL3IctpgIvrN+d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8k/HAAoJEBx+YmzsjxAgB1IP/RUJNxF4+i2pNFrh4MQNIpwe
6jLJroMh1BtWntqJsZ5HHn+osBLDJwLWEjC+5sM6tTU0JntFjVOCD9AduhE8hgIg
LxSZPWN0xPZK2c4DR1MZKzkfki8oYIOadSfIswjHsHQb82cIaUYeGmznyp5tGfS8
llQX2Hy43Z+KsIgBcYTcssTTWJbYbijAQI0c+utKKA2FkmrZvL9i7Cb6EH3QtJeK
CiLSmOYxGomg8krnW/XtNLGWgLBtAYGSZFHEpiwooKD+r8prT4rvGhoSKheIoYGF
pH9lHaQykCPnGT+sF93aWbsm8HS0U8OthloWUse/WGyIUnoVxpJozdL+BAKWqMJa
ts2tJ/bKNnvGezjvMu5+yurRZQDFLL4pGZvGuV37fYs9Uoy8oXfHIqP1gtSQTDgx
ydU54zPUCoeo/6aycJYyTbxz2Ew4LTKXIVOD/YFb4skX+6qVbD9FfOXGHDbSWXlY
+38aodUtO3Hjt+WkIBlTwAFAEr1JcfiDmKfrA6NfzDhoJ+Z4FL7IMp87gumjrj3I
b6MSfEWOAn2s8LegwmRoZFdgGPD1ays+igMkvuo+5W4yRKlF0qAzeTd1tkQaId7+
9DwqmWrnkOQcnh6Q8FRM2c4cR1GUqBMziXBUIligKV+jXlLwcSKf1M/bs1AtuKg2
x9QHL+to6S3DEZrseWx6
=ut7G
-----END PGP SIGNATURE-----

--6yxL3IctpgIvrN+d--
