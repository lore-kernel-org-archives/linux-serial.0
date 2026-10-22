Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703822;
	b=qYNaiqM4ti9q+fZOIe63D/yBfGTP6kMgdxM9b539GnrzKrttOSrMusmR3pPowEFzUJp1
	 ZB/H+a0PWIX1GM2/JnagRdFYbPTNkL3Xw5IJosgW+Jefh37n4+wIMkgzWGq2xsqyTYnPF
	 WaZ/TjLbYn8TBoDk89ytsKpjNQvtbnnz6ZagHguE6wX8ickptBOE+kOg3Aa6z0sm+QgVJ
	 IDc6N6QnsgJvWVgsbo9VQ2a23X8TAC0IFuqa/P8aiHLR1h6UdRMO668WBYVSLPZk02aAP
	 bU9PpVBR03enUBusO6INMHyMPtAo0LPOYi8VOGM55Vyp2ZHPCx0IGfHjO3bEHa7O6XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8JygwkqTIXdkpURM94Ghr8su2fD0Vv/o9ixTLygf+Ic=;
	b=2Gr1Ekf4U1woautGAIMsMWJEbIRMuO+499Au0J6tXTxyO21QZcxm32CD600ti+xI7MIO
	 Oue5gxRsG+9RymXT87NwdaetbQXUH0yMZy+GBjH7thZ8MOWdxab91yrmm9avny3uHq424
	 5wY6cD06UNM6mX1Ale1g9P1k252vtGGoVwR7yxReG/8ZyaZCZZJTObH/XEBLC6xhb6G1S
	 KJTSoEiEqHZ2aDRX7sjxcR98RaAhuv7y95bTD9v/b59FkuT9W0pynhhYAdKFV6qa54j5d
	 d1olZeMdi/wc7MkDvYLqqSXZRetopsErG8psjt3J94Nt5cbCVRRusfBEz58l40V5XVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=munv7RSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C12606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=munv7RSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07571F01825;
	Thu, 22 Oct 2026 21:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703821;
	bh=8JygwkqTIXdkpURM94Ghr8su2fD0Vv/o9ixTLygf+Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=munv7RSWKjwp4rKlJ/4NGFVw1r8wGGda11wjGcY/X/42bgwRYSEeVQQOzn8KLLDZK
	 RsNMpWC16rgfz3UfqW1Gq8+razhg5x2wS33b9y4WsxYh882cfDqA9NeRXI0AgWJaKb
	 s1uc1+gc9uJP2KH+P6AKNrdOeBb24NHLI9XRisgj3buqPGUbogLfaov2itGdU9HK/6
	 UOphuDxRRlZ1z5H+0LJjSWK1qJwqaYgEg2U60BM5zB/QBd1VlUQYutkB4qC40SrOAR
	 BJa4M4E7HPCXdXUJXmlDT9ja9sj6uUmzFVfCLrngmAGu9ZlMKUM/nchx5O0zx5vl3a
	 CeXzgd2Ku3DTg==
Message-ID: <sashiko-outbox-182052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] serial: tegra: fix TX DMA descriptor
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schlegel" <schlegelas@outlook.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-serial-tegra-dma-uaf-v3-2-129f6d67f673@outlook.com>
References: <20261022-serial-tegra-dma-uaf-v3-0-129f6d67f673@outlook.com>
 <20261022-serial-tegra-dma-uaf-v3-2-129f6d67f673@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:17:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Austin Schlegel <schlegelas@outlook.com>
>=20
> tegra_uart_stop_tx() calls dmaengine_terminate_all() and then
> async_tx_ack(tup->tx_dma_desc) on the descriptor that was just
> terminated. With the GPC DMA driver, dmaengine_terminate_all() frees
> the active descriptor immediately, so the ack call that follows
> touches freed memory.
>=20
> This is the same use-after-free pattern fixed for the RX path in
> tegra_uart_terminate_rx_dma() ("serial: tegra: fix RX DMA descriptor
> use-after-free"). dmaengine clients must not touch a descriptor once
> dmaengine_terminate_all() has returned.
>=20
> Move the ack before dmaengine_terminate_all(), while the descriptor
> is still valid.
> [ ... ]
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-172211@kernel.org/
> Assisted-by: LLM
> Signed-off-by: Austin Schlegel <schlegelas@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-serial-teg=
ra-dma-uaf-v3-0-129f6d67f673@outlook.com?part=3D2

