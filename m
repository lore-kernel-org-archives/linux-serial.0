Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09F3815F1
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479797; cv=none; b=SaVBTtVxhfgbpmFj2cFHFb6mGNbOoNV+5Ccz8upXL0JMzwXLJPpjBejPMdordsD3kM7v2gsILLIRtJr7ayP3pJYPEfdkFYrvO8JXcS553HmhX1bMqu8vXWWcKf6WFCUBtTYw1z71Eh1n72NyL2dt2wMpsFBCXFHwmK1IeJQ6zLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479797; c=relaxed/simple;
	bh=yD8a3LZmHrJwe/ccuzkH4z7Q36Ar3Qxh+VaELdFIkDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svjHMw7eRwFGZEidiXTRV99mUevre7vnE4uXFg+gZxqQfC2qj3KBC7MBkUFbiGj7gaWjbj1Of3eaPRVPNvrGCBt7EXFlSvkYI5UOSFsblU/caaEWapD7XeN+EZC/D8tmn6JGIsYryWL8PQJQrt2VhQb9YjwxY3E2KYhnev5YeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eN44IhdO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eN44IhdO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so125926965e9.2
        for <linux-serial@vger.kernel.org>; Wed, 03 Jun 2026 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780479794; x=1781084594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTMgbOTXAB4xikb+y9ZCBh1XsPiBKJR935kuuIarxJE=;
        b=eN44IhdOOOGiGtNP0T8XOqSVJygzI1aES0SSlFU80B+PEfv5qO8fhBFJVYdFFE20iE
         vaPTDfeIBCAl+5pN/YUdxbDRfufXqko2ySvIy5orw/wDVMxDml1KJdYSnJirmGNEI9Qb
         1DnzBbrEWhL1hjeukbl53EfddKkiKFK5l9aWCmw3HF3yyhXSWhFXDdtYN9OfxpYcxLAg
         ySaeg00UuRRzRMTGDj9xHmNOFqfnwtJbQTYpvYidSf9ztvINfOfKmCQ8wexcvAChwTvO
         E7xaNaXT4A7izpd/ZQ2qKHMlMTutmZbsnF8jWXuaQlDCdPKJ/QLszzNY2Vi/Sst2OoV2
         feAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479794; x=1781084594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTMgbOTXAB4xikb+y9ZCBh1XsPiBKJR935kuuIarxJE=;
        b=pVwT7E5RPsfyW5D8WAaOpW5xNAnO9A9W3619KeWdwo7ntgBsXHXHEiPKlR6gvCjgeV
         6dYxSSu4xl2/hJG2Cu13N2523HySdH2WsDLfE4dSMakqgW8BPvVMaiggX5HWSHTeOVAw
         ysACcO9kgZ71lS6mcHUAXRgILKHAx5pj38ZUlzkHzPa24mPOZG5NY7snbwEW/QgcpzUC
         jo5T2QlqbHSw/lTuf5YbK4pCfNweZnbKG36CNy8yf8UGvBLpskpfo193beCI4IyteKoG
         7V7LxmDSkGyB4QsPRZsu0iTP2AtjWk76U1TmLrWAMdKtjvQUBKLvpXmqLiGvcwfkYzjP
         NoNA==
X-Forwarded-Encrypted: i=1; AFNElJ8XVOkWflqwpt/Q6lFgFAkVZ48belxOjG+zf7Xr5cWeiHmI+6ogZlGdOd3zN2jyhKe5zkYXcoDzHl3KNbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6fJ4XEVDJoeY1G8BKORxmdHVNuoXypxpKqbSHAc/XvisfDoR
	Ah7DQYz5lVyjJx1t0GRNaEyxgZsZhrnlUWi7HV1Uvf0KoL0JJEFwnqKm8skAF7qvqY+eoubi060
	reBHKs90=
