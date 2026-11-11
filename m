Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386993;
	b=YbegKqUP+NS5imvoE7FZZfqWtK8ph/chNpIrjiSTlYC2DQZjH2g67Cl4Lc2FxnmhM78a
	 XxtD2aTK3LY2VGgFJmP6DbpRWraHxsFrxyV9Dl4OZnFbeJRFk4ykV/kIm6IdjNi5K0aem
	 OuFyAWWomYgqSA+rIHJWRWu4cv7kGQktrgLNU0pUBliCxLpo+u36nT4juBSHnBzp3plVr
	 W5j0xuA0foTMxUxITjBhvSWjPHX58sgoOUnUBZbcwgCQZY4XaIpByxMasDx9kF3GudA11
	 7MkZ+yIwiTV6LfzDMEvy10bO/wM8VVmAge42wzJUdxAEZG+GCuQ8su4n/qDtnToe4ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f+j0xM0T3Rs1dxG8z5jFXu4CB5p6vj7GfeMURCJAIkU=;
	b=YIqQnhabn8XftMIczH79wBOXudMZgcKLWlbB/2Yagd8SXgf8oJx9eSmt2cTRgG2KslL5
	 fMiJ3hXWM8bh5qqDxs/nTdi/1t2/9hk5rUu6H4PBKgsYu1XQ8UjcAg8Ph5V6tDVyl8Zvm
	 uMFNymSbBits7OE3JWeDM1qHLjL4X7mL3anQcySscXr3lBf3hxfiq87o14tjY/PSxvU+Q
	 I2JyW6H0UDSpAju1yraVGgGUVUzxqM3NpUcHKcUXq2yVKHu9AbCSFEpXaGdfqzJbgM+UJ
	 6vrdb4eLl7Y1+zHqfA3MPBY53NP9rL7clLlIbSY26pKrERFE5eoEEkNfxrklXCU7ZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmXcma46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D804606A324
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmXcma46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479C1F00A05;
	Wed, 11 Nov 2026 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386993;
	bh=f+j0xM0T3Rs1dxG8z5jFXu4CB5p6vj7GfeMURCJAIkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmXcma46J1XafA4oSAcbv7tR7GLnCBRtkRxYN8S99N9hfzQQwNRytf0AKNHiD617h
	 i7fHMTWbbURs/0uXH/yJeCbJBGLFhhkSYpWQf6yIN9hA+OqgAGzVlZDF2lJQZA0Zxv
	 mVTrRUDNTOsWXFLhzMtouGK4UXDD/XSTjxNQRlzjvJlZwZ3XyuW+vBptO/rc1Q7NKI
	 izIpzyjIExOvWH3h0znezN5pGPPcniE1byWnbi15rzVi7SZ48K9BwpCVvufZaMfMcS
	 s477KWFswqnGE7mzivTFraEmz4oiC2tzOZ2V6aRsUX18dL3X5yYvf0xvFGxG2YBHai
	 FwyZbe7TpCYNQ==
Message-ID: <sashiko-outbox-208635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: Lock saved status flag resets during
 startup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111084125.80910-1-zhujun2@cmss.chinamobile.com>
References: <20261111084125.80910-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:49:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_do_startup() clears lsr_saved_flags and msr_saved_flags after
> installing the IRQ handler and starting the port timer. An interrupt or
> console write can access these flags concurrently under the port lock,
> as reported by KCSAN.
>=20
> Hold the port lock while clearing the interrupt registers and resetting
> the saved flags, so the reset is serialized with their other users.
>=20
> Fixes: ad4c2aa6354f ("Serial 8250: handle saving the clear-on-read bits f=
rom the LSR and MSR")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111084125.8091=
0-1-zhujun2@cmss.chinamobile.com?part=3D1

