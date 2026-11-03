Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704844;
	b=4EZa6qLC/dxAkSv0zPaUbbU77kdmIzKG4WkApKVBht6nceErSud8zbkhAdb4Sar6eU06
	 OuvniMeEvKE387ifYalox4+wHy01qFL4a0TxUgbg0Dow+VIqcofEML8jumZ6SsiFeToi1
	 aRSww4aIkEolCO9/ypu9iieQYXJYeK+xHkLg2C5MMBAK+lyT0TldN6F6eyOgIoVso9LRG
	 fJLoPJC4MS992RewI42TXPmgpMTuH/dONeL0yeVJws8/k3IHdzdaRFI9how1MZLkcuLw2
	 2II14gMahw5QJNkYIOgNr8fSvKHmn0LebSHxmvspGikfzUVuW325N7SY1vXMdOPL0hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mHQP3ZtwzxgxjyNkEbjqKlCBNGSJHtSkyDN5sFqhGg4=;
	b=Y2DffvYDeoVhMPz9ONPSDF6qL//mSBO5hH0j0TeYg19pbleKVOROFjddxbRP4+TMYhw/
	 liXyX4iuNDI+fCnmvIdjGGLeJ9zZVJ2WpjRZUJnIZLLAtcJHuosI+cyFlMI+yWwT8Rbuy
	 3YBtFxYd2dKqHjlcxBff/0FFKK2n52nt56UBqDWWE89rIR8VjTFtoXaD65oVEz/BdAFjQ
	 37w3vSpi4eAyctx78Hk6bv+YHpopmJQ0PGbMl3p2PDIFDNRuXeidI1Pjusa9ziKc7Q4RY
	 q+v0MHGxlY7sSfCYxOTiKza8mXK61BNjrKqPpKjiC9+QyUqnpi/rKtlDXFVMnVYW+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VifBQzpK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD0606A33E
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VifBQzpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CED1F00919;
	Tue,  3 Nov 2026 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704843;
	bh=mHQP3ZtwzxgxjyNkEbjqKlCBNGSJHtSkyDN5sFqhGg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VifBQzpKkosfC5I+TQ3iBEMDBIt+GSq+0EFsyMmUIP9MmNHT6Y1Fc9VANNvQBBHTR
	 OeerDI8g+TxagXPHajyj7VlFZx91LgxcZnTQ44ky0nPkQqzyf7/JFzCeNY4+yRW2DS
	 RGNeiEAw5EZ6bbvgAQ2ZF9x7LAKhu5xsUmsRxX9vFafbzVMJzNZsa4SzV5GSCQZ1f1
	 WidLz51XNyzeQSxlCdM2CDMyM7sd/1192T3do13uGg50k5v2wI791Y+iFHLZddTv4y
	 p7tMYzLHKuvzzoez/8xZHSFoBkLB6dVCVshLYADG7s+n28dB2ypFnbWfT3TH6nnWlU
	 QOt62frJmTbMw==
Message-ID: <sashiko-outbox-195139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_exar: check priv->gpio properly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <28c09cf858795491f66667781bf79fb6a603f159.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
 <28c09cf858795491f66667781bf79fb6a603f159.1793704520.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:20:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> priv->gpio is set by platform_device_register_full(), which returns
> error-encoded pointers on failure, not NULL. Sashiko reported:
>=20
> > Does __xr17v35x_register_gpio() return an ERR_PTR if
> > platform_device_register_full() fails?
> >
> > If it does, we might be storing an error pointer directly into
> > priv->gpio in xr17v35x_register_gpio() without validating it with
> > IS_ERR(). Because the error is ignored, the device probe
> > successfully continues.
>=20
> Before commit 1145d1a0703f ("serial: 8250_exar: use
> platform_device_register_full()"), __xr17v35x_register_gpio()
> returned NULL on any failure (platform_device_alloc(),
> device_add_software_node() or platform_device_add() failing were all
> [ ... ]
> priv->gpio never assigned) and failed-registration (ERR_PTR) cases
> are skipped.
>=20
> Fixes: 1145d1a0703f ("serial: 8250_exar: use platform_device_register_ful=
l()")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793704520.gi=
t.jirislaby@kernel.org?part=3D1

