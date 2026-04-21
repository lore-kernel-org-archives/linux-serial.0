Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36039E6E4
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761633; cv=none; b=MhnA/1be0xbsj2PYXQGnjAcePIZiFTU5KKaau9KwWhV8RkWE9Qx6AiOXeV+wyJkOpbfR0/T1aYtRN3tQ7o4we4r6BQbwYrSq0WAhyexhjraQky84yW5hF674x9IkgOJfK9xVYeiZSVQ2hXfxO9KwOR2OnyZQoBLaSKGe0zwvJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761633; c=relaxed/simple;
	bh=grKYggiaw46ooi6ImNXBLBDIyrYhWxvGg4Dyp8xFWeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRf8HJeLVksf5Qt7D74GXjzrKpfnZbXPpSgoxjSBe1yLQWtTBen6TxZOJH80PZToJyCqYzK7Vktk084QLH6na2nAjsPeD8BGBk/FiM2npQAPt2kYC+aVcgFKvXsIFKFzslesy0dQEalpaNtKs9HKVUM19ZJIxHGJ0TKhe4x8Ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=nNRIas+W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="nNRIas+W"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so3683895f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776761629; x=1777366429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZQQGWWSalMTDcCO8QOolY+y13f7Fz4iaePp1nDET7U=;
        b=nNRIas+WyRz5xVdnv4TMewb5kPfRG7HFGN0l928KNgIoiyPZ6qQzJFIprwiz3kbgia
         xpOxZuCaQQREaTTWcQ8/hxTNI2bPDtBSmp9Y3p+7qO0crWJeoSFLX8tGjGQSE9ZzQGVD
         lt5nnu6HIzJjFY25YSQ1LDR0gZElg+ESLNKw3ZhBq194xhgc7bph3lP3871wpT/kvDvx
         qte4/fZuW8HwI5zbfda0rjDF3pTW2ozqJYC8ODnUMba+95emKprASfFnAqoc4rDWPWjF
         vKa7q3bRRpVlJfvkcR8M9BlDkt0MU5uHkSvyCgdnU5CUkB2jqhmG50hBibiKoqt1JY2b
         iXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761629; x=1777366429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZQQGWWSalMTDcCO8QOolY+y13f7Fz4iaePp1nDET7U=;
        b=c+p6NUB0yNvRurxnLcQ+RmqMRmaNa+OA7zeCpiYWmjfgKJd7/rsfueoB4ZmAi5OQ0h
         hz7wd5WDyh9Pp/bk/9XUXtEX2iEgaryYaZhtnkfTZnr/q5vg5Q60ahkL/InXCdHQRSUk
         TsnIKjCpkNvxN8NhPKCnLyvOIKWyBmnN1h535wtxRP3aSiZfk8Yv9dySY8oFtDecOlBy
         8H7GAB6uFKvkiXNWCQP4/Y+ipO6e3vLKkGw2t9SqztcDykcSjOo13ZL4yI2rWqo6wjCD
         sUR3jatDM37/tWftMFlG6Q+vWQR6eeGOco/PwQQFVOhRV1azwkhOG+FueW/BJjmGph+e
         C+6A==
X-Forwarded-Encrypted: i=1; AFNElJ+W36gTNHNjtQsgu4+6QTm8M2vuhp+LWXgbvMx+QFuk4vf7vY3zt5EZlicWI0w+4Ivn0WvW47gMT5hCnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdbDRt8+CCbS7Io8T6wURhFHmUWAiODgrL/yfOS00MnNtKAw5
	AVYvT+elt7yewBlVYvMlzNKxtksRfTrr6I+jaSWiD0Otwu9SvwBGPOVqF020zwtqPd8=
