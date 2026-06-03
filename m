Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C703B3C10
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485706; cv=none; b=UybPp7uxHE9r0TRg8GBAbIRk5ka2y5McKact0VVmfFIRG8AnYt6etYnG386xtpNskMC9W5IP9WMKoYJ1pjopPN8XHowty/ed8pEVzox3O0dHrX8RY9ibZ2E4bhUs0QSFa6bj8BAUQGx5RC8wWAbVE1p28oef7OdZDwCxSSDDRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485706; c=relaxed/simple;
	bh=nIqkF5ASL5Z8tthKaaIt53wSzJu7hBKPa+tYBbtxx80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhgE+qGeRCK/66rem/OcndUjzdqA2SgNaJ0anZb0AQP9cGhXNN8S0P74Ud1Ijv02gZ91qqdlx5B+yOcmh1EXd6MbF0tjZHXrxvSPICp/pxWB1h65/EvasknfnIKc383/xILY/iYAtb7CGEgeolw9w9xcWvQZmR6ASmb9gQpqZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=R9gm9u8K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="R9gm9u8K"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso117340405e9.2
        for <linux-serial@vger.kernel.org>; Wed, 03 Jun 2026 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780485703; x=1781090503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS6SynuX5go4hQ+C8XBPVB+2hr5QcfLOE/mAwESXrFA=;
        b=R9gm9u8KZiMpgC39/GVqe/7GpVsZFM5tAuIz6iJng44NAFZzPyDppmop6tcCdEd5M1
         CLDn2As5Ff6Ifk4mTr2+vtx0Utbr3NLlRdCagJ8M4msjdb3ejzZF3+97uF/MKR54Z9Kr
         E9exedm0HbNA7zzJVNjhue+IDDPnfR1hlUNkXqN4/FRgkEw1RmXt4Fv7FfBMuQTdg1b7
         DDWTZS9wHCaba2BKDs05Tk/hX0Z0+CIK858Q/0rBdfP2ay5Hoc/0+dt8WEqlWASkoNO4
         Y7zDgZaYu60G7L/xTocqRfC9GWsoDuRNkBDERuykhfgVO4gNWEvjKkXRumaPjuiCH1x9
         QhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485703; x=1781090503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS6SynuX5go4hQ+C8XBPVB+2hr5QcfLOE/mAwESXrFA=;
        b=pH0TaSEVP0nRu9Km35lTFTVura5DHurtd3G76mwTmow3ddi5NfnTdcjnradMWrMDHA
         QIgjebc9+7u8UdVNpV8HXNyOOV+jfkcI6vvAxZmpN+7r0F+ZjTlhWhcGM9HAF6rwiz+G
         9kNGmbNOWCbO7h17kbu14ZgjeAGzLcnEa6DTEM9eBUCnG/CicH1ZFqbJjNPHu3kiI8SL
         +pKc31fzUdgXEa9tJUVBnQ6DRuhurenYfNgQxWENBaDnxdi3+mMr2fNU2sIh2gA6cSdo
         /hfJoEnGRZQXror7YNPl/6wko7Li/t8fe/ynPLQuUOkGcguoYrUtkoHgrroUAXQdZo81
         3yKw==
X-Forwarded-Encrypted: i=1; AFNElJ8wUngUNBC7TWNNoRbn8VvMxKpemlLgw56eOEDOG17sZAK0ATrytZNNx0IAGQWXa0Dft/e28B+5lREUhjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ybkby34LysTAmIRE8DJRClFsIikI7mbZPjqjpLbbh4Sxfb+F
	EpZrVbSFHeGqlEzKTdRgS/j14SxbfSLkWmd30oiPynkvQRyp3nznQZZ/3//CF6vfVq0=
