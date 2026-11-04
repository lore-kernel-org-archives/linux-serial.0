Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804119;
	b=Hxeype6LpRBhs7OlYyVIDxn5lOPLJxQFKw4Y3+ClMV9dz9z3Tnm623hiq6IwhbrHUWzz
	 C1WYftkgM9sFqWlcSJ/XM8ammL/6pmbp2EFEdBaNZz515f1ITk/9x0ileQVSIWDBoVQDW
	 P6olvg+IIiSVxMcylr8CxREUivaWar2MGWmLAAQY3JF+rwWBYPKiuX2X0RP1dHIAiK/Rn
	 wZ79RXOYVCfLQAknIa60013zk+Oo1mUe9qYhHPec07MwyoW4X51bNeyBI1HgohJOYV8nT
	 17KaKJRz8mvPv145T3FCwSN+AMyvIy1lTQ4rTGJGIyckGWRBsXDATwUEYCKA/uq0aDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eiQ6GfPImTIjJhLUKvSvH008Lpm0EY8iOrlAuv4hxZ4=;
	b=k40GRZCLZecGIzi8H5ZspE4p1uhMTBP5+gBy5UMEuOsWhy2NQY5QRxA9iYoQSYocRH/c
	 9TkQrpJ1x5ulpY5+VMfzrtI84KwOl+0fG3WweHXbVtxAU7tDX1StZNKhTnLFZKqbozk/z
	 kMYqYj8DOV77m3OpBGLqYDUB8MEKClztgqCtwD1bVGS0YiYPnoydABrj5bXJB7mjqJmyQ
	 nqWvTXu7fExxzvJoh75KYAXkK1xpDZQLFM1HzfI6phaN+IiAtGKGEz/JNmQDu+RS6RNaM
	 +QY8TCT9rnQ0M6X1cRRzYlJDDE1pMMZ9tFBhk6wuB/lGO05lmeGiYIaf4fVBs1WW9+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8viVX1k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81436606A326
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8viVX1k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D661F000C1;
	Wed,  4 Nov 2026 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804119;
	bh=eiQ6GfPImTIjJhLUKvSvH008Lpm0EY8iOrlAuv4hxZ4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m8viVX1kUmqzdrIGMD51btHIpxYTCSOmcJUw+FD/+tgv9KE8s18zyFkJLn65oXQwz
	 mUJVweeyonCgmyjIBdmyBJ2HjPT5LMAlLeav5HjPm/sYBOjBBdYDkBbU5suOm9TqEO
	 AZxCemOmzlssmACA7WEn5v8wbB+dXkkTccYkK6tMB/oEqstqIHRjaI70GtKrzLiFCn
	 4IBt3a5BH+we+x2fQoosyqooq1PUt5uwFlcWno7nxcr/AtRDXinGnBGsWX3D+E5ZHO
	 5VzqdkE3av9FL7h245JH75XFYIlnqGLcR+qi7vdsAwOawnQqdBBtqGb1D1sEZHPGWd
	 NguYbuANbTgVw==
Message-ID: <sashiko-outbox-197472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tty: serial: pch_uart: replace chan->device->dev
 with dmaengine_get_provider_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlRUWSBMQVlFUiBBTkQgU0VS?=
 =?utf-8?b?SUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:55:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
>=20
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104145211.3209=
669-1-Frank.Li@oss.nxp.com?part=3D1

