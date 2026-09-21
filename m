Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186CF49A3C3;
	Mon, 21 Sep 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994933; cv=none; b=OjrNbnNVO3cXvbNheACRpZ1Z9M+MitAdf7gYP1yVpRaOEdHVosU8uDPzcAedThRbyel/ztRI6aEI55Nnc4rYKGleBHS1cXPDgBtlDhLsCfz3E5I/9kYZK2e2iNowE2GMGH34KgH2Ir1PVL/di3VlIPH8ccmy+pHPj/yyaPuNBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994933; c=relaxed/simple;
	bh=8oYAGsVvEhdzXCWG+jA1/MT2C7mPbAr8X9h6EIfIhiA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=S4GOBmUkpHb9RiNzMrmXIykO0xqBpWDoD0ejbcXTo5hhAJv2nvxACemihFf2QWsi9hQCziNb8q9ADLqavU3kurm0mcWHEdwyB1hFCyTWyVhaYEWJK2BWt87lleAwTxKFC6NzC57h+wzxR4lgq2khfM/hv6ocTsThmcC7j94EX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=HMNcECOF; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="HMNcECOF"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0FDAD5C;
	Mon, 21 Sep 2026 14:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1789994927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oYAGsVvEhdzXCWG+jA1/MT2C7mPbAr8X9h6EIfIhiA=;
	b=HMNcECOFvWrzAxv7X6rh6ufMZzeR20RIFNOZLJPrJoTwjVmGqMgRjQhC8o3iWXnsMrK3go
	snIUKwUa8cCa6Qs1+nOuaHbEAtgEGa4E6KiJyMQGCnZllwH26bM3dbh16VOcVhJzwN7rLQ
	bpJ3pFruahOgtooN+AKT/f14q2LOyGObddcToHTinFpWEuwJfvTHByrSWU/W9LXps+Lt4y
	1FEtrgXQZYf3eAQ21ST63nOtDZ81TivcweH/LVk/lkZPNqQuylwn+h/8If71DMM3sWkpVT
	RWhNknTq27bzWl/SyXdCXMxqP4MZmopKytnGg0x+O6PoMmsrTHqwHwIP0yvY+w==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=dc334a3fcc535e0315e8224ae25d35c7ceb07b6cf064276ea636de9843ad;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 21 Sep 2026 14:48:44 +0200
Message-Id: <DLL08SC6PWNS.2BUBIQYMBWIKQ@walle.cc>
Subject: Re: [PATCH v7 09/15] gpiolib: regmap: add gpio_regmap_get_chip()
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Jerome Brunet" <jbrunet@baylibre.com>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Long Zhao"
 <zl020895@163.com>, "Lee Jones" <lee@kernel.org>, <mfd@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, <soc@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>

--dc334a3fcc535e0315e8224ae25d35c7ceb07b6cf064276ea636de9843ad
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 15, 2026 at 1:15 PM CEST, Long Zhao via B4 Relay wrote:
> From: Long Zhao <longzhao@ambarella.com>
>
> Let drivers that implement a custom irqchip retrieve the gpio_chip
> after registration. Attach a caller-provided irq_domain only when it
> is present.

So why do we need this? Why can't gpio-regmap register the
irq_domain?

-michael

--dc334a3fcc535e0315e8224ae25d35c7ceb07b6cf064276ea636de9843ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCarEnrREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+LpuAYDE0AkurPddl0z6QE+hTeG4NZcB/7h42HL0
OIorjxt6Yf4Z474zjfRls7Q8TEb5PWABgPO0XMEiJFECr8eYcTJCzY4GwwWiB1JR
x0gMJHh8+WSi92hntm19knMXwoCPPyL1+A==
=LBa0
-----END PGP SIGNATURE-----

--dc334a3fcc535e0315e8224ae25d35c7ceb07b6cf064276ea636de9843ad--
