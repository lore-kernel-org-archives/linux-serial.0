Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB084A50;
	Fri, 16 Aug 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790777; cv=none; b=eUFcrvnJsBvnJI67lKFt6R+Nf7EjswFC66RyGo4zkh4Nh/5AmgDFfCpsbJCFu6v2Nx/WFXgrAsCE+yJdeAhWISiPmOJyjB/5C9iZbN0E6uqXDUZY6q6tAKNQqMreKAXA4/fxdUJY3Y2s1wMudo4fkqm2fM/ddo7T36QYjRA7uGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790777; c=relaxed/simple;
	bh=To4DwKZdAd1zrbvpD+Ji8ozx8eGEkCykPZqh6w3t1TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izmvq07hGGuaw41t7O7Q9TKHpmB1PqlszSK9IArGk7wRZGyOlkYbjs+J0Iulf8eGdVrJMnxEnCyodbrnPRnYavR3GCuCRQ67g/3CwfS5Zyf/84HxFmoTb8JanqU/TiaPOi7LFCuxWwPLeCr01c/YrdtC2d0+YN1/b5FIyhIUJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cK+AVozh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cK+AVozh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=To4DwKZdAd1zrbvpD+Ji8ozx8eGEkCykPZqh6w3t1TM=; b=cK+AVozhS2b0KOClwOoGUpumHo
	mMnwTsLmwvQ6KswCL88xMi32RjDFQi632p0h8Rq88UG20IPm24SPs29cgn/II3OLzUUv+X5VL1XOT
	2bfxW6oKfkh9Cn5xSjNOOaDrh4NI3b3miJJKfDbRKNJSOQKR+7NohcOtsxOuhqe+wykMr4ilWLKAq
	UN7ITgsR+iFNbOkGOpRMSPQunkkR7cbKYKws2rhodnxNJCGIRRJ9bl1JyW032Uu8yckgvVgKnTKU+
	8uzasY3WO7ODR4N8ogw0gtpREabJav8/aKjf1F1dFLqcK/WstA2kF870ydhTl5fgjxjfA+9VPCxc6
	uIDz/+Bg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seqig-0006nr-A2; Fri, 16 Aug 2024 08:45:54 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
 Ondrej Jirman <megi@xff.cz>, Yao Zi <ziyao@disroot.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Fri, 16 Aug 2024 08:45:53 +0200
Message-ID: <22683755.GTVRSBfYgM@diego>
In-Reply-To: <Zr7z-SOFIgcuplq-@ziyaolaptop.my.domain>
References:
 <20240814155014.18097-1-ziyao@disroot.org> <10324095.IZOipudI63@diego>
 <Zr7z-SOFIgcuplq-@ziyaolaptop.my.domain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 16. August 2024, 08:39:38 CEST schrieb Yao Zi:
> On Thu, Aug 15, 2024 at 06:43:20PM +0200, Heiko St=FCbner wrote:
> > Hi,
> >=20
> > Am Mittwoch, 14. August 2024, 17:50:13 CEST schrieb Yao Zi:
> > > This initial device tree describes CPU, interrupts and UART on the ch=
ip
> > > and is able to boot into basic kernel with only UART. Cache informati=
on
> > > is omitted for now as there is no precise documentation. Support for
> > > other features will be added later.
> > >=20
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> >=20
> > not sure if you have seen Krzysztof's comment yesterday, that he found
> > the soc node getting documented in 2019 [0].
>=20
> Oops, I don't read that before sending the series.

no worries, I think both mails (the linked on and your v3) happened at=20
nearly the same time on wednesday.


> > I guess that counts as a strong suggestion. Not sure how you're feeling
> > about that, but I guess we could move to that scheme for new socs.
> >=20
> > So would you be willing to move the mmio-devices to a soc node?
> > (stuff with mmio addresses in the node name)
>=20
> I'm willing to, there will be patch v4.

thanks a lot :-)

Heiko


