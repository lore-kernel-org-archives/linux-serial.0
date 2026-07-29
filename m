Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DD483BC1
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331873; cv=none; b=h6gpMlTWJiPMNLJ3wJwUGB5Ckmr+OnN3XAvJ4BmZ2KrJinLguc6Bgv5L9JlVBdAaJGKI2TQn6tQefn5BCW/mIoo5DUMrrvMHPw7E1P6zLm9Do441W0qAS9CsgLDlh4UFJxkbWLXXG7ytpd6Uq6ZVwflnDQXJ+hDZCnlRajwGMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331873; c=relaxed/simple;
	bh=pkFJH/dn4xaflkIENR5YNPdS8y+SzR+cEsG23WmKJz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX/j1OqadKdWRc0Z4vD4Crzkhzmscsw0Ur0L8sE2G5EUtamCNK+rllJpDZZDUzFmccGPRyT757Si4qC9tYjSiSN2keNZgSD3v386jubjrxg+AgODu9M/cm7RFaH7tDbBbrYR6izGnLEbob2tpqHUZD9JAay/sgWYoaKdJ30D4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CJGUHLvy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CJGUHLvy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49557167508so8324895e9.1
        for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785331863; x=1785936663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35t/NONAr0KkEmZcHsoIv55IUOjqRucdQqH0BEfREAQ=;
        b=CJGUHLvyezhkepw+aU1WxSTBs7OyJPRrblIwG7sa4jygaZtKEhv/D7Kr28N+enay8I
         7q838zAiiV9NuD6PrRgLJ+GKSC2f4y8PQH8y4uBFQUekv1f1G0GLkdG3YHYX0YwhLSNh
         BVSKBOpYb2ge9kkcVrELWJg6RnIUdOBKqb/1zomK3HaghrwDR/dLQI7M4vhmu1Zu1kjB
         r9FQ8O714qiHw5wSveOgU6CzfJ03395KTWlk2ci7NykaeAxDoljgBXWSFWveOuDl4K5h
         mbbj57/fJeUbKabKmxxn/WusPBj1h1BVKR7zUiMRpb1MclpnutAy/ttryWv4HwEQaowl
         8BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331863; x=1785936663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35t/NONAr0KkEmZcHsoIv55IUOjqRucdQqH0BEfREAQ=;
        b=XwHIFdUlRV1h9f5qnoKjHDiOFqbw7c+xZyld3LutbuW5yqBT+P91gn++/nd9ewOBNu
         FFJNBHZ/+3aRAdaijD/jYHrZG34pScuX6IPvI2vYbxN16bisqKO55DlplGK/FLMpNfjn
         K4pB36qm2S/qW1IOobJZKyNvvMwcZ2nEv93cT3gz2dufcGCjGJVxz+wM5PvayID1V6y0
         1Dufx94YSZTSHKcKWVTGEAJzMflEhn2HeqnZKRcKXjF/M6QtGVX4Z04T3hZbT+FgvEQ8
         H7M41Fev66nW8hUtZEPZS8J/s/n4GKaS3hcdv7ozN07qzvrQkiZB6AKZBYyjIrL/PgPG
         j1ew==
X-Forwarded-Encrypted: i=1; AHgh+Rocc4OK2b32nJL6u5uYWnt6q1d+XII+IxwQR/2+CY66YP7ceQBKhSRcEzelorelo6gq+UTdd3Rm44uLYS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhVphHV8FZhCpEWXeoar5Sd9zVlSMh3oRpq62y2sZL4MO5RUz
	j+M9X7Fk3F1oBLsd13cAhH13+dSokrGR4mupIGG6kkdLYjixlX49f1x1HK+/4OyPtRUUrPwpdem
	40n6P
X-Gm-Gg: AR+sD12OM8QvxdYjyuwYroNMxq+5ij+MP37oj82PhbU4V09GjV1t8njwSFWs2SUvX+x
	yMJTAssS5U3/KIxs0mvx77hwO+wK428flB3+n1jUQN2xXMRQBrtTriUvF2k8zeSlochewc2fw/K
	vqm0NgUts/ccrxs4qfXZBQeofyF43DFtjfI1/qL7kyctq+OeyynWAU2ChmwHChFSewt/togoZfZ
	1ZdAT7oVObWrKlPFYWYrEh00iTxVL8ZGiS83snRKfjKjL2aFThRzfts4eEQ/zz2oB8dWYYBfEZH
	kWsi0/OZmEQcC7AsPTsOmOguy1X+T1yRl7RxpIaHOn/Elcajwe2/5jiFFWr0nkUIMfGEhtPzsIW
	N8ZPuReLuUQ6YGOkbbxcPxi15TWrazhTgD4IcLM1Rxz8MxYrfsRUeV79GZ+6Yx+aeQ7XNRh06sB
	gWkb4pG/muPvoLRI4JGY23lPQFhN4twrKAPPRekCoA+Elb/bYHKw56FN8PtZbwIewEMIsg/OnmQ
	Fa0sEji6Y2bRmPhr32mZ4L8ytkbCH79ifq9IUDpWjNG9xKkEpc=
