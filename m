Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553544B695
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485773; cv=none; b=LRsVqwJmrgeHii/Nag+2RJ3BRxOXt2qrijWs6IFnLERIGKaV7743KUpHqUV0xrF9mY7Hw+012utXskpUnWfXVxSN9MblYTWT/VQt/ML11hGn2YPmZAg3eaCfryDZKnmcHKxx/jU1DhhGWR+GUFBiCIMGjHTWx/Y6keqRiUK9Byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485773; c=relaxed/simple;
	bh=Q4DKFnKTkXnH2MRSHvTJDU1ApcN24yLZrIQOnYqNs4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYiRGOWhCdFz19HveW3zb8uTAj6afZFT/EnOojU0XHnrTjs1oxpeNqfpCWVkxdjdk+batv+JLOrsCtN9rRdOOA5jreahe01vnCiHKA+lBgt70dUqPX8ttIVPIKNnB/Bjk43nSok2ZyOA7EVGG3KC8weLOVOIPsGlXCBRCf1KWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FqCJEFSk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FqCJEFSk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef616daf6so5118482f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Jun 2026 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780485769; x=1781090569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8ClaSNt3nVsD3hSnn8Q1Kd+bnUOa5drJtgOVLhyR2Q=;
        b=FqCJEFSk3hhR/q3dgI/InqN8VHjOShdUrJ+XffU7i1Jovi4XzIaJdcpoW4XxRfCbaY
         acw57XitvxCxMZQht/UxuF93tF66fFwfv0RP3IQ+oDcVjDU1AZYo88/G5P2r5FuRWYKu
         HtOCqndpy2sXAzyo0QED2XZWbuDYEv3/9+RyeB/Fbtg0ARRsT2Xr1/lLQuLVfrbt/Qib
         Ln4L90HlGiUs1eE7ghnxmnv45/9wGCADQgA2R16BawxFZEpb2DK7A6QRYmFMHz34vhtF
         hbGe6d1ASIXGWoWebS08RyIPSrgMN4stn/0JOeCXHShmi+pnJ5pMzIe5mTkQXM/E4Sli
         pG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485769; x=1781090569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8ClaSNt3nVsD3hSnn8Q1Kd+bnUOa5drJtgOVLhyR2Q=;
        b=Oa3FN87Cvv8XRQmq6CQ0N8fgaN1SiXED4eGgVGC4c8iG4njdB3vDTak7Hmq6e0s9lb
         ET7pDBFld/ZANUXSLUTix+mW8p8112S6nM01Vte+QjOXppRkg42NR/vTvDJ9shkTP1n2
         gCKtykSBojHcfjz4XGXFM+eNrm32p5RVgf4goWzQJvVKVWUzsSBGE0aIIWIav2fuoWpe
         CiFFDn6qtDxNTUFe1W1LO71P3+OZvJVwvZrjJmvhg8bfu6gVCKwOlGRSYNbNKDdZ2dug
         rDYzMAc3LKXZaBQsVGAQ/Q7nSTsOa/651eISfhj5WDZilpaaQHL4RLfIuHU3bRiATkqY
         HIFw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yk9CUlnaG6kPG+3l+e2wCxzO9yiAy2XAUh2fO+jdzjdYrta1FQjrSIkEwZr/B0RDXPRkwlntRoENx9Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKNcw24X56ASWLvX5qwPKGFZNnjrf+GjnGGa/eLQuT1h5wSCK
	ekJLmD586Abfo3co1qV/qKWO8BZ/NW12/TWW+RdseR139YpWxPZ2Nljlw0uNjlxUOSM=
X-Gm-Gg: Acq92OEcFGGBCbq10HZuY+YuRW3vMS4RdhWe2EvOT/YyU4wn9IgaxZpDr43B3/zgG1k
	5kKoXp2s4VKd/hyimcKwEx4ZeCzGrYd59tPsZI45kJmOcW7m12DZfdson3XOKbZff77bEMQPXQ2
	ywepujZCBcd2F8JkqXu9wGVr9x6c0PdTREIpbM87h4kbhDE60mc8+WHdWEaKERt0F/8YjBxc56V
	4WccKnv4DkOUrjc02MhGxlgdbPSKPpOmagc8T7ZmvQQRrNpLmg2qQgptMJY7iWsAh5KDMj3R+03
	rltHWY7AJXNdCEytYd6hrL8qPkpNIolp5/HSURAI3nEkRTG0aCgYWOGujQRXhe3Ud4w7UnsSgjf
	92T72NKfXciytxMUrXpCHBYQ0ptpbN3qdVfI080qc9hIUZCWN53pnXu2eCqoN7jhWKXLuLrlW1V
	Z/zDpyQKJ0Kt62t9kD8jYUVlIyJsrYhwTU
