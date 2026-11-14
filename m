Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664298;
	b=2q9wWY3kf8zZXv2MGmePgcdVEybC7d/bG2VKqtrsD+7zF1Vp8bDPaV4nFBbQWkBCmRY3
	 vmHFbpwQRCbBeOhg5TMuVGBZS6pGvMNm5eM4/baXj75g3ecQHPM12yWSR9ZJYwsY7m3Om
	 I7IPgHAZ9cVl417uHdV8P5N6o0Pxa5A4NlWprtnHik8ho8RBCHIohKdOLJ9BRy/hzsyaE
	 3WbigwZtPfXkSSRPnFfKMSvFyDgV+buElkxLVrI66SZAK8WqBjEMaY+vNKJqsdVyq2cj1
	 d0VQ4gzsPwErwIYevoo+qWXsyTwTNj76WUTiRoHwxSIlUyiNVJTPbikI1cC+8Cv72Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cmmSd8R6xrU/j0YWUTJQ054gDHQKJhnBUsVp5CY93rI=;
	b=juUaMbFIGCtLPeQJYqhM0k5LBh2sGE1MpZKma9Pa4hxwIVuGXJD7Bzll3Sj19+KIm2OQ
	 LxymqzKEFlckE+Z/IgTy0z/tyxot3lcIhQ3N9dxNNseN9x/JCvTaCQ0fdBWFifLRZ4Mnk
	 LvzzvqVPFUKdmFBFneY2qGRO2tNV0MFsgpqLkh/im5u6SoMk77+FQkl3DC7JzV4Jwba2D
	 /4qh2p12xC1Qx52GfmYUhFU81cllmlJbPBUSUSZNASCV/Cl/tg0DJ9dwl88aDLWLhFWR5
	 IgUd3mwDqj7ImF0COUyS7wjQ0mbZk7Q+vt1hjXtobwFuOj/rrCCOIGRBBFiKOVRtIMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGRXkxqh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E86606A327
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGRXkxqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56D1F000C4;
	Sat, 14 Nov 2026 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664297;
	bh=cmmSd8R6xrU/j0YWUTJQ054gDHQKJhnBUsVp5CY93rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGRXkxqhYoDYvGQ3OGka7P3CnvI66nQF/2rBYl6Hb+HiZ/+eS2UNX49+fUlvaQ5RW
	 L0CnwVVRLPfREUCoYI2Gb2H7IM6Pl+4wBl1/ppCbaauslkYf6/8rIcwY72nrS/gcGT
	 9Du44KBu8jRrPimPuO4NRIJMutkBjqwJGANGR6YftJ1uSpV6NMdD6z9vMw/q4biT48
	 kiACIMmg4u6CIUfQzxxPgowmn2UENapagf/lxmqGxNIk4xRW4pCoYauiABnKr/2K6d
	 WKIZ4Gj0og3OZan1vW7QkEs1K5x6dnZK7XadDddlCr77XJPA2xaB/NNbBv625whkjs
	 p0DJybzqc4KkQ==
Message-ID: <sashiko-outbox-214594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] ARM: goldengate: Add support for the CS75xx
 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-4-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-4-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:51:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

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
> to that revision and can be enabled on a multiplatform kernel. The PL310
> is r3p1-50rel0 (CACHE_ID 0x410000c7), select the workaround for its
> erratum 769419 as well.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D4