X-Gm-Gg: AeBDiesELuIK17V4RutXT2JU2jq4RWpftmHNu/iblR7Wl77gcatdTUfPrI0gWKLoOyv
	7Wv+XBa2P8Wfaos1PSof7iegkk+7a+z2Klc5KUpdVqDOcBPNUBVyuNVxqeXYSFaPH+43aOeRW/P
	3JHUvk5mo85AhJf6xo+vZ7ORQwlcEEKRxo7qXqpDGcJ2ITl3RfVCB0gkljKGO3k+1+KuApO7f+U
	ZUFVnrSyT3Wl7EUXhlxtWL+UmViDq/Gid8K8Ij4yDZRBk9mE4ludD/0f7VNax2jaTdTOPiDbTQB
	bzHyn8neCYEPXEdRVDbXSzUMwAcLkcQFTrUaLjMlQrqSTZRCEiHsBx5qLnj1O1yRImyO+h2gY+p
	oKYWWVYLuVzzdTMQln6VS+wPCzPXaz1Xk7jYH3fjhvDnQoY9q499+eTSpPRih6aGFML6TAQaeZZ
	AGEFfc4UB1VOWzNAq2Z6L0n2G/+71Z1hoEH3yi1IvDyBoVeVKQRaZXRZ5WSVsYlAYLZ+2KDcwve
	/WF3GjrXI+dgw/Erooiz8LF4Q==
X-Received: by 2002:a05:6000:4283:b0:43d:73ff:fd59 with SMTP id ffacd0b85a97d-43fe3db9bc9mr26406876f8f.10.1776761628838;
        Tue, 21 Apr 2026 01:53:48 -0700 (PDT)
Received: from localhost (p200300f65f114e0838b25d7f2f2f49cd.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:38b2:5d7f:2f2f:49cd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4ffa8sm35441056f8f.35.2026.04.21.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:53:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:53:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <aec4Ft5HdkW_izjV@monoceros>
References: <20260420175648.1709935-2-u.kleine-koenig@baylibre.com>
 <aeZxWbZJSGHy_C_5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yatlx45kul7vd2ss"
Content-Disposition: inline
In-Reply-To: <aeZxWbZJSGHy_C_5@ashevche-desk.local>


--yatlx45kul7vd2ss
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

Hello Andy,

On Mon, Apr 20, 2026 at 09:32:57PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 20, 2026 at 07:56:48PM +0200, Uwe Kleine-K=F6nig (The Capable=
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
>=20
> Can we rather switch to PCI_DEVICE_DATA() and perhaps you would like to h=
ave
> PCI_DEVICE_SUB_DATA() implemented in the similar way.
>=20
> This will shorten a lot the lines, the
>=20
> 		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
> 			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH=
8_232),
> 		.driver_data =3D pbn_b1_8_1382400,
>=20
> to, for example,
>=20
> 		PCI_DEVICE_SUB_DATA(V3, V960, CONNECT_TECH, BH8_232, pbn_b1_8_1382400),

Not sure I want to open that can. My gut feeling is that it's fine to
group .vendor, .device, .subvendor and .subdevice in a macro as they are
similar in spirit (hardware property, purpose of identifying the device)
but .driver_data doesn't really match that. Also I really like the
explicit mentioning of the member name for driver_data because while I
think the suggested macro name is as good as it can be, in my opinion
the first snippet is easier to grasp for someone who is not deep into
pci and so I consider the additional line space it requires to be well
spend.  Also prepending PCI_VENDOR_ID_ and PCI_VENDOR_ID_ ## vend ## _
is nice to get a more compact representation and enforce consistency,
which is both useful sometimes, it has the disadvantage that I cannot
easily make my editor jump to the definition of PCI_VENDOR_ID_V3_V960.

So in sum, while I see the advantages of your suggestion, I don't want
to make this part of my current quest.

Best regards
Uwe

--yatlx45kul7vd2ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnOxgACgkQj4D7WH0S
/k54egf9EImNUMt+TS3ZLs0wiR5C5S8+0cggUhXKE/krY9bEGzWCKW1DIaSBWxuB
Anjm5m+e6B28DQ0hKzH1c0LLwjqf1bxjkZ8JRpnyDMtBvlFp95vh3Ql1KMDRMTPY
Yl8XPJlrcgvxjIIGNuzI9otTdSYTcSbnt2p7EChRphI1UGH/8deyK2TyIgAUWZXb
OKjxhvQVRSxpVH/XC64vNmY0U/Wt4y1FL50W1IL7vYtishn2XVpM0fwhin/u6juY
TsZ3Y2lesQuRvvBYQQ6bz15CzZ+rBp7Hhkem2HrbH8LtxF6YmLZaZsvUcJhDHjzV
eT8iwLx97TPYHGlLi7Y7KEZ5Ba4M1g==
=b/Rs
-----END PGP SIGNATURE-----

--yatlx45kul7vd2ss--
