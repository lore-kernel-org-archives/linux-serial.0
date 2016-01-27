From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
Date: Wed, 27 Jan 2016 12:47:28 +0000
Message-ID: <20160127124728.GM6042@sirena.org.uk>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453663322-14474-4-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> The source and destination masters are reflecting buses or their layers to
> where the different devices can be connected. The patch changes the master
> names to reflect which one is related to which independently on the trans=
fer
> direction.

Acked-by: Mark Brown <broonie@kernel.org>

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqLxfAAoJECTWi3JdVIfQfrUH/0xxvyT4TCQ1uidDSVHY61/o
UnFfWQxuPn45knqyPT9RxxZlUSBtXyp9FCvgDT4CnXmZOxa808JC9r8PGgu7G5wV
Qej5oJaJOtK7TVaxJHkfvo7sn/D3sjwrr9oEV75oqAWW7ZQA4uav4V/Vk0c8IWKu
Gdih9px5/e5ES2mTexPBDuH6OxqqoyRY883lPuE8hsNnxPV7Bhw2Vq5jASrwzRkn
PZRrpodGf93bvME+Ng3DKwYujpSF+To5bMxDS7MoQ+9rDBtQY0h0ELq/axTQB8G2
otMkKf2AW8WxqjnLFC/SUQ7AsPsdBy8c+bFnWQS1hRkdY1uYnncU7CclDkpw3UA=
=IEOK
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
