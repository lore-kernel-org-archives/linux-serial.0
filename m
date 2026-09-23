Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777A13D53C;
	Wed, 23 Sep 2026 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146636; cv=none; b=etsuM0vxZrPBt4rot3QEoxYlo+yJ7Om8b7AI0SmkB3r4WxiVnD5vW3jJIZWljk//n0XIbg9eVFCtslHOnWJzGsEA+IePElnxsWxACs4Xwne4tCshpwYo0xVZby97ozCCLFlVmRGZzW2kL2XYkL27WSnnllqtz02q/V1nL1CfBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146636; c=relaxed/simple;
	bh=Aplh7dJTViOVzCjHVkbCEOKv4UcGtIR4VW/U3iKThjc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=eaG+8aIRRh23YnAg9FKiCIlgvLoHZ/orKZBCRfVkHWtYx6ZeYoiaNTdHHV92SorEJFb66fA9naBjFyMM/d4dnjcGy+el78SeIuBfdO9s40l8TLcD1RUKD850JDToFJEg66xIj5ckbG24y/qDVkNl9nZp+qaCV6NutyeH9uIHobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=a6C66Cms; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="a6C66Cms"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id DEC2A5D;
	Wed, 23 Sep 2026 08:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1790146623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aplh7dJTViOVzCjHVkbCEOKv4UcGtIR4VW/U3iKThjc=;
	b=a6C66CmseqidgmeBJlOBRw5wwOqfckQBCRM2EHmuSQ/tjDoUJVjdWa2uhEz2Q4mmrOA7RK
	BW6A+P9gGreJnsPw8EJSE+Bqvzjxyapc7ICNjHyyCA535LH730HY9e4T1hykVEOAnUDvHi
	i4VLXnxOHEFFImpmkRqu7Jkw5ng5DJuhnexpycD1ULRnQBacxQqEynR+TLkDGa6vHFGwmU
	36QfKryCCcIFwMv0FEcfsONjPbdAJ/nsz0Qsa3cTN5p79f7hbbHPOwWdeQey9efHdNRoeu
	hVrtQ/uGMgF7JMEFmmVoXg2Xl5QJ2K8bOjKFcmsFX28SrKZS27zNsozce6Kigg==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=66e4aab55ce6c10e65aac407de2f18ed76c4de06773e522fce8193b51364;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 23 Sep 2026 08:57:00 +0200
Message-Id: <DLMI0KJW4743.2J11ZTFS2FUH0@walle.cc>
From: "Michael Walle" <michael@walle.cc>
To: "zl020895" <zl020895@163.com>
Subject: Re: [PATCH v7 09/15] gpiolib: regmap: add gpio_regmap_get_chip()
Cc: <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, <soc@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Lee Jones"
 <lee@kernel.org>, <mfd@lists.linux.dev>, <devicetree@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
 <DLL08SC6PWNS.2BUBIQYMBWIKQ@walle.cc>
 <650e4694.3f81.1a0c7598840.Coremail.zl020895@163.com>
In-Reply-To: <650e4694.3f81.1a0c7598840.Coremail.zl020895@163.com>

--66e4aab55ce6c10e65aac407de2f18ed76c4de06773e522fce8193b51364
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Sep 22, 2026 at 6:22 AM CEST, zl020895 wrote:
> gpio-regmap can already attach a domain via config.irq_domain or
> regmap_irq_chip. PL061 cannot use regmap-irq: type is programmed in
> IS/IBE/IEV (including both-edge) and the parent IRQ is an AMBA chained
> demux.
>
> In v8 the custom linear domain used the gpio_chip as host_data, and
> that chip only exists after gpio_regmap_register(), so I added
> gpio_regmap_get_chip().
>
> I can drop the helper: create the domain with the PL061 private data as
> host_data, pass it in config.irq_domain, and let gpio-regmap register
> it. I will do that in the next revision if you agree.

Yes please. You shouldn't need any of gpio_chip members.

-michael

> At 2026-09-21 20:48:44, "Michael Walle" <michael@walle.cc> wrote:
>>On Tue Sep 15, 2026 at 1:15 PM CEST, Long Zhao via B4 Relay wrote:
>>> From: Long Zhao <longzhao@ambarella.com>
>>>
>>> Let drivers that implement a custom irqchip retrieve the gpio_chip
>>> after registration. Attach a caller-provided irq_domain only when it
>>> is present.
>>
>>So why do we need this? Why can't gpio-regmap register the
>>irq_domain?
>>
>>-michael


--66e4aab55ce6c10e65aac407de2f18ed76c4de06773e522fce8193b51364
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCarN4PREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+EqJAYCURfSHF28/wy7zcS9T5rqwQKdtr6Vi+fm6
FKEPiUj0ESQUaJWITdtLmMhXUYTwU4sBgKrlZbW1f9Nl/NmxVqpSp5Yv9aq5pAEe
oRACiSMyH2ZwhTvQKxQkjpEcDZZyx4q0Fw==
=oMt8
-----END PGP SIGNATURE-----

--66e4aab55ce6c10e65aac407de2f18ed76c4de06773e522fce8193b51364--
