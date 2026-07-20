Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A339734B
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543985; cv=none; b=m2n51yd8h1m/u5/Ux6l+3R/ORRzpfqldLsmJikdx9HYKq5cmsXMZR1Smb5VmIz35t7SKUBe2dSEMDa+3hZ+3epqArjQESk94Vc7IzlwayW1v4CZDNkPi5jNGYK1vupZI/o+sU39dN81TuT1IBXTYlNticYrqTAXGrqQ2x5Fk2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543985; c=relaxed/simple;
	bh=DVJ7qSX0uNfm15GcEO97JD1KRQETbqyrFscAKFQjCp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHnF9D06KjVcMLqBykI8+06i0Epj1xixAHlZ0vabwnRiwH1bB7UPmjSwgAtQMzOr1xAaQoUowO+51cgs3k3QInD5I1Wxjqmt0Rtq4CVo1fjKome5XluSFUtXqXnetUKfS6CEY7dg9K4LliTqB6uDGDwWa1hQP7CP0WCI6a+5UeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=USB4cC6M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="USB4cC6M"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso15912735e9.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784543981; x=1785148781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b9JXL9yTw9hjgzpkXGxJBEAzkr1jsDbpHFN4HUS2FG4=;
        b=USB4cC6M4eWAzUZOriT1lGUzon3LFfiKca+nL5yii5ftoGLm5HELP8aI9n35NFyzdo
         X0YwdOyEk5Ug454MO8lcJ7UG16+V8s+BEQEEr2sBqDfWoW2m0ybzz7uiWkYIclK7vLDN
         o6Qoip279lR0tSkKJZivuG2TF7DLj6V66TJI/SclDctiW5Udr/DZ9VHacJDckuMonqW/
         ymXc2A8D6nE7Zq/j232ewfgdaK9LUDwsqPruJzyxAqFEYH2/XBQroQ4S4I/WCIQBaYsX
         JM0snPbTI0Z9/5OKyTQgtsb5mp0GTWf/7bD61XPXa2lV0lyHo3dX3Mg5EsByvN6L97G9
         Yp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543981; x=1785148781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9JXL9yTw9hjgzpkXGxJBEAzkr1jsDbpHFN4HUS2FG4=;
        b=CXPW9WTFRySHyKMATl9D04x9U96mNVgDGh1ReUULSXmx+N3LxY66OjGwC4UMr6ynW5
         vrwTdcTZtQo7/8LUD46RjpzAZfcEhkYJbMLDqAsiTnn07c3OHM4bUbnaQn4sOetDXUbL
         yb8gzV3ACQbQk00y++RaFk76jhEaQ2zX0q4mxOWMrXmcdpx0Q3XuEnEPb/uCpmS8vPlp
         G9e86CysIHfjcYGraQ5ZA6i6988moFFqCD8UMNPttk9DH6fO4J54tYLrcYsaJOjQXYY4
         h1uzUO3QoTHXVrVehylTriTbTxVPFIO0cHAu5vVI+W3cCdvppq1nRphD1eX3UbRb+TRZ
         Yekg==
X-Forwarded-Encrypted: i=1; AHgh+Rq95Qauq9L+N2A1/ovmICkkT0zNNR3DsHPaHG6uEr74yoAZPsrU+k4QOlCEDq+CgWhACjN/d4A5+lrtRTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5GXcNs0wwC7XIFCRwTlX/RTaLthz5wCqdPMG4QrzvvxmWceJ
	HNWKc/08huN1d+tAC63qbtsfQDAfKfBrxqhrPkoHpW1/gnYJu6rufdbAlq2G2wjEM+A=
