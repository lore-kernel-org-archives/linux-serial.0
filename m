Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07373A4F3D
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582334; cv=none; b=FvTXGA4dpuMAr/f42+2+jmSz2FM576BCQFDGP3hu9LSiAckBbVUW3+06ZDGs/GQ0zeHzKDkXZZeHIUWam8nKny1PaXOXBUkOcRP8vsWh2cUv/AA3RGsjXRebNqfpzCAmAz42OzBlct6O7ij3mflwNK0Q90miKRRmIebL3Kb4OR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582334; c=relaxed/simple;
	bh=Yo5k5cfKZI63ZsfVSlZ1PvrjJI40Yvd5XJL/sLqTKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFOUsXE5lD24x4MgmfwPZYYYddh07Gaz4DMZ/abRmpepShYpxR6TlRowEFTGJAM6EYeh4L6oqPkXu/qNRf/ilDSrIicjYjuqTijABRYQkzaPA1qQ+oi0BoB4Nhaa7DcJvmjNkQmsv6Ii7URNH7F50jqYZErUWIhO8QrlcZZdbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=H3i/yTHZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="H3i/yTHZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495635a85d2so7932915e9.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784582330; x=1785187130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yp2XTUq/RlxiihAPZ6gPMZfyWWmcWbh3BW4cMlgZt6M=;
        b=H3i/yTHZN5LbPatrOoPjpgwd8wtlA9JRzw04HyXn8SaxrJFK9vbjoVgosMZ9K49iG1
         5rz28CMGGHmNJjQHPFfj28VasCXz3PryBz9iBxBHeG4AmWwPjBriXB9c8Doj7Z38Ecjs
         Et/QZf27lAJLsWoGVpy2mnaaQ8CWpszAWhrTEoDWUpRildbAHiUET7hxLHElAPMNGI0q
         ShQxmYgAOL7BqantKrLw6PMnbnq+c9Dqxz9Kj6nCPSkLTaNqvbyhfr4AvX/FpytpiH/b
         HTExxzal0D9vXwW351oKEfy/p4yKMZKX71CIq+0VeUb6exc4G/UlVoQZydbdFGjGrflj
         gDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582330; x=1785187130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yp2XTUq/RlxiihAPZ6gPMZfyWWmcWbh3BW4cMlgZt6M=;
        b=EGLSmO7aO3bQ0MIiKELzf77gkGQcFLd9IJ6f4ugrDqU0v4nMZojwf6bFewLC0ZJ3tX
         pJVjZWdfg4tKkZdV/Q8TU9PwDS6vyOJFarL2lB0JSd2GUwzm9tZzj62r4uEweDW+dME3
         eAHAZj12gdwwWEP0grkNWeqi6+Fi4Lg/54qM9YJa5LrM+RdGCpubpWbKSn0m9OYtloRG
         a7G8xCJcuJ1X1olBJ6mFlK0Ax9iBKlAtpi1SxGHv1PUzsO6E9p+IA+oe01RTZbxW1TKz
         vfOHo3BSU0kV1+WSl7JW4A1F2CiCRVaVVetFjg7P+VqtjXVToU0ErK4XFtCx5UfbfSpI
         aMDg==
X-Forwarded-Encrypted: i=1; AHgh+RrwntfmDCPHVuDxP41gVU3y7J1CnnsE/S57P1Xb4yHgRzpU7yK9jWCFCHOuZa9f4zqK1V08TH+yrbaN7Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37YzGkfmLBI3yFipHu3T7IIvBswH0Sw1reOEzLvy0d8/ItTTc
	Hr/Q0XqUaeOqLQtD0BSXkb4KaYYgTkb9Up4x+vNPkyYTY01AQ2FL221rngURsooN/I4=
X-Gm-Gg: AfdE7cn0SMw3NVnX9JT36br9vA6pw/LJCM/CNgQ+DdtIP9B8MzyxtiGFAQU5gXj/RAj
	ShY5kXeZTRuTNGJ5MCGFV6enaT51XQ+9YQQqX2JIxueJ1kxKHLR5vlAUDbYINiHMeMqXPu5IrE0
	t+NCbrsrwvp4RTPqfgYNTwGP+dfIEKfWJG194YjyCMFOlCbFjS9w+YqYb85Yuk5OF/lbcqV9G20
	J+uDtYYDpoSm1hah8sSLs/AbDoOxnf3j6sENdaFrGzVXUaRcIDyLAiBr8o118KMJJYSH+nciEQb
	Q843pF6bcVHq6SLaLkedjytVAT54Hq0yOLeH0N+Ng+0h0dQXiQypVxuIfDvB+aXiksFCeBYJEH3
	0sIgUn3JOkaUHx2pwuyjfGJwBdWomc5SU24wzlPvR2JsbFQxh/YKAv0Ezp13DJXt9oi8DVuij49
	JXU7gxRlQ=
