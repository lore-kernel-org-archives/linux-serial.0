Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D7388E69
	for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781464; cv=none; b=UU4IOWWvadWOE09kKHAPRMlk5aQ7pbyG8ocoYTAhGRwDATpdCwImeS9JA13vFnZvRjZuuKMDRA9W0vzlcIGgFit360ghb4+sNilE1ppElyHuR6HVEpNZ1SYGe0agRjRY++yAwyGtk8ctstclqPYTbGSBNosv7CXhctp5qKa+VDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781464; c=relaxed/simple;
	bh=rmV5wa7WGkm++YNPCVM45vZ5iI212ame9uuK6dMNzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haQvJOlRnFXHDKfwp1oKE6rwLiEsl/z6AjAkMuN4lsis0dlvWgRrPTZybJyoaRP1chvQECXt+3/z45WlItV6XgW+yuumkT2gW0iEtqpXVNhANd8+pNkWIkdDiySUHyPJBkTZ73RFzSXMTERmE4029BOPlW/5FaPpvTW2NxnEPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LC941cVH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LC941cVH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso59547f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784781442; x=1785386242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8AAHY7PT81febIFH3+wz3Qo4cag6VwKMhyYqM/7URpc=;
        b=LC941cVHUNrxLLYV7oIU1Nig/ugDglqU13tnzWIuwzQuMP2893BGJVugPNbULLrYmg
         lgB9hjTPgaJryogRBKxn502CbEJ4gFx9pWjFUdIcHlqAOa+9+LVFP6s7Yz6qrEPugtYd
         oZ3tizeHUveh/X0WL3B4QBDu9st46aEwWWpoviM2UHgiHnjSrqPkjk7dDmduoXvKgXh9
         YH2UqYOuJRxGsKqYPBBihvWncieKn5u/Ag05zvOXcYuxH8QOq+4MWGJi6F6hf2AMZgFy
         gxgWMVujXwXlnrav1Yo+QheA2c4nUZ6AwUNBcX/iPfIxZy1u4vMPcaxWt1fFIHCKzEB+
         Xhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781442; x=1785386242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8AAHY7PT81febIFH3+wz3Qo4cag6VwKMhyYqM/7URpc=;
        b=YmaNvInDq2MZ9e+dOQa9A0S/5wEXG8GfWo7AVT8KP5s8TVwgQftigF6JJnIMe/6aWv
         2uBgvrYd4pBjk5IoMq9Z6HuBMz5Znb7xPuCC+dOiJSFng/9SP+BMFanp010/J8Jfv4IR
         jIdk+9kAWl5myKbagEOoSlIW53wdz7yR6rRGxcdduSxYhZ3p7gi8hOET1EKJh6wJmLE4
         4SpQa0bhp/otu3O17uNku/eHH84etgGy9HlwjLo+7qR4fuSyb/09ziuXFyhn85Ypmu/p
         LuFG9srAB4X+1BW2fkTJpRIm0fEtX/fV8MkCiYzsaxSrOLYdUuuo3TnUFJl3/LgbSnE4
         DzlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+NDW9WAbhFPTaZeuzHLPFpu1Fem603JbE+aYpPdT64yXXaP227VtrTJnAAmOBrJZRu3F6KwQUmqoT0rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2w3U8ysxTBX+lYIpyFE9O7VYLGlx74KMslaoGbczCTwwJvhm
	kWSOjkAzCgclQ+Pm7IIu2DVF4jix/4GhhMLivu5IyC+ZpZQQ5UYzljJbymLhn/yb2zs=
X-Gm-Gg: AR+sD12vh/l04cxMAQgWdMr4J5UGkyhl9j5wmDwafKgJimcxr+TCrq27lfS0g5p0HQ/
	/ATz6406gQvv5vuPAL1xBWgo0oKTKl9h+OeOI1ynjCjCVZWSpJoBVgy9F1KnQAgaQJfEF8Gi6gY
	Sm3i+Sv73+V7o9h+34e6EOtujkT4eQTeBgFmpOsBIceEpF+zM5NMLCQjSdvmhttWDjvPfQPpfzb
	ZXDNyN6VFgjQURy8pGKf4m4Ke3tyB8fuOtl41/bKhyNWQ5ro+kJKHiy1vHAynhyhPts8Slk0EOS
	JfgeQ5fniluI25hDPmRRGjk+Hb9TlMmb9CNX7NxFonYSqGFcRa2yWpNJydd+8xzT7UFYOJEmZ0f
	IuUt4OVwmZ5kjySYnYVcQ4yLnMMvqfhptb/aDz28B2P6/Sq6UQ/aD07wkwPc5XkFqzoqaTnV9A7
	uuqgQiW08=