X-Gm-Gg: AfdE7cnaeqDkaqBMkn6nrgEm6nAI5EvND98l6OnAgGa3tLt4jzctVRT/LL+H1Tfm48N
	14eC0cITHIHj/ZWI65mMpm+oitOo6MszoJ+LaLROe1fWciiQwgIjtIanSqZIhgbUWw7bCpQGyaM
	jCnGZpMYrTqcwzDE7oocW2a1cuiq/QpvTDQLR5T6+vFrT+lS5zUanODo73mFkyq4iJzSenMfL3o
	GjP1NsgDhKPm5+RzRfNF57HXWD5yXVrTIx7je0szonn3ziYIrrdpZkscVoNDRrYHt3pTI7AWtBm
	qHz4p4WW3ciB924EZJnuT/7F4uBhvd2Yc9TMbc6zmtSjUNg5I/WVu+QA9m1DOAD6pjvvchYEDBY
	hU9jw5fo2fcZjqlza5mf6qzgPXGIatnzvf9Ot/L2lsHC2bC35H3eqYroQ1Dt5/tuN2BR1dBDgI/
	Cml6IuN+cJPKRJXJ4xf3jW61UabTZ4adUMy6FESu7n3/w6QOHHVzW05MCCRIYU0ASBcQ==
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-4954a50ea30mr169131375e9.30.1784543981052;
        Mon, 20 Jul 2026 03:39:41 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4955d6d9e71sm88447585e9.14.2026.07.20.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:39:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:39:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix compile error with hub6_match_port()
 when compiled as a module
Message-ID: <al35IBntRNPJNoNw@monoceros>
References: <20260715153707.4181828-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmqi7ipcqsg3tzep"
Content-Disposition: inline
In-Reply-To: <20260715153707.4181828-1-hugo@hugovil.com>


--rmqi7ipcqsg3tzep
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250: fix compile error with hub6_match_port()
 when compiled as a module
MIME-Version: 1.0

On Wed, Jul 15, 2026 at 11:37:05AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> With CONFIG_SERIAL_8250_HUB6=3Dm, we have the following compile error:
>=20
>   ../drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of
>        'hub6_match_port'
>=20
> Fix hub6_match_port() prototype definition by using IS_REACHABLE() to
> support both built-in and module values, and substitute empty prototype
> otherwise.
>=20
> Fixes: 3d406299d8829 ("serial: 8250_hub6: add hub6_match_port()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607150717.2YxVdWpX-lkp@i=
ntel.com/
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I hit the same problem and fixed it similarly[1] before spotting this
patch.

> ---
>  drivers/tty/serial/8250/8250.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/825=
0.h
> index 9d1068d0489dc..b62f88eec881f 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -8,6 +8,7 @@
>   */
> =20
>  #include <linux/bits.h>
> +#include <linux/kconfig.h>

This isn't really needed, because the compiler is called with

	-include $(srctree)/include/linux/kconfig.h

which I think you can rely on. But it also doesn't hurt.

>  #include <linux/serial_8250.h>
>  #include <linux/serial_core.h>
>  #include <linux/dmaengine.h>
> @@ -334,7 +335,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
>  static inline int fintek_8250_probe(struct uart_8250_port *uart) { retur=
n 0; }
>  #endif
> =20
> -#ifdef CONFIG_SERIAL_8250_HUB6
> +#if IS_REACHABLE(CONFIG_SERIAL_8250_HUB6)

I picked IS_ENABLED(). Both work fine here. (IS_ENABLED() has the slight
(maybe subjective) advantage to break if CONFIG_SERIAL_8250_HUB6 is
enabled but not reachabe (which currently cannot happen).

Anyhow:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--rmqi7ipcqsg3tzep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpd+ucACgkQj4D7WH0S
/k4sDQf+IIH2T/heCwFyutuVwuDpEMD0Zjs6qP1y4aXgIh8vxRO+jltXYBEYBMMx
LVLpZFX00z8xROp3oYzLFhiQqjvaLYr0GPEEDGyaUsQ7MU4KUIi555J9Yo4sgksZ
n9nHQ5ppS+qtEWcShgJZgNBjH6fbiWwkJdPi90XoOKAXYRHGcdmAyLoyNnzvZxr8
J4FegOf/0xfSHWgiOm7VknosO4L9BYrzmPQPRatMO8aStNUhnvLJf9tj7klgDzmh
D6SoEXut+TPxH1NEquZVOjyCiaK+pxvtsaZs1qdkAC4Lv2+C4Fv30acYg4HivVa1
I/cmmq6tiCZuMx5h+Zp2isjEpduQyg==
=WJIb
-----END PGP SIGNATURE-----

--rmqi7ipcqsg3tzep--
