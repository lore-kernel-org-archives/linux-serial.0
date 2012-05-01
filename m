From: NeilBrown <neilb@suse.de>
Subject: Re: Question:  How to power-manage UART-attached devices.
Date: Wed, 2 May 2012 09:15:16 +1000
Message-ID: <20120502091516.20d87fc8@notabene.brown>
References: <20120501082209.0b560708@notabene.brown>
	<20120430223322.GA3951@sirena.org.uk>
	<20120501093559.5c14087d@notabene.brown>
	<20120501163303.GA4089@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Z/qVR5Ol0lURzcSZffP9xmg"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120501163303.GA4089@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

--Sig_/Z/qVR5Ol0lURzcSZffP9xmg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 May 2012 17:33:03 +0100 Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> On Tue, May 01, 2012 at 09:35:59AM +1000, NeilBrown wrote:
> > On Mon, 30 Apr 2012 23:33:22 +0100 Mark Brown
> > > On Tue, May 01, 2012 at 08:22:09AM +1000, NeilBrown wrote:
>=20
> > > The userspace consumer was added for users like this that live entire=
ly
> > > in userspace.
>=20
> >  I assume you mean REGULATOR_VIRTUAL_CONSUMER (drivers/regulator/virtua=
l.c)?
>=20
> No, that's just for testing drivers in development.  I mean the
> userspace consumer which is hidden away in userspace-consumer.c.

Ahhh, of course.  What a cunning hiding place! :-)

However it doesn't suit my need - I want something more abstracted.

I can see there may well be a place for a simple on/off switch for some
components, but then I would prefer to see it as

   /sys/class/power-switch/$devicename/state

rather than

  /sys/devices/platform/reg-userspace-consumer.X/{name,state}


Thanks,
NeilBrown

--Sig_/Z/qVR5Ol0lURzcSZffP9xmg
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT6BuhDnsnt1WYoG5AQKlCA/+KRtmstwTK2E2uh7Nd/K8F+B9MI7fNylw
ySNjUqloOCUALZrYwS1SOb9fIVbw/fd0WGvY9xJnswVkZ4YwAUwaKzfNqfeLnANd
hm8YSQ3p72IzuxiyuhqCk9hdGcDYg52uEW6TtfsriyzlLMouGamQpFhmu/C2Vb7o
usD5IdIe9OMwuZtfZ/91wH2tRB7BA544/j0gz6fChe6BzwBuFFYxHRlV9BwEE//K
6TSSabwdrv3PzCh5IBcUELIyha+uor2ct5bhwcmYd6I4XoFVfP1JGLT6mXFg3ncU
eZ/Ebf5Ey7yiWdHcTzFWmm513daMehKLRDfN/iWQ0IWCAUFuwZ6e6HO4P5uJnNI7
pFmDq+J0fTO4s1vfx7PIWZu+FwBcuqpICfj7ZHJ65yOJwMR3KodK2JQMWz/qoc+z
WADc8hHK84oKB4rl3zNbeIz8rWmrom618vTnuEZyrXHWEuMr1QG5xWEHInL/7nm/
hZTIc2SO3WetCEnFxlCZO6Ii66JHBuOKdzXuFLKUu0IE1G5/tBMCGNJFmU0TcSrj
zCEQWVykuq0jWjWKgmAWijY4BhOQcvx9kXZh3igkZ0WBrhvZS2O3BejiX0ORj+Sp
LrrmG2auSKhIAVxAuhUKKPR6a2waMh4YYDM3Efy58R5JTsGcL5hgWMIwecXYZv8+
x4Gf4ThVgaU=
=qyQD
-----END PGP SIGNATURE-----

--Sig_/Z/qVR5Ol0lURzcSZffP9xmg--
