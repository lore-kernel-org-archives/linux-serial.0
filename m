Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77D3B14D2
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879901; cv=none; b=nuYxdS0HKN3+h/WdquZ9Ipw2y7b7FtfA59DH2hzdNmf8Qrtsg6RTFQf9Hz9/AThGMlh7vLuFOvR1HEyN2hGseuYdNFcYtozXgcCrqLKzCxHGhs26FpP22+U/nqzW4yxxVEZMg/oNV6TBWf4ZvjfNTLkoTVZtcmeurCGiGMhmAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879901; c=relaxed/simple;
	bh=bogGGtQaoIfpptMv/5EHfOl6de0VSi5cFRCgLBKsi94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul9sWns7F8DSW0eC/d6aTOwsEvHTsRuqjOUkQD24fP6wb5OB15N/9pPaDEHKRcFvE+js/MJ0ja3/wUWVSy359V4cPgpur5pZAyRY2e8nF+k5wBYWhyiyLijo5o19TE4r2tA9ZDCtyT0fI0UtZV2Ip8b4K/jOrMbQpY2ZQ+nYLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=c9dn0+QA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="c9dn0+QA"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-471eeac43bfso144826f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784879897; x=1785484697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcW7bFGtTMZkLrtmmnJtMoZJkBsJXN3gnYt3y6BzEk0=;
        b=c9dn0+QASAn1c8Cg1L+nucUvacCwgGA3jI9sPF+I1klj93QcDDMobjwGs4Z7DVgsSO
         wdwAoA3MweiXT3fT4ABBjpiiTBnArTxV60QYJbj9VUkEULdrEwgux2kmqT0+v2fGP9Fj
         pzGMeFcV+tuqYqxg6u9oeMe+h5/BNwcFvcaXLs8MXGygiRQ+c+UJD8GVzqW3CnkJV7Jr
         nJtBDMzDlfNCwP6qeFNuyh3iiBTGRVbrRWStCCRSPZzk0ePjibdNtGa5uZDGVRItgyk7
         g+tHmGivz0eq6SaFvXPjdy4HygBl1pJ4LvSz8SaBXLR7MpdEIQCg+7oiQT4wxIp7scv1
         X5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879897; x=1785484697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcW7bFGtTMZkLrtmmnJtMoZJkBsJXN3gnYt3y6BzEk0=;
        b=ni27rCvqvYv0LYhJXeV837BoG2vPH70ojUYLRZtuu94eD3pQWz77I08QM3e3pXMmhB
         +l9TcZgZUcOXTRZrbui5ElOZ/KQGOxF1v0mRUBDI1OS2qNtA3rDc3iAHX1P6GpAKBVbj
         sGwIcH9tSHnkEVtf9ZuIg9PEwy8Y4yaqvA9mfonIOEer317TQpnN5Rx/PoNoVPJQEjjG
         XCO5mC4pbW29DDAMHjOaSgeY6LT8I9ag7VZznHplNaluhPODEQOPG3ql4TMJBZqTdWCD
         Vq2VpVr6JGrUmlZ8c//iHQR7E7v+DKEWV0NYTGpne44TaphmzhpmTnUicrjGQlRv4Ygt
         Do2A==
X-Forwarded-Encrypted: i=1; AHgh+RqnoS/ez0D+vHhLvWpqA7GICFI7OE9YjXYi0Nn8ovPkH8tF9JvZq21jRDaF9wmEqZWncA5OiPyJ8sNbcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWI67KRh1fyfogzOkoZHeoZTagzX3yWuNzWn3WuurnEPZqreXT
	n4vOmFvlffXrmxROH5gP8vEsE2JEtbsRzgsaDtTGsZCsoljsW0ZOaX5n47DUVwA82fQ=
X-Gm-Gg: AR+sD12CdUJ9hbybQDXJyKJ3sn06Ltz0OZGboawcPfpVdCzsQeBuQ0Tmai3NkTaGw7L
	wAWvAUx0nNm4sXLgN/PLsduAJr1mUg3HhL1Jn9HiTodHwjDH3zQOnT85e7vv7H/Ug0PYncwlpRi
	pl7rvgIc3jOjsavAbkeJY1J+vznTjD9uGpK+MVh40nqaYRPbI6Dic9Mh8tkBgRvLGOYFcuyd31a
	6Sm8ocGLVGGcedCs42Z9jfeVf6d5F8ynG37I+RlGvZVNH7n4DMntyFZAzBSBcluEpyI8P0alSJw
	mZ1GjAtq8p5rMtHicd3J8rVCg07JOKYZGUpjNZ3dVH6a+7WNJ8RKqSrv4/EOsaev215ZDZPbNaj
	5fbU1nNtNSVFvi1XbFlKko5UFFE2CFLhmIls8qpe0a2uMGI+8U72g35awPkNG7k+a7LWSJj8PtO
	o/Os1GbBjogPPweNSehA==
X-Received: by 2002:a05:6000:46d4:b0:47f:93b9:b76c with SMTP id ffacd0b85a97d-47f93b9b770mr3298489f8f.56.1784879896803;
        Fri, 24 Jul 2026 00:58:16 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c52fc0sm21909641f8f.23.2026.07.24.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:58:15 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:58:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <amMZoJ41FKcd2ddG@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
 <al34uIyOue73MMN0@monoceros>
 <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
 <al6PfMCuRiYcOBQV@monoceros>
 <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
 <amGYgUhPrSdR5srV@monoceros>
 <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufnmj4vyuobnzfpc"
Content-Disposition: inline
In-Reply-To: <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>


--ufnmj4vyuobnzfpc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

On Thu, Jul 23, 2026 at 11:13:59PM -0400, Hugo Villeneuve wrote:
> > For me the open question remains if the driver works in the
> > configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=3Dy) +
> > CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
> > 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugo=
vil.com/
> > introduces a logical change in uart_match_port() that isn't explained in
> > the commit log.
>=20
> Not sure what you mean by that logical change?

With said configuration and before
3d406299d8829747fe2e8692f4c29fe3dc1d101f uart_match_port() returned

	port1->iobase =3D=3D port2->iobase && port1->hub6 =3D=3D port2->hub6

and with 3d406299d8829747fe2e8692f4c29fe3dc1d101f (and your fix on top)
it returns false (because when drivers/tty/serial/serial_core.c is
compiled IS_REACHABLE(CONFIG_SERIAL_8250_HUB6) evaluates to false).

Best regards
Uwe

--ufnmj4vyuobnzfpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpjGxMACgkQj4D7WH0S
/k6pyggAmd1KCtnMBdIxWMNBg1jDsLHqgkhcGyMi0G9P8cEgODx4GEK0T/LaS0YN
stJUZ7lhJ9PABB5L7DhKmZu+DrpOS6Fg1LHWO0LamkLr/5DwJb2rZt1sfCxugX/y
sn15gau6oym4zexW5JhBwUREXh/ByETbo0WIa+WVoom9jPyP5YJ2jRyiMyoDi0HQ
1hzmvxEUzmktKdN4LPTvZv3AhsKhozt2pd48lKexcDAJ2ftv6EinumgbNkQRKdbb
M5Pcb/ItySsO+RsK2eeOG56fI3ygHmIVip34Gt6Sa4E1/t4kKOmJpbrRuROPwc3f
VohXuUGdiiDImUdq7H8TJZkiWRdugg==
=fnpQ
-----END PGP SIGNATURE-----

--ufnmj4vyuobnzfpc--
