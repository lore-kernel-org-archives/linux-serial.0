Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E3418A22
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863800; cv=none; b=R5Huy8Dl0xezwYZ/D4UDyiNtU36WpknAh1utstWs65bLVYNTDmorq3EsHc1Y0r2UY1p+eTis+DEg7kK3m5M7UXUiVZa7cR90YZR0G3gZDPNYF+pRxt6ovailOC3B+ADZpJl7f8iIbKQTf+SolnMekMoC9W9nieRoJ+v2KhTDJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863800; c=relaxed/simple;
	bh=mA65tY8eAKw2KOPfypTV+1mlZct0YhPixfQpuLO2H1c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RzyscMPx9R8PR6+iaPemzupsEhKp73iOEmB84gBa0kFr0Fc7R8Yz0/QPPdrnuI7/jhOTz61xK3bOKZ6IOlh54A1s3H0nPrkoaJd3HOAUKkNoIk3TKy2c9In7P6C295YaJJEC2hw51hLcup0zeW3FT4YVhzKUHmo4twFRaDN2FXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1UZkuXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1UZkuXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E221F000FF;
	Tue, 13 Oct 2026 03:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863799;
	bh=mA65tY8eAKw2KOPfypTV+1mlZct0YhPixfQpuLO2H1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1UZkuXCvSA7XKcbTYhW9DWUcsSXzXqyyw9e5dMfa4crtVyg7M/Tqq8/z4tvdTAhZ
	 7CQ94RIx6+oYoVMvH00pXMuf1u5jBX3ggWGSlLXQEaLPsi/QofUtZN6uqrm2oA0PS1
	 1DBXZDKzHz/YwqajZV+OJlPTLGIj4G2JlOfvAiczAjkEAMVpUmVg5iSEYGnfpwickD
	 N1e/SwRrr/WgC5kcdATyXw45cp0htas15t+CBja1CisQ37yfAcOa7iLb7iI057Q2cQ
	 BPKbsINr+fsQasUugLlMjiXuGHnDsDixbrvv5rsJ2fWWgUxaewE3hKU1wAO6a5gFE7
	 LzmoKWO74GX+w==
Message-ID: <sashiko-outbox-168939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] ARM: goldengate: Add support for the CS75xx
 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-4-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-4-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:56:39 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> The Cortina Systems CS75xx ("Goldengate G2") are network processors
> with two Cortex-A9 cores, an SCU, GIC, the Cortex-A9 global and private
> timers and a PL310 L2 cache controller. The family includes at least
> the CS7522 and the CS7542; the CS7542 is used, among others, in the
> Securifi Almond+ router.
>=20
> Apart from the vendor this has little in common with the Cortina
> Systems Gemini (SL3516/CS3516) supported by mach-gemini: Gemini is a
> single ARMv4 FA526 with Faraday peripherals (FTINTC010, FTTMR010,
> FTGPIO010, a 16550 UART) built for ARCH_MULTI_V4, while the CS75xx is
> an ARMv7 MPCore whose UART, GPIO, interrupt controller and NAND
> controller are different blocks. It therefore gets its own directory,
> named after the Goldengate codename like in the vendor kernel. The
> [ ... ]
> is r3p1-50rel0 (CACHE_ID 0x410000c7), select the workaround for its
> erratum 769419 as well.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D4