X-Gm-Gg: Acq92OFeUVIrKTY2n1LRoppWFxgITR2NlMaT9bk0eMP7wqoy7z3PloNEmH0N5KsWra0
	bCqLXhP0paFWJQNvoz/p/SWuiHjcI5a9fG0/8sjUrnnvQQF7GBYgqSe0DzJUSzmWFrFrR3CwLv3
	vbDiaueP7ekRykODD9okUSpAy8ixNzzLo2rTfFT7wA9MexqgHu0dRXw/WiXTywC3mGvFDYSdnMk
	4b0Ymjw0MuXWVuIsKpLpWp6Dd3igmEK9uyHPhVtqGp6u1p6J3o7A8LJTE8Qcngp0/mKksHMk44y
	Nii3joZSqZonAlVk+lbvWrogmMZyqxIuJrAauEiaNgIfXmZbMOZ0IoBDDEeeKqoniMwbmFTlMkr
	g3f6XmTLaCGhK06sEk1kjT77TV7BSOmRUfHsPVgUA0vlZji0GLpjTE4SadRXW4faeS4BFU0tgzD
	RQ/YDMA+vp92jo4UESRkM0wroVW+JIWO9PGCm6n6/oYY4=
X-Received: by 2002:a05:600c:4e92:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-490b5d412e8mr43565415e9.13.1780479794438;
        Wed, 03 Jun 2026 02:43:14 -0700 (PDT)
Received: from localhost ([90.85.134.233])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b615fb2bsm48483725e9.5.2026.06.03.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:43:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:43:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <ah_2rD9UPEYu78mv@monoceros>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
 <ah_DFCQH9e47qBp7@monoceros>
 <ah_Iovpb8N2OTucV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yzdb7oc6soan2h4i"
Content-Disposition: inline
In-Reply-To: <ah_Iovpb8N2OTucV@ashevche-desk.local>


--yzdb7oc6soan2h4i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

Hello Andy,

On Wed, Jun 03, 2026 at 09:24:34AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 08:12:38AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> > > This patch broke the build.
> > >=20
> > > drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overri=
des prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > >  5398 |                 .class =3D PCI_CLASS_COMMUNICATION_MULTISERIA=
L << 8,
> > >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> > > include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_C=
OMMUNICATION_MULTISERIAL'
> > >    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
> > >=20
> > > and so on...
> >=20
> > Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, gcc
> > 13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
> > because .class and .class_mask are specified twice; once by PCI_VDEVICE
> > and once explicitly.
>=20
> > Which compiler are you using that breaks here? I guess I might have
> > broken more drivers this way, so it would be great to have a setup to
> > reproduce your issue.
>=20
> My make command:
>=20
> 	make LLVM=3D-19 W=3D1 C=3D1 CF=3D-D__CHECK_ENDIAN__ ...
>=20
> The line the above error is from is from your patch.

OK, I can reproduce with that cmdline, thanks. Expect a patch in a
moment.
=20
> > Once all the initializer are converted to named initialisation, we
> > should definitively drop the assignment to .class and .class_mask in
> > PCI_VDEVICE, but that doesn't work yet.
>=20
> Please, address the build issue first. I'm surprised the LKP hadn't compl=
ained
> on that (yet?). Note, that all redefinitions like this are broken and nee=
d to
> be addressed.

Full ack, I didn't want to say that dropping the assignments in
PCI_VDEVICE are the way to fix this issue, but only that it's a
surprising thing in it that should be fixed as soon as possible (i.e.
not now).

Thanks
Uwe

--yzdb7oc6soan2h4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmof9yMACgkQj4D7WH0S
/k5c3Qf+NjGOzYCvpaey3O7EI4E/B6DGohks3UrpYpvGrx8hAtD1/qqEREO+LsUV
7DPhUJSNmq2hOlJzVZdMKhRrS4MwWMnJCTB19b06AQ4CBOzbiH+1X/Y77VEZITZu
vf7g0Hl9JEYI9/QhhGUNIVYyx1UumAp/LLvYk3ZuGhTOLrk/dP+rBe2S72lHMdM8
r6VrxGcB45xqx1iU8FWCYE20pXD9i4SMF5ohe3U5kKJ9JR2Qraf4TgDjO1zNLQoH
lvgJlApag2ZCWdPl6cVIIG7tbK2OhBCsEfFvzFvMMVsh2jh8Kw5xq/jaqGU84u9Z
1Il2UFgmo71DtuwMiTXwiUtA6w9kZg==
=ooZy
-----END PGP SIGNATURE-----

--yzdb7oc6soan2h4i--
