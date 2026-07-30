Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A7381AE0
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441426; cv=none; b=rCwjra0UDpd8sVEOH/D+0tBO1+Ase7xxvBcnhol4XDuhapEoDHgnvRdtRahRHgHMmqLzgxortPYuBMDTt4vnnfZl2GjWrTNETtpl7Jk4ABqcyj2RH5qqgSMxliezofZuHLzQ3F9rFKJRpAAhapUfVHkQ3RGc0JHu46p4/xEB1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441426; c=relaxed/simple;
	bh=5pjwylgUPG1ddiNDqMWkVVOaSdmxfjYRjTkVlzwlr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsDY4v2Dy1rk7i79jVPfXOXcjav6eDbzk1e4ZynwSNPJyEAv4wm1nCUkW8MDLkVt21NOZf/ysVrNwiJ2cmPWz8KvoYllnUvH2bFZhoMwSSPty9pnAGWd+N9HbdrW+Gx0DZzQj7S8P5s/nF73aBWAwybLvA3gqNeh3rCb9jnw338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oAsHhKkQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oAsHhKkQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso1065655e9.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785441423; x=1786046223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pjwylgUPG1ddiNDqMWkVVOaSdmxfjYRjTkVlzwlr2I=;
        b=oAsHhKkQMfj0nozwJToDDehLOzAObAe4opbZPEF07R8h/jmPJ7rRIBLpL2e1DC38+u
         c1MhOB5PAI/h/zqGQ5D7+EwHxVIBtLU/roO4KqOWboac0tVqDPcUc+KwPMl0IiXiU5fQ
         ZRHG+cRRSlV48zb2nXsJogsBRB5RWjsVZvIyuR+VS1iMbhdfTnldQhIGxMXMJKvlCYhY
         dO4yL/6c5SYbErvER1Gs0Lgj2Tq/VuyFyD3Tr4eV56Avp+0/dDovzn3ItGW5m3HZpKpn
         5ZUPvCzgYXVLaHdO0BnkccXWo5SmvVvZHzpNvpBjEU5AVlR21SW2y8mOQZlW9t9EG7Fw
         QZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441423; x=1786046223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pjwylgUPG1ddiNDqMWkVVOaSdmxfjYRjTkVlzwlr2I=;
        b=O9m5huoPXLxGpZgre7u8ns9uZJ7YwcwPGuTCAkWZsa4m7rGSpAapR0VQPAgcnkjZVi
         OD2PQN+F04uITNg+6LG/lxEN8gl4/0WFC9U6dT7zES1l/lwK6+gPRN8R0QRDERQ8BbCN
         eewljAhuBawtqN0Nd92Lg01M8oVyxbOTbI2st/Z9Ax0x1cqY2C58Dpg1EFGvGt3V4bqS
         GsUU1sCmdCed97MHBC8pKfqolybYS+JWc2ktiR9Y7wrb1usw2ZUCpp/TZJ3FTsw17miv
         fEmnX42SEck4M+VflHvtr3ekYzqHXvlskGhzf5CC7yECJtoz4XhykfafrYpE04ar0V7n
         PLWw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5LWNP09FuR14ovNubewJWIFBok3u9pa83qXlRbR98+x7mM++MNnbLlw4X+TEYHqZgKvKY+Gf8hutSrzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9azKzt3p4almkUeI5dlaR5SN0tdGdl2s/FGzVygyd8MXXNQ1
	JkcIoKYaQAHwOMVYAn+nX4h78SZjwsRc2a64AeJA/jtlLxO/qx4wesqPAJqYXgPkuMU=
X-Gm-Gg: AR+sD10ptgdBjTCyeOCVOVVpvyYk7G8LezsqmMf49YcAXNoOMiUqzNxs/Ac+Sn7fd+a
	K43hs0os/X9IOIc9jnArMmIfKg2lK/P0OMZ3KXTDUGAj6ww0BFYKIluCDjxlPMRZulJoaToPWfG
	wrlYlfJ6lRn+Z4D81O/kpp2ktUEl7XJVrmIyZQlBtJhvt+TrHiXNXy16l2fEwpaSn4DLRxy7ayk
	+TlWv4mQOe9qD09WDCxToyjZPUYDWOEsiXy81JeKsYsun7qohIMrLSsowJYU3Gh8E7PLB+XogjJ
	R8s5MDKLZ+Pt9sXlOGB4ACRbt5TEzKaXI8zaYnJgdpkBOFWuidEQlPz/IGl8UdFmapLD94I1U39
	Z03jPUM5iSJgfosKyyLj/s5ldB66Z5renCD2kb8/Bp9fuZWBEcxyuh4Gj7YUGIIsV1F+wOLB4vT
	GtCFytWlUPsIMRFKjmAvxWGiCb82rd9Wo5sSYH4ASUgTi6FjNC1YiyEPsL0MdxiDd5Jw==
X-Received: by 2002:a05:600c:6298:b0:495:64c7:804f with SMTP id 5b1f17b1804b1-49800ea1ea9mr56132035e9.23.1785441423688;
        Thu, 30 Jul 2026 12:57:03 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4980120ba7fsm86961305e9.11.2026.07.30.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:57:02 -0700 (PDT)
Date: Thu, 30 Jul 2026 21:57:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <amusQjI0DOPzL4jM@monoceros>
References: <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
 <al6PfMCuRiYcOBQV@monoceros>
 <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
 <amGYgUhPrSdR5srV@monoceros>
 <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
 <amMZoJ41FKcd2ddG@monoceros>
 <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
 <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
 <amn8Hb2dbv_Sah_Y@monoceros>
 <2026073028-anointer-unlinked-c0ea@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rftteozv3p3yh4rc"
Content-Disposition: inline
In-Reply-To: <2026073028-anointer-unlinked-c0ea@gregkh>


--rftteozv3p3yh4rc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
MIME-Version: 1.0

Hello Hugo,

On Thu, Jul 30, 2026 at 04:49:45PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 29, 2026 at 03:30:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > I think the real fix would be to just copy uart_match_port() into the
> > two drivers that actually use it (and remove the then dead code paths).
> > Then it would be drivers/tty/serial/8250/8250_core.c using
> > hub6_match_port() only and that can be handled by a proper dependency.
>=20
> I'm totally confused, so I'll drop this patch from my review queue and
> wait for you all to figure it out :)

Does my suggestion make sense for you? Do you intend to work on this to
unconfuse Greg?

Best regards
Uwe

--rftteozv3p3yh4rc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmprrIoACgkQj4D7WH0S
/k4lAQf/WVX/WIN4b+WCVtKUAw3N9m/XRolz3JDLMsiqNA8R+Z207MWDCfOjFXgM
Me+MfN6kKvfKnbhBKlJtGCyQ6w5C7b0CjVcZ7ua63MCkH2JAGvMQ+34ZfARQt1j/
yqsy8yOdTOlq0SIzuouBg2wvM3nQ8dN07g4SMsYyZ0SBoKBM9boTTq2unz+ZGdzp
6rL4C6bocj7iQ0Oo7R3hGwoYmotpU79hOtRLyLlXfyYnbz5iMEK0nl6RounBqvgx
YmJgbV8Oi8c84+Jy18lEMSNSTJqfdjop5ZFpCk0oIW+tkWSvuNpR0DzgiEb7CHvV
SgubOmsnWNCWyZLhvgsjoelArW1Hkw==
=giPV
-----END PGP SIGNATURE-----

--rftteozv3p3yh4rc--
