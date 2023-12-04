Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83973171D9
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlnmlK8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78D1C433C7;
	Mon,  4 Dec 2023 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701710370;
	bh=piGSs7julioqnQBr/YqINs6yEzw8UVwQTU1V8jB7+ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlnmlK8QXwx4pGkRklXWR62xKFJg1B3GRuUALc6WCzRJZfcq/+XaZbPDT5Cca41Kg
	 2Y7NO1DsF0F28+WgUwxjv5fSF4j23IvstkrLHkfssbR/d8v/GR7JvJOg7ygNYtNKae
	 DzdCRGz8Y9YyzTaDyIKaolnwqPOhklnxfZMph17KOaEXW9khP60Xj55pLW/2hWpIkU
	 EkNCHl88N1UeIOf2lIHVUhJNWFbRIAIpYlifzeDzTbXUjmJft0UCvo1OpOFH6+PFT1
	 kuEdb/M6VGj/Z80g7/I6DjIDck/EDJh+zsfxUkb40mRmtfXpYG3T5MtqAbUA/3nH1c
	 6NB9Jp7TY2hzQ==
Date: Mon, 4 Dec 2023 17:19:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
 <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
 <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
 <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
 <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
 <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wl9IAOT+dlowaaOQ"
Content-Disposition: inline
In-Reply-To: <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
X-Cookie: For office use only.


--Wl9IAOT+dlowaaOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 12:01:51PM -0500, Hugo Villeneuve wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > I don't understand what you mean here - you say that the addresses both
> > have addresses 0x1 and 0x81 but map to address 0x1.  What does the 0x81
> > refer to?  The comments in the driver seemed to indicate that there was
> > a single address which mapped to multiple underlying registers...

> I was referring to an example in da9063-i2c.c where they have
> these two registers:

> #define	DA9063_REG_STATUS_A		0x01
> #define	DA9063_REG_SEQ			0x81

> To access one or the other, you must select page 0 or 1 in page config
> selection register at address 0x00. It makes sense to me for this case.

That appears to be a bit confused in that they've mapped the window
through which you view the paged registers on top of the physical
register map - I suppose that will work but more through luck than
design.  The window is the physical address range through which the
actual registers can be accessed, the range is the virtual register
numbers through which users access the regmap.  It'll make things
clearer if they don't overlap.

> But for the sc16is7xx, for example you have these two
> independent registers, sharing the exact same address:

> #define SC16IS7XX_IIR_REG		(0x02) /* Interrupt Identification */
> #define SC16IS7XX_FCR_REG		(0x02) /* FIFO control */

> I am not sure if regmap range can be used with this configuration.
> Assuming regmap range would be properly setup, when we call
> regmap_read(regmap, SC16IS7XX_IIR_REG, &val), how does regmap would
> know that we want to access SC16IS7XX_IIR_REG and not SC16IS7XX_FCR_REG?

This is the exact situation this feature is supposed to handle, your
window is address 2 and then you should pick some random non-physical
numbers to map the two registers to for access by users.  The core will
then do appropriate physical accesses transparently to manage the
window.  The whole point here is to assign new, virtual addresses to the
two registers you're trying to access.

> > Searching for struct regmap_range_cfg should show a lot of users in
> > mainline.

> Yes, I am trying to find a good example but I must download and read the
> datasheet for each one. If you could point to an IC/driver that uses
> regmap_range similar to IC sc16is7xx, it would really help.

Essentially all of them should be fine. =20

--Wl9IAOT+dlowaaOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVuCh0ACgkQJNaLcl1U
h9DRjgf9Hh3YIqpPEccxP8qX7luoZ0Vnp8uh5H0fP++gtgRwfacZp/MU5uqheehn
BtMabDTouwS6+uwC0ROD7854XyFJNolqT7cMCozH/QUT1m2BSanlPHHzCjAD1/xG
CSWnDKvh17/cReyxDaXNggmAN+hHxBX2kwo+qjpdbdYJiaDURBDurWYx9Z7cN5su
EuiA+91ROz6wsHLEElsEMFlh7cUchMKUwhzP9Vv00l+zig0Xfwv8t4KSbs//Co6t
/eUD0973d6l036TVZT4GBZj475qPSR4Q7YjQDv+MHL4Cr0giAY9gQ6IRIR5rY/yu
dAdqEGwZq7g+xRXCrBbdz+3Es7D/Hw==
=mSsM
-----END PGP SIGNATURE-----

--Wl9IAOT+dlowaaOQ--
