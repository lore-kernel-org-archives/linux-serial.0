Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597286;
	b=f4Q6oWlJPyTKGgZ1iqo2o+c0jEDsLEyOO57G+6Ii5uPH/ABDTTjC/WvZCN52RyotRVcb
	 77WPNc7jvrdYuOboZrfVKzil/q/ay4CZ7IpzAMdnpNuLsPdhoZvfDFSai9luD1sPhm9Ru
	 7D2QtyZpZOHGB58hfc1njDmQhFDeh8ODW+tqgt2Be1pMyTU0vkCKu4HDqgpLoBlosKp36
	 0KX8LlSDbivT+5e2p7LY+Y1y+wgMHPNOUYg5FOgN8TZx70zb+hsc96oLTjq4Pr+eGHTH3
	 f62FIX8tG3dIDBIrYrrpne1I2qMKmqoUeXSiJf6wnw3Ww0o+FneKZXGU86cR54ESdNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pucBDJoKBWeAW6ooQ9Aw2OmiGNlocqa34ADvH1oSYL4=;
	b=n5OwpDu6tPGxs/aCJGBodJkHCrWz8GwQHvBQmI/gQtMBSotrsaaYgK35oGCgnG2vkhQi
	 nAnET6EdYyKL76sQl4LiPb9h7T+s9Se7nqRL2CKWFLNcE5UeQwITefzUa2Kb9Xihoi1xU
	 oQWt+dkQFnDCLi0O7zpeJtjlHVfbBaFDd0I9bHToy2Vb4zd+6miY4MTT7+F8exgGVn0k6
	 VgVvn8rYitx1TGYIM3eJb6ZB8yb3FksHYbUndzQJVS82ptHbEzyJUFyEGcGfeItoZ04ci
	 jMBkqP+jkZnf/xaf5JE2PB0ZNZIAlMVh3GdA5YlSKOCXPRyqlGDJL/50Gi8R4SqDUvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwRaXNvv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45A606A337
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwRaXNvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A968B1F000C5;
	Fri, 13 Nov 2026 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597285;
	bh=pucBDJoKBWeAW6ooQ9Aw2OmiGNlocqa34ADvH1oSYL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HwRaXNvvkB2l2ngvQNhFU3kL0tTJ29+L5mV0ehyUGxo7iZIdIjxRf2drA31HJXXxg
	 GTq0vCpciJpqIPWeXwbrNffwk+3wEBS8I9dleUg1Aun/fU72hVJHXp7HRHp9y4y8+O
	 6hVUqGpOSuNuFWG4pZkQbEIGKS5l13jh/pqYkAbMUtAAs4ccBO/AvLTjiVP0qqfkyD
	 F3wKWkDluErordBNhhnYBpiJ7jkyy7YO+U5YTCvaosF2bRAFGDTy8QXKMYOv5ge+Nk
	 8Jd+gUV6diR2ih+BkLtSU5X+CJ4qAVsDalhjwaWy3abb6LT47u4GtSKENuRI6yQ0Qa
	 XVmFNIHBcx3UA==
Message-ID: <sashiko-outbox-213529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] arm64: dts: mediatek: Add MT6895 pinmux macro
 header file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-7-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-7-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:14:45 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the pinmux macro header for the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. It defines the PINMUX_GPIOx__FUNC_* macros used to
> select the function of each pin in the device trees.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D7