X-Gm-Gg: Acq92OH/BuohWy6o3VI7rqBdr1oC9wQ/3HRnmfiyXFMk/922CCQvBZTn1jqxdsR8QuP
	31zv0YnAQmnsGmgKf5wFMpyEJ2ZMzG4AgFqzr7qRJJJzAhVfZSUHDI1J0Sr2Oefw/68i9tGTbDF
	yIXPCPCAlXiG9Tzj7DySajgfZVyJYMaQ784as0FwiuxQYogrS4YwabBYCC3xtN8cPDYvk7as0fH
	U4T1zsoyQpP9tEyHg1wHGVjg36Wbp9KLdapFI4etxRjY8/XJ0l0L3Wv+GwFL3O4yTqF5oniAEZy
	cAIEqvjvm007+2u9zV9elEsuEucagmOm/3oUEIjvvE5VWstG79NKZPbXddrSiHR7ElEk8QA2BFV
	rQIwJx0tt8tYYzJkBmNVXCLCkzbsjd0ZbO1zggg0CvNCGFiwq37KNgc8wl/gPiA4+S65DBrbHDy
	oLFKusi3segnPJagv6uYHTyQq/Gvvw1UYe
X-Received: by 2002:a05:600c:5394:b0:490:b65f:8b1 with SMTP id 5b1f17b1804b1-490b65f09c4mr49953065e9.5.1780485703014;
        Wed, 03 Jun 2026 04:21:43 -0700 (PDT)
Received: from localhost ([90.85.134.233])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b6162289sm51754535e9.6.2026.06.03.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:21:42 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:21:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <aiANetMk3rkR0SyW@monoceros>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
 <ah_DFCQH9e47qBp7@monoceros>
 <ah_Iovpb8N2OTucV@ashevche-desk.local>
 <ah_2rD9UPEYu78mv@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m2pthcughyzn7cc5"
Content-Disposition: inline
In-Reply-To: <ah_2rD9UPEYu78mv@monoceros>


--m2pthcughyzn7cc5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

Hello Andy,

On Wed, Jun 03, 2026 at 11:43:14AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Wed, Jun 03, 2026 at 09:24:34AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 08:12:38AM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> > > On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> > > > This patch broke the build.
> > > >=20
> > > > drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer over=
rides prior initialization of this subobject [-Werror,-Winitializer-overrid=
es]
> > > >  5398 |                 .class =3D PCI_CLASS_COMMUNICATION_MULTISER=
IAL << 8,
> > > >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> > > > include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS=
_COMMUNICATION_MULTISERIAL'
> > > >    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
> > > >=20
> > > > and so on...
> > >=20
> > > Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, g=
cc
> > > 13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
> > > because .class and .class_mask are specified twice; once by PCI_VDEVI=
CE
> > > and once explicitly.
> >=20
> > > Which compiler are you using that breaks here? I guess I might have
> > > broken more drivers this way, so it would be great to have a setup to
> > > reproduce your issue.
> >=20
> > My make command:
> >=20
> > 	make LLVM=3D-19 W=3D1 C=3D1 CF=3D-D__CHECK_ENDIAN__ ...
> >=20
> > The line the above error is from is from your patch.
>=20
> OK, I can reproduce with that cmdline, thanks. Expect a patch in a
> moment.

The pity is that an x86 allmodconfig fails to build for different
reasons with W=3D1, so I cannot easily use that to check for other drivers
that got that same clash between PCI_VDEVICE + explicit .class assignment :=
-\

I'll experiment a bit about how to identify those, maybe I'll have grep
over all my patches ...

Best regards
Uwe

--m2pthcughyzn7cc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmogDkIACgkQj4D7WH0S
/k7HtQgAnOesES942UIO2uoPm0wa6h2SdMgEDPjFv9FJsZW6UWUw1tStsKkAxi/L
H8H8vOEvqQ2bd5XMJFImNXvdRmFl7VEsXWi2jc0wZzaV7vsBhpV3yOlWSnWjHhBk
ODf1eRbGzVhf/bHyYUNOoUodMWtd+zeDwvB6Ev6eK04basmonY+8mvdCTkWxStcE
4KdTgi6a4ig+n+a0PujetPaLqIr4mX8ey6SuyaxUjdobadjECBXW9C3cyvjNGqLX
S1PvuWS5DefRuESkTUPFuNVacmOB6e4QNiF6XuGVrp73MF3ya86TBOEj9HQtOg3d
KwpkItvKUOElfGTuUW7RYxh5P1AwyA==
=ZoKu
-----END PGP SIGNATURE-----

--m2pthcughyzn7cc5--
