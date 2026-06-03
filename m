Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16C3DD51C
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467165; cv=none; b=u2dcE38KjW5aJgvvQorzpECuHkMIwtMAjabaZPUND8Sp43wUpwzOjn1R2f+FnO8GnntQDh9RDs6d4H8BGcJggm3UnwhgiagECV4ORVcH1yxVPHQjqUhnFU5pnI3D3SuBarH1IwoeQp6KIOeV6QFXWL6P7/ogr4RAHs+zNVxysPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467165; c=relaxed/simple;
	bh=67TOdBDK9HIeLAv4kEUcUJ5q4In9gBjUL94U49pu/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEgNSLFQxNn9xEmL1WeO9qETQl7p4wvvTUa+2f1VUkqerZffVKGBYqxT3BM6K/GbMH6U9vj2m2H6pzOnucv0dCW/c31WzS5z+eK2k7Jps+LsjPuSYh9GDa+MpGrELefRydDcGX1nwuFmFZkGRz/2x3HGjodWVGJMpxnvFjSY41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lni9LCYP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lni9LCYP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso121063835e9.0
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780467162; x=1781071962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeHjJpOX5iItAoNBdoCEh/ep58mKCyjW9XCZ7Do+vR4=;
        b=lni9LCYP0rt8bh3YJhs+5cpAEAsMaFBWzwekWr/M1jSTdWslmVnOMxVGu2wnw7nbVF
         DcqDogn0R4o20XebYp1nv0wTTO1YJlTQRqAf326suiwkBOXvqEsGRS1+KV305r4pxPtN
         DWdW1fBlKXZzJz3mjfXFb46bp+H+ZKhWy48JFWxnv0FQPx+OT+IUEZoF7euGXO/yOIqM
         yYNZVFEnBUC0BrmTGDbMWW047uA3AAfLZ0FVTH2xzcbIFzPGZxMblT8z1EDl2ffcJfvk
         q8jk6aOlczilm53ePhkgxBwhetMCHVto6f1IT1NKaMmTEUvLJXukHMLgI50R7PE9Liyq
         KFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467162; x=1781071962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeHjJpOX5iItAoNBdoCEh/ep58mKCyjW9XCZ7Do+vR4=;
        b=hs1lgISxpM78i3yKV1mgx9nwTODnaH8fjVH7VsywYY4Vll0GUYD/G8uh7oDgfiCcBK
         8nlbxpleiwnNn88ZByv5pTaacDw8a4brBUuniDSCZdsMLin7aKKVXbmZtkDzpBg7tetq
         HSVMMRJdMEtwpQPy88t8VuwkkrDbKbLqB6dAVtvzVMe8l/NNGxqeXEzdH8Xq53siAktR
         TB6Lh3l8KyDNXMyOsSUJuswWSzEDSkM9b05sMqpfi8ZE4+J8AqZJIpbrLEa5MqfpDP2J
         gTMysVjjDYtDsfo2zsBIWWchozc+PM0WnnzTd5+mQjrfjJVMcncmazW+AztKCoyKL0S0
         go3w==
X-Forwarded-Encrypted: i=1; AFNElJ9dSxpmXYa1DKqXBr3Ku8QN28sDDjRii3F2G4Z2fw1vx4yhT+6rc0qwW10i0CUetGBybgh4IBk5ok2AQvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wQW4+Jsg1JHqfH7JXeRjgc4KUkzxkcZUvqcPhW8zFyxXvyEu
	3V7RxuweRsCN6wvc1+RRqy7awa8tYy/0d7ik7IALFE9HEHSzHIaJAsjT7GrXo45Oznc=
