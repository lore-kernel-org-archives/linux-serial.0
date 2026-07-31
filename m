Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D573EE1C5
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504054; cv=none; b=dI/tKVElB191h80EGuB80G1jiGgbK5A0rAj2ALR6QqQv1YAOCe8sL4xodPV7pj4xlrf9UVonbRUBnLurAP8bMG8In8a3qyrQFVe+sdwJFo/sHI2j3YUndGsUqPCF4mvkOyqgfSQNHFnsoDUdR/PtqujaV3Rf4vReNeMlwni+1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504054; c=relaxed/simple;
	bh=mTHH2uXaTFHG0lmJ8V9E8KrT19j61IIWLZLNED33QyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BccF2tXSBXL3zfkEKrvZHdowKpPNfUraH9kAReIBETsaVOPpl0ODwAsWFrMsSXiu/gGofh+7ABQtskjh8Qn55S7bvGYLjSAsn2ZNEaOuMrRMG+sMUnrLw35vop4Sja/LvdXMayLqTRjKpmRtsIgy4QtaB53Na3tmQg4xP5AodU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A+HPpXZ6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A+HPpXZ6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso317275f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785504050; x=1786108850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mTHH2uXaTFHG0lmJ8V9E8KrT19j61IIWLZLNED33QyQ=;
        b=A+HPpXZ6vlIAvMx1IcAWCLMLDBPbx5kw44D+mu6jyou5CRk89Zm/QKkk4KCqnb91vG
         C3hk8NEw4bZIrdGFfuQBkopbc5YlPBycjkEFXLB0zYh2tlrECnQpPsrSAd33jRN8lBFa
         XifGgCEMpnQPYO5t2cTR71mX1C3X9RvW2Rao3l5zl1/9wPC4iIOpqLHCMGAnNaMK6u1x
         mMn0UUP9i5mFtMmue0aC8chuoGEnobclIN6jie1JrxiamPmzJJE7iGLOyr0GrS/g8Zzq
         n8GXNxrAUkg1o1SCVOX+OfN82RGZdd0CrwvOMGM4U857E3zgyPG16vmTyYVNHrjiQuql
         KUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504050; x=1786108850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTHH2uXaTFHG0lmJ8V9E8KrT19j61IIWLZLNED33QyQ=;
        b=iA0ooukIFqq/xFzrs+KJ0cFNlZiT4awWBjUpt2fNqoGlIyQlnjSSdp0GvxGCEHWjI/
         g47H1XqFeRqqLnZTNIEzmmBeAAt0DGciJzu/kCslNtumRvuchbwwdsCifKnPI78Tff0z
         uC1PaHYqJ1m4oY4YFnzEie/357/53+9ERZd8chE3jF6Loya07ViLQUxlyBlWCWnorIE7
         rUc+nXLdU7Ly0Fedv1nWraFhmOV96NjUhyF8HAjmyPemdsmw5NBctewWpZIGRMb0NY1Y
         cX7LA1jj46dz26kh/x+vzpWD4rhVMr5SDXi3uoTDqii+RNSLRR8yCrgJ1amzp02sv/sv
         9fMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVN01q189NwCNdscnxb3CNr9YwI2AClv3GC6UuBVH2AK2l8sNCWkF6k2bbCOqNqmbQzlVFL2N5y9cE7HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/a2/p8bFDPL4D6aOFLMENNYa+LYi/D2sKwt14PtWQKXw3kiH
	U5uuecLoqpaA6/+c9pRn9MjteAi+dazigd0XGqwikYqbTlkI7FCHN5zdq/e2yiYom4U=