X-Received: by 2002:a5d:5d0e:0:b0:460:3233:beee with SMTP id ffacd0b85a97d-47f8d75ee5bmr1661526f8f.42.1784781441998;
        Wed, 22 Jul 2026 21:37:21 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c532d4sm11220481f8f.22.2026.07.22.21.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:37:20 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:37:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <amGYgUhPrSdR5srV@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
 <al34uIyOue73MMN0@monoceros>
 <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
 <al6PfMCuRiYcOBQV@monoceros>
 <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysajxzblyrv4ygt7"
Content-Disposition: inline
In-Reply-To: <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>


--ysajxzblyrv4ygt7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

Hello Hugo,

On Mon, Jul 20, 2026 at 06:53:26PM -0400, Hugo Villeneuve wrote:
> On Mon, 20 Jul 2026 23:18:47 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > On Mon, Jul 20, 2026 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> > > Hi Uwe,
> > >=20
> > > On Mon, 20 Jul 2026 12:31:31 +0200
> > > Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> w=
rote:
> > >=20
> > > > On Mon, Jul 20, 2026 at 10:08:12AM +0200, Uwe Kleine-K=F6nig (The C=
apable Hub) wrote:
> > > > > With CONFIG_SERIAL_8250_HUB6 configured as module
> > > > > (CONFIG_SERIAL_8250_HUB6=3Dm) the cpp symbol CONFIG_SERIAL_8250_H=
UB6 isn't
> > > > > defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
> > > > > hub6_match_port() is defined in drivers/tty/serial/8250/8250.h as=
 static
> > > > > inline and in drivers/tty/serial/8250/8250_hub6.c as normal funct=
ion.
> > > > >=20
> > > > > Use IS_ENABLED() to also handle the modular case correctly.
> > > > >=20
> > > > > Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> > > > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koe=
nig@baylibre.com>
> > > > > ---
> > > > >  drivers/tty/serial/8250/8250.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/=
8250/8250.h
> > > > > index 9d1068d0489d..fb9a7117d145 100644
> > > > > --- a/drivers/tty/serial/8250/8250.h
> > > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > > @@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port *=
uart);
> > > > >  static inline int fintek_8250_probe(struct uart_8250_port *uart)=
 { return 0; }
> > > > >  #endif
> > > > > =20
> > > > > -#ifdef CONFIG_SERIAL_8250_HUB6
> > > > > +#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
> > > > >  bool hub6_match_port(const struct uart_port *port1, const struct=
 uart_port *port2);
> > > > >  #else
> > > > >  static inline bool hub6_match_port(const struct uart_port *port1=
, const struct uart_port *port2)
> > > > >=20
> > > > > base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> > > >=20
> > > > There is an earlier fix already at
> > > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@=
hugovil.com/
> > > >=20
> > > > It's a bit different, but essentially equivalent. So please stick to
> > > > that older patch.
> > >=20
> > > They are not essentially equivalent. If=20
> > > CONFIG_SERIAL_8250=3Dy and CONFIG_SERIAL_8250_HUB6=3Dm, and using
> > > IS_ENABLED() gives this linker error:
> > >=20
> > > ld: vmlinux.o: in function `uart_match_port':
> > > (.text+0x723aac): undefined reference to `hub6_match_port'
> > >=20
> > > Using IS_REACHABLE() fixes this.
> >=20
> > Oh, I read too quickly over the dependencies, I thought
> > SERIAL_8250_HUB6's
> >=20
> > 	depends on SERIAL_8250 !=3D n && ISA && SERIAL_8250_MANY_PORTS
> >=20
> > would prevent that. With this configuration and IS_REACHABLE I wonder if
> > it's an issue that hub6_match_port() returns false in
> > drivers/tty/serial/serial_core.c.
>=20
> I forgot to mention that I temporary removed ISA in Kconfig to be able
> to build and test it...

I guess that means, you don't have hardware either to test here.

For me the open question remains if the driver works in the
configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=3Dy) +
CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
3d406299d8829747fe2e8692f4c29fe3dc1d101f +
https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugovil.=
com/
introduces a logical change in uart_match_port() that isn't explained in
the commit log.

Best regards
Uwe

--ysajxzblyrv4ygt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmphmnkACgkQj4D7WH0S
/k6J4ggAtMEawb5JYTcZ5oLqCa55QAzc+jtWB57AbEEjTFLD6zfOrvcYPsHBQ3KH
tHH8K/xXgZdQPSa4AnKSecXigjExriHEneSb5l8I/UeevOHnc8A785TUP9uTJUBQ
NUqyvd0JkqKgHl8b04YW0X8CCmAelaJSUbN1X7/a8fxVP5TIXHgmU/TjiNI7IFn+
rZ5NYuWxwkCm2msAv8UuVDa/4MtMYRtBMOMs3fY5rIu+/6yi9QXVF8/PCxJKHn8B
V4p0qhfhqS9gLbiVVoYNxQhn40dJ8VKsCo543go20krHNyd0JhGcxfikLC+995n8
piQz3it945OPbBi05uEAP1GIfww8Dw==
=oSBP
-----END PGP SIGNATURE-----

--ysajxzblyrv4ygt7--