X-Gm-Gg: Acq92OFNsJoeWAhkyfEoQxMIUZpruZLb0kykG6B9aIoa0zF/Q75IsuCC0GbR1LWhCY1
	ppbZLJ34xCw5b9dqQ0GVgy+bevnNyMeRNpRtxbGKF/QFBRqZjYk4KYGkpvocjeIb9BpXd+kjjfk
	L4m7hg5J4ApR2AoonmYMMvMCH0opH4l9KvjMHQLSid8XrkiIbnqorABogBNt2OMjK3FzikKTTnu
	nRRjK9MoDlyST7/r/FbutFg0z5FA19BQ6uGZZt6OcVMAKdoG1kzPyA4vzYzGMFMuZD7v/rCBx2x
	bsMN2YoV8+t9VNOTjea4Fy5siWznpbAu1sRYr4Pmn9BgqKye/GLYmailfMH5dEvO23yRB1U9GAh
	9kPtIuMtp251PPGHWKGHF8Y4cD9IL8mvR0A80TNAMc4dxYMw8RlIibTTjzrg7CkNOtfx+nzxUAa
	T+TcS6OTqNYXE+aTsWN84K+y5M3XMjIPTg/3qMxHfFCuc=
X-Received: by 2002:a05:600c:810c:b0:490:afc5:f95d with SMTP id 5b1f17b1804b1-490b5e82e89mr29711625e9.29.1780467161989;
        Tue, 02 Jun 2026 23:12:41 -0700 (PDT)
Received: from localhost ([90.85.134.233])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b6d16f0csm28732765e9.15.2026.06.02.23.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:12:40 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:12:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <ah_DFCQH9e47qBp7@monoceros>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzawbrcz4xcmfx2j"
Content-Disposition: inline
In-Reply-To: <ah87KOm0nfAyvr4c@black.igk.intel.com>


--lzawbrcz4xcmfx2j
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 04:40:33PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The various struct pci_device_id were defined using a mixture of
> > initialization by position and by name. Some use the PCI device helpers
> > (like PCI_DEVICE and PCI_DEVICE_SUB) and others don't.
> >=20
> > Consistently use named initializers, drop assignments of 0 by position
> > for .class and .class_mask and use the PCI device helpers. Also use
> > consistent line-breaks and positioning for opening and closing curly
> > braces.
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This patch doesn't change the compiled result; this was verified using
> > an allmodconfig with several things disabled that make reproducible
> > builds harder on x86 and arm64.
>=20
> This patch broke the build.
>=20
> drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overrides =
prior initialization of this subobject [-Werror,-Winitializer-overrides]
>  5398 |                 .class =3D PCI_CLASS_COMMUNICATION_MULTISERIAL <<=
 8,
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_COMMU=
NICATION_MULTISERIAL'
>    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
>=20
> and so on...

Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, gcc
13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
because .class and .class_mask are specified twice; once by PCI_VDEVICE
and once explicitly.

Which compiler are you using that breaks here? I guess I might have
broken more drivers this way, so it would be great to have a setup to
reproduce your issue.

Once all the initializer are converted to named initialisation, we
should definitively drop the assignment to .class and .class_mask in
PCI_VDEVICE, but that doesn't work yet.

Best regards
Uwe

--lzawbrcz4xcmfx2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmofxdQACgkQj4D7WH0S
/k700QgAlRtvzCIb+0k9xcRIMXHN1U7DkTYASRyk/6nQfcrCuiYy7RRXEvl/0Esl
tdLT5A1h8QawVPBIQWNH6bdwAR0fcMy1RoFklG2laZlfG9ONXTF+03O6cBwTs7oN
KS7LCH1L5d1nlqQqcFLZ2RblHcsZL0ITWKN0lkF1Rs3c++LMTkMvb61IbOfPWHkY
WVlocswX37I2/vTMNNKdRb2WQXU/hDoMgM7Jm/4cS9DPgJ0wLU9TllpvA7ukEYmP
KajH8G/JTUpQK29jfciXW63WhvZhpRKg/S9+BE8dTSahBCGW3WTKrDpO9NBuSxjz
beQSuvHqhF+U4dcqs39Gy7pLSiRwdQ==
=NYhb
-----END PGP SIGNATURE-----

--lzawbrcz4xcmfx2j--