X-Gm-Gg: AR+sD13pql1escqABB9MRHY/eczR8dCwmdtp9BSzarrJXpzBtFvOtqFypboK43xhggf
	8yAtYzSFpgdSQumGfB1IvDL9GM9we3CA8LzxvPLWJAsGHXSU6WoGxf8GdhFdS5XQNgiLfoGvslR
	v3fL1dvWtrRQIp+Mz3sgiTNTuYvFSW3hFHYiXKsc67uhXKcRtzdfS73AsSMZjlEMb4ep6iYL+0o
	gwbzq7UXKfAT2srEwf7nPoNDGDs1wgQw48SzLddLqag8t6qWBz2+lJJzJ/9XQ7hajLe5kI4zMOl
	qHSApPLDD32k+fsVLyQF8f/K5/jVS5/Y5lEnzx9N0ngEj+cAZKlV6NP07jdO2LotOifmIiLTpns
	zgQNUGhhNIBpEdW9kkp3lOUGhwpx9iCu4sTUvyMfI24OYPKL5/GV44aa2VIEukqPaO9C0/DusPM
	lkIemNQyNbABGLgvfGgqlRaNGY0ANax1/znjulm18hHXHz9H8wSpD0fcGa18K8LWT92YWvKTt+T
	QBI8NJnehhVk00TFquCkfn9gq8=
X-Received: by 2002:a05:6000:471e:b0:47f:77a8:7e20 with SMTP id ffacd0b85a97d-47fd2b41d0bmr4640886f8f.35.1785504049959;
        Fri, 31 Jul 2026 06:20:49 -0700 (PDT)
Received: from localhost (p5dc68b01.dip0.t-ipconnect.de. [93.198.139.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd41e2abbsm4741063f8f.9.2026.07.31.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:20:48 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:20:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <amyg0sR7SafpFuKR@monoceros>
References: <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
 <amGYgUhPrSdR5srV@monoceros>
 <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
 <amMZoJ41FKcd2ddG@monoceros>
 <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
 <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
 <amn8Hb2dbv_Sah_Y@monoceros>
 <2026073028-anointer-unlinked-c0ea@gregkh>
 <amusQjI0DOPzL4jM@monoceros>
 <20260730161516.3def31f58d3c1d6f8eb3f4a0@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pot5h2ofhsberfqg"
Content-Disposition: inline
In-Reply-To: <20260730161516.3def31f58d3c1d6f8eb3f4a0@hugovil.com>


--pot5h2ofhsberfqg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

Heyho,

On Thu, Jul 30, 2026 at 04:15:16PM -0400, Hugo Villeneuve wrote:
> On Thu, 30 Jul 2026 21:57:01 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > On Thu, Jul 30, 2026 at 04:49:45PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 29, 2026 at 03:30:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > I think the real fix would be to just copy uart_match_port() into t=
he
> > > > two drivers that actually use it (and remove the then dead code pat=
hs).
> > > > Then it would be drivers/tty/serial/8250/8250_core.c using
> > > > hub6_match_port() only and that can be handled by a proper dependen=
cy.
> > >=20
> > > I'm totally confused, so I'll drop this patch from my review queue and
> > > wait for you all to figure it out :)
> >=20
> > Does my suggestion make sense for you? Do you intend to work on this to
> > unconfuse Greg?
>=20
> I am not sure to fully understand what you suggest. Copying the same
> function code to two drivers seems like a waisted opportunity for code
> reuse?

FTR, I prepared a patch for what I had in mind, see
https://lore.kernel.org/linux-serial/cover.1785489518.git.ukleinek@kernel.o=
rg/

Best regards
Uwe

--pot5h2ofhsberfqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpsoSQACgkQj4D7WH0S
/k407gf+ONnXFwVuQ95sUG2tDsai/JGUVNwnMXFXs4ev8Jjovw2/XOwcIVWSt1R0
POtFXZGCjSH96US+cUS5zJlTdGg8tzbjvklS3NG+wuwATh3xo9gIi5lBMxcFhyGm
noY7zxaNV7N+Q2NJOasYTICeJZKqCVl9P2GkD3uRQuU8TYlFmihBWjNjM0P2sVNH
0tr1o+ha8lVkSeHbVzKZY937FemhJeHD1h4bgGbgPrn8o7zYPoGbi2s5by1EcUJj
dJ3+nrcrzX/oKi7Q1TGyWpS2AqDgAgF0wiqlzAWKRKUHKqKiZocNBNSYInZ+tjtO
R4UlJ+3btkGxezOHlsJ42jw/AvfVrw==
=nrzM
-----END PGP SIGNATURE-----

--pot5h2ofhsberfqg--