X-Received: by 2002:a05:600c:e558:20b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-4955cda5441mr56879775e9.16.1784582329872;
        Mon, 20 Jul 2026 14:18:49 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495653bfabesm20152915e9.10.2026.07.20.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:18:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 23:18:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <al6PfMCuRiYcOBQV@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
 <al34uIyOue73MMN0@monoceros>
 <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxecjotfnsbeukm2"
Content-Disposition: inline
In-Reply-To: <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>


--lxecjotfnsbeukm2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

On Mon, Jul 20, 2026 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> Hi Uwe,
>=20
> On Mon, 20 Jul 2026 12:31:31 +0200
> Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:
>=20
> > On Mon, Jul 20, 2026 at 10:08:12AM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> > > With CONFIG_SERIAL_8250_HUB6 configured as module
> > > (CONFIG_SERIAL_8250_HUB6=3Dm) the cpp symbol CONFIG_SERIAL_8250_HUB6 =
isn't
> > > defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
> > > hub6_match_port() is defined in drivers/tty/serial/8250/8250.h as sta=
tic
> > > inline and in drivers/tty/serial/8250/8250_hub6.c as normal function.
> > >=20
> > > Use IS_ENABLED() to also handle the modular case correctly.
> > >=20
> > > Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> > > ---
> > >  drivers/tty/serial/8250/8250.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250=
/8250.h
> > > index 9d1068d0489d..fb9a7117d145 100644
> > > --- a/drivers/tty/serial/8250/8250.h
> > > +++ b/drivers/tty/serial/8250/8250.h
> > > @@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port *uart=
);
> > >  static inline int fintek_8250_probe(struct uart_8250_port *uart) { r=
eturn 0; }
> > >  #endif
> > > =20
> > > -#ifdef CONFIG_SERIAL_8250_HUB6
> > > +#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
> > >  bool hub6_match_port(const struct uart_port *port1, const struct uar=
t_port *port2);
> > >  #else
> > >  static inline bool hub6_match_port(const struct uart_port *port1, co=
nst struct uart_port *port2)
> > >=20
> > > base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> >=20
> > There is an earlier fix already at
> > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugo=
vil.com/
> >=20
> > It's a bit different, but essentially equivalent. So please stick to
> > that older patch.
>=20
> They are not essentially equivalent. If=20
> CONFIG_SERIAL_8250=3Dy and CONFIG_SERIAL_8250_HUB6=3Dm, and using
> IS_ENABLED() gives this linker error:
>=20
> ld: vmlinux.o: in function `uart_match_port':
> (.text+0x723aac): undefined reference to `hub6_match_port'
>=20
> Using IS_REACHABLE() fixes this.

Oh, I read too quickly over the dependencies, I thought
SERIAL_8250_HUB6's

	depends on SERIAL_8250 !=3D n && ISA && SERIAL_8250_MANY_PORTS

would prevent that. With this configuration and IS_REACHABLE I wonder if
it's an issue that hub6_match_port() returns false in
drivers/tty/serial/serial_core.c.

Best regards
Uwe

--lxecjotfnsbeukm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpekLQACgkQj4D7WH0S
/k4ttgf/XyNvIPniDVbI+JmZ+g1LNaI+ED15dgvl5XmvoV2knVNY745u2O8o0OqB
4dYuExiPngogEMsK2/awmMyegP6pPL8ezhdCg4M0Pzafzm7XSaO8cSfhUSZV3buL
c1Z1BC6fPVK6OA0ZQIdmnUbaNrrLfO5YX9YytNUYwj6BEJoJWCFsJBSiFu4CI1g/
izXqhDyaLMnI+5KkITseN122XWjMM3/JOGCO0HXLqvBqJhlEDoFb5o0T9VRU+8jj
i5Gl315ABTkI/+uOiZN4dT2fJ7UBvNWkBCFDzEY3HPuBRiVlJ6+PU9Da8uir2my2
Z/hLFBNxWd3q7Q/lVOnTA46rtGRi0Q==
=IK4Z
-----END PGP SIGNATURE-----

--lxecjotfnsbeukm2--