X-Received: by 2002:a05:600c:3153:b0:495:573e:1c54 with SMTP id 5b1f17b1804b1-496c6428a29mr83965355e9.9.1785331862901;
        Wed, 29 Jul 2026 06:31:02 -0700 (PDT)
Received: from localhost (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-496e8e06f7csm66113765e9.0.2026.07.29.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:30:59 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:30:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <amn8Hb2dbv_Sah_Y@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
 <al34uIyOue73MMN0@monoceros>
 <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
 <al6PfMCuRiYcOBQV@monoceros>
 <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
 <amGYgUhPrSdR5srV@monoceros>
 <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
 <amMZoJ41FKcd2ddG@monoceros>
 <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
 <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o5ev2q2w2ysdqx3h"
Content-Disposition: inline
In-Reply-To: <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>


--o5ev2q2w2ysdqx3h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

Hello Hugo,

On Mon, Jul 27, 2026 at 11:26:43AM -0400, Hugo Villeneuve wrote:
> On Mon, 27 Jul 2026 11:22:10 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
>=20
> > Hi Uwe,
> >=20
> > On Fri, 24 Jul 2026 09:58:13 +0200
> > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> >=20
> > > On Thu, Jul 23, 2026 at 11:13:59PM -0400, Hugo Villeneuve wrote:
> > > > > For me the open question remains if the driver works in the
> > > > > configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=
=3Dy) +
> > > > > CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
> > > > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> > > > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hug=
o@hugovil.com/
> > > > > introduces a logical change in uart_match_port() that isn't expla=
ined in
> > > > > the commit log.
> > > >=20
> > > > Not sure what you mean by that logical change?
> > >=20
> > > With said configuration and before
> > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f uart_match_port() returned
> > >=20
> > > 	port1->iobase =3D=3D port2->iobase && port1->hub6 =3D=3D port2->hub6
> > >=20
> > > and with 3d406299d8829747fe2e8692f4c29fe3dc1d101f (and your fix on to=
p)
> > > it returns false (because when drivers/tty/serial/serial_core.c is
> > > compiled IS_REACHABLE(CONFIG_SERIAL_8250_HUB6) evaluates to false).
> >=20
> > this change was certainly not intended, sorry about that. Looks like
> > there are still subtle Kconfig-isms (and 8250-isms) that I still need to
> > master...
> >=20
> > So to be sure i understand this correctly:
> > I will submit a patch to replace IS_REACHABLE with IS_ENABLED, which
> > means that the configuration CONFIG_SERIAL_8250=3Dy and
> > CONFIG_SERIAL_8250_HUB6=3Dm is not supported, as you stated that
> > it currently cannot happen?

No, that can happen. e.g. ARCH=3Dparisc allmodconfig has something similar
(and this is how I stumbled over the breakage of
3d406299d8829747fe2e8692f4c29fe3dc1d101f).

[similar =3D SERIAL_CORE=3Dy + SERIAL_8250_HUB6=3Dm]

> Or we leave it as is, since this combination is not really valid?

Not sure what you're saying here. You want to keep the IS_REACHABLE and
so be able to compile CONFIG_SERIAL_8250=3Dy + CONFIG_SERIAL_8250_HUB6=3Dm
but have that broken at runtime? What does make CONFIG_SERIAL_8250=3Dy +
CONFIG_SERIAL_8250_HUB6=3Dm "not really valid"? Or do you mean something
else?

I think the real fix would be to just copy uart_match_port() into the
two drivers that actually use it (and remove the then dead code paths).
Then it would be drivers/tty/serial/8250/8250_core.c using
hub6_match_port() only and that can be handled by a proper dependency.

Best regards
Uwe

--o5ev2q2w2ysdqx3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpqAI8ACgkQj4D7WH0S
/k4nCgf/R688pmPPgA42egeiaYdfJAOziwAQrC3AuEU0j60XHHdHUtiyCOXtLaXg
IPBEjdgTieouEMMG44+aayNTU5Uz3rv8bhkJhmolwzUrGGYK+FDeDVVlu5RaXKih
7Kyg+cjUlgwcrRSCwG+hTsAZdiU2kAcgRvn008xwLD9rmRjlu2tXT7o591I2p7Je
cbi40oCekeqQ9DE0DlBiXmUMgvefZviPCM3CQqvmZHIgDvD+ve0HRh7keTtpjT0R
VYkGtgs2hYK4cndpZhfOawBAbwU/zri6rY5dL3UCj+7cEDUCt3/Nvx1FJrGZ6FTm
eLTFqc6MoiZXm/C1LSVBMVukdYoC2A==
=CPWt
-----END PGP SIGNATURE-----

--o5ev2q2w2ysdqx3h--
