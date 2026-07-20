Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD2399887
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543498; cv=none; b=DWYPyM8QJs8B6Kah5DSLf86F1bCo6Ej9JZ0DJs9PTsBsj4jfpy1xWO0c/d2uMn79BMj99Oh6D9wrsslHddKF792/NHXjrWfZm7rtoybpJ8EsT8mC3ofR9N6VBsqAquyCaPMxPLJ6bZICvTbliTmli1FeJQ+IjWiuVjPLkz+PPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543498; c=relaxed/simple;
	bh=46GnOF9F7vwDTg+XTnRNtlrnkTCbaGp+EJ46x5F+NZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYakni3N9vUyMuOrzNZM1fHQ7PVDwEUtLN5NuNHiLUxXPOnFGwgVIuFPn9hyMOi1HwQeZebBiU7eW/o9cXE+kzU+pTekGLWYTtQuAhjPfvnXn7D+2Gu7zWBji8nqpbiOGPPCL6ub0LA9ERWdPwB17wJ1+Y9se/k+r931Gqiwzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=io2yY9hv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="io2yY9hv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-471eeac43bfso9288155f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784543494; x=1785148294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uvOwHXcOnUd6y6AJIJqeUq1M3Za1gq6UKyse48eUhM=;
        b=io2yY9hvECPme4dZbULWWe4zZszs4OIRDWbAZAfQFtHwty6WUSjsitsB5hfuBNn77q
         5s0z2wDY+bAFGhVkXeOW55TUuK7Pfsdk4/ShK5IzW1L/t++PZohu66xeE6wooEoJ0O+R
         rzVy1zfkzgCHgacJRk04P2GNn6Ra8xMeifqNjiXTWeaZTCUcJicWVo1DeKA9uMa5kVg1
         7LWYMDtRpFHaxY65amuoFg8Rdp8r5zOriXHOADlHrVo0uNpPxU7grkJ3w/kRZQ7ox8pL
         81pWvPk11mLyN3izZiZRfPJez7vm8GObFi9UH6B+Ysu+PwCokv+ztP8hYl0ukx1yphwe
         jFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543494; x=1785148294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uvOwHXcOnUd6y6AJIJqeUq1M3Za1gq6UKyse48eUhM=;
        b=aYqprskVYPfh42j3Bf8euMHWy6+/T2AUI2SOJWXhNPzpUpfY2UJxDapheoa5VcfVPu
         kxnvtW0wABzhX5MjTv6POn94s4TfLmXVHipY2Pk9LST0nOqXO9qVktlqWGmoQe4BL9ek
         +HfPayw6f9ciyiiGU3G4vSyFraCYNIc88ueMdpL0ldpKyIisuOLpSAq/HDdonHUlbXji
         oVpjetUksjBv0zYBsEECjCawdPzYpV0YHIUKlXwgGBeZkASFbMDMFQzAzHgMhaB5QiXM
         +hH20ZAItUNKTRn9SQMbsqMx5jbPDeHIovZcpyS08uFwNmDbdfr6/BF4SGkCbDwtDt57
         6qVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAR3F3wI4CmyFAmQjiHGGxgQ8RwbwHOIqbArCiA911JCcr+RBat4CH0dUsL8EX/L1ev5t4NJ2nTLSjw04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXmM1pLzy+N6C6LmZalCT2poCu0nktJuaZq0eX93JJsmYKYYz
	7qasSpSViOTZosQL8kVDWVaJe+Kj5bCgAPI9rp7oeFXrG2R9F0ZEikOWJ+PhHtcvbu4jgN44zL4
	xDabk
X-Gm-Gg: AfdE7ckzTKyoAsAGf9IU91jYXyWApUMFlVfedxeCdKz0h4Mc1nhCaWvBUMxU2jvwsTc
	1JZluprCiRf3y5nmkB7WynqHieTMN7g25eASbV4PJpthhymPOE6u6FjygPoxYOvpgLUnY3rCY95
	DeI1SXhggs1lkVOShNktyH2retVXh+iUDsO5WleB5wp2lMRjkZKKtpKVbgPYixxj0AjjMD526sM
	WWLq4VPghgzwSGDeDTqvCk/16iQwZGgmnSIFF4OYFyA1HgePKuc6zaSZlA2q2HgWZ9qbst5sjiO
	8h2iNPzxY2TYvjLBSZ6M0wkH9PIsEfQZNSBnoue4KPHysgxSb2rrkSTE6wRVeFUVgP0YqM/Dtpx
	fvzuVdKpccx6LBT/gDalagM91z8fUe78L4fZiXe0NLpyN/KQ11sVf8R1QoyhfraPkkvr/PmfaHS
	mVGF1vCA/etk+6qW4jJchGKdXsj7odV8s22ZIZL0lio3A0Eo+QOGRDV5I8tXrLMscMUNPor0tRs
	eSZ
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-4954a3ed4bamr143137025e9.13.1784543494185;
        Mon, 20 Jul 2026 03:31:34 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e65644sm27485955f8f.16.2026.07.20.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:31:33 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:31:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <al34uIyOue73MMN0@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrc3nztluxg2ig5y"
Content-Disposition: inline
In-Reply-To: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>


--mrc3nztluxg2ig5y
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

On Mon, Jul 20, 2026 at 10:08:12AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> With CONFIG_SERIAL_8250_HUB6 configured as module
> (CONFIG_SERIAL_8250_HUB6=3Dm) the cpp symbol CONFIG_SERIAL_8250_HUB6 isn't
> defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
> hub6_match_port() is defined in drivers/tty/serial/8250/8250.h as static
> inline and in drivers/tty/serial/8250/8250_hub6.c as normal function.
>=20
> Use IS_ENABLED() to also handle the modular case correctly.
>=20
> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  drivers/tty/serial/8250/8250.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/825=
0.h
> index 9d1068d0489d..fb9a7117d145 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
>  static inline int fintek_8250_probe(struct uart_8250_port *uart) { retur=
n 0; }
>  #endif
> =20
> -#ifdef CONFIG_SERIAL_8250_HUB6
> +#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
>  bool hub6_match_port(const struct uart_port *port1, const struct uart_po=
rt *port2);
>  #else
>  static inline bool hub6_match_port(const struct uart_port *port1, const =
struct uart_port *port2)
>=20
> base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f

There is an earlier fix already at
https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugovil.=
com/

It's a bit different, but essentially equivalent. So please stick to
that older patch.

Best regards
Uwe

--mrc3nztluxg2ig5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpd+QAACgkQj4D7WH0S
/k4ZnAgAoOlWWhpOIbmErmLUuhDTeuEjNUEUy553tY37nqI+JkPsiM9OfhvElr8x
coEF6TwEs3+SEu9q967xCDBlC7TA080BptprdLHTbm1mMMMrJHElyjg+AF8X0abX
Xt0JMW6YFV6bNe7KIjaqsapQS7k/4ubpoVb/2dtlDIhNpu4CUwYZLZ5yk+/5ypau
5BIsSLvhjy49f2iFB7vjGWE6Q0VhTnm1uiU84pIZYqFTY8NbO4AzeoNx6qsUqgEe
hZ6VvPszFIDvueCGBmE9TZzNd66kupXxz2s91tZF97VVP0AW4XH5iziCPSDfSZ9v
y+1CogkN+7g5jnlycXoPvuVYsUbKlA==
=Nw1k
-----END PGP SIGNATURE-----

--mrc3nztluxg2ig5y--