X-Received: by 2002:a05:600c:19d2:b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-490b5e94d63mr47004625e9.7.1780485768988;
        Wed, 03 Jun 2026 04:22:48 -0700 (PDT)
Received: from localhost ([90.85.134.233])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b63e63d7sm56975025e9.12.2026.06.03.04.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:22:48 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:22:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Florian Eckert <fe@dev.tdt.de>, 
	Martin Roukala =?utf-8?B?KG7DqSBQZXJlcyk=?= <martin.roukala@mupuf.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Don't specify conflicting values to
 pci_device_id members
Message-ID: <aiAOUgufC0psz8qJ@monoceros>
References: <20260603095616.937968-2-u.kleine-koenig@baylibre.com>
 <aiAFzfU4jsB2iAXi@ashevche-desk.local>
 <aiAHR3y3RZtl7L_p@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nadutpmwmhyvgz6h"
Content-Disposition: inline
In-Reply-To: <aiAHR3y3RZtl7L_p@ashevche-desk.local>


--nadutpmwmhyvgz6h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_pci: Don't specify conflicting values to
 pci_device_id members
MIME-Version: 1.0

Hello Andy,

On Wed, Jun 03, 2026 at 01:51:51PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 01:45:37PM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 11:56:16AM +0200, Uwe Kleine-K=F6nig (The Capab=
le Hub) wrote:
> > > The PCI_VDEVICE macro assigns 0 to .class and .class_mask to allow the
> > > next value in the initializer to define the value for .driver_data.
> > >=20
> > > So the construct
> > >=20
> > > 	{
> > > 		PCI_VDEVICE(INTASHIELD, 0x0D21),
> > > 		.class =3D PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> > > 		.class_mask =3D 0xffff00,
> > > 		.driver_data =3D pbn_b2_4_115200,
> > > 	},
> > >=20
> > > introduced in commit 44e55f1f3088 ("serial: 8250_pci: Consistently
> > > define pci_device_ids using named initializers") has conflicting
> > > assignments. In only some configurations (i.e. W=3D1 for me) that mak=
es
> > > the compiler unhappy.
> > >=20
> > > So convert the two affected items to PCI_DEVICE which doesn't have th=
at
> > > hidden assigment to .class and .class_mask.
> >=20
> > Reported-by? Closes?
> >=20
> > > Fixes: 44e55f1f3088 ("serial: 8250_pci: Consistently define pci_devic=
e_ids using named initializers")
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> >=20
> > I will test it right away.
>=20
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/linux-serial/ah_5qVKOf8LXG1Xo@ashevche-de=
sk.local/T/#ma6eab90ca801b4292639f5c255a89b4033b33d21
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the quick confirmation and also for providing the footers
that I should have added already.

Uwe

--nadutpmwmhyvgz6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmogDoQACgkQj4D7WH0S
/k4PQQf/UcvFTkUSamGGlPhBXSJxmdBJSiNE575NXB7eckVW22KUDN1TEYvhQziI
b3P+jD8zq/WBxw/WCzBzX0x9asQ1kflPOG1pTOh8dzgwtuTqE1+G4kCJfJkaTP/O
V3DtTe76FB7cOKt1DwQveCAcc0AJkdkmv90wFjhmX8WeTSOFAPxqoDaVxJb/xxIA
8vqdVckO22lgj3uMtCL4mFlqqvdbY3P5mdWj4z0YXTTZbsFm7amyzqJaEHCNi0t1
6UG9IywGP9QGZSXWOL7gsCJsYaVZ9R2U3FgdTKTqLndJyvfuuiF/a2C4SfQC6fxj
I/PfQufyooljAHRav0+x5WNGriaBfQ==
=cQHt
-----END PGP SIGNATURE-----

--nadutpmwmhyvgz6h--
