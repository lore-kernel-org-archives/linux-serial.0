Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698705;
	b=NpNAQ6/rpVz5UpvYYBy10nLKR5fdClZbTN27ve859D8cbtaa0XjjnnUzKeJJelC8jIaN
	 30CIA45qiPPH25OcVnbkX8UYyFN5ZrHNJbZ0H+Fb7rOD4hPiTazBYn4b7J6OJ8aRmU1wv
	 r3QULc0JF3lFACBhB//NNzHQenlki/ytqVMGxMUBPIJtzvjm0mQ6IKZPgC0peLBP45AIO
	 q/dtmwLTh1k1qJv3JYeM92okYo3KwKPbhLCvA+zA6cocpNNhOV8OFIOHUUIc1HjCOGDgC
	 +I4iZJKEfq96nGYF/kbEiQT6U6zeAXNYAm1jAEqr0ei0e1gNMR80G71esmb/5lwDz+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T13Nx8LcVpu50QlHzffixkBIfpgho0fI96sGkhnOdIs=;
	b=Sw2SmR9rUzcCLiCLzeLYA2QqjIH4fBhYM5FeHXPdFQz7eat308L7f28SqYzPZXR0cFDX
	 nqeyoFExYcadXx7BaU3Z8i9W+n0HM67XMWkwyiw7UFiIppQCqKgEG2mRp3+U7wOMQ9/Y0
	 01KYl4tddsVsXFymuZOajq4Wedi4rA3kS1gHhvUFdvR/IhB8ASe0zlBA2DyiPj6mdfcv8
	 qHbBc4a2oS+JRMRi8ATkZgFECmGM93oizTwiDtMK0U5s7dE4H51AD5sefvdsJkt1M7P4T
	 ceXiI4tntu+dHqq5v3NI+hy9pCJKDt+63y4BGhg3kRsHRkmVoHcqd0DIzoWzfajHT3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CMoq3m+/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13097606A32E
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMoq3m+/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53271F000C5;
	Sat, 14 Nov 2026 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698704;
	bh=T13Nx8LcVpu50QlHzffixkBIfpgho0fI96sGkhnOdIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMoq3m+/uQbIarrwSskWyzZu220tP2Yf0X3FOGUVPkL1Meoyfq4IEKVNfyY8I3uwm
	 ITlzWx8JSzWRdOkXgsGlMy1CGU9EC/H4RK8cZvz0K5Lh46PoqsraabA5geQzaaMcGk
	 VXGGmKTRNRDKMwlF26DoplKyS2dlQfeL4UneRzUol4IXazT1boTPJ1Ams+OLs8Ok1H
	 ru/45mRRVbiD1pT2pI7AG0XqVO80D9MEZMUwO3bb0VKMLCs+KVhi4zabSL8lz0Y2Uo
	 lFG9aI9WQFLyqL2g6yZ2AGBOsb+JfzwdeW2Gw/YXzG93zztbn/9n7v1Mk/cVvVB9dY
	 DDbqCkcNutaYg==
Message-ID: <sashiko-outbox-215108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] HID: ft260: add GPIO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-4-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-4-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:25:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add gpiochip support for the FT260 multifunctional pins, including
> GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
> available GPIOs according to the active UART mode.
>=20
> This supersedes the earlier pre-UART GPIO series:
> https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@gmail=
.com/
>=20
> The change of the gpio_chip.set callback to return int, as the current
> gpiolib API requires, is based on a patch by Rio Liu <rio@r26.me>.
>=20
> A pin set or direction change reads the FT260_GPIO report from the
> chip, changes the bits of that one pin and writes the report back. The
> other pins keep the state that the chip has, not a cached copy that
> can be zero. A change to output writes the direction and the value in
> the same report, and the error of a failed write goes back to gpiolib.
> [ ... ]
> The gpiochip is not devm: ft260_remove() frees dev before the devm
> actions run, so it removes the chip itself before it stops the HID
> device.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D3

