Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742478;
	b=PuggeWItylt01MRFuUD87BliZ0Eb87VN4R3kKLuTf2081R2dCUlP45VRyVkid8i51cKm
	 UUIWd7KxMdif5oOLQHQJGBumqjp39wl4bPGLBFZhs79KGunlMDp6z5ywl8QiexgIz/HdN
	 C+vLng65DPiD6xAeOmcU53FGY3l86igcPJd9EB4MdZlIgGcWWn/66nQmKXaOlFzsbxH7w
	 i131JHvo0EsoQp0HrDqVcJMRlhU4hmrOzAGIP92pBGMXnTWT+08U55SIrTbH7zsRHgIoG
	 FSr6EzucT6vYEce0Y9sOxBavlmGc0cOKGRqv735ysJ4s5Pz3PQHz6nKcgDVw3gCVtiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lzeU3bBrXC4nvItOGIJ9ZWBPKhXIBtNpxudfiZFRYJU=;
	b=Q6DsOy7GY/9VFCXEqv84tzoKgHaN4U9iPU/30T53vRZQluf4tKFm7MgZB1wvyY/oyyw6
	 hNP3kTbRGyFavp54lqoli8Q53CiwNqYycFEMxJntxNnZYxaTf3/el5kYGFG50kUDO4LYY
	 PhJYzqLBsNq/LsD4WAGt3D3G5b2H49GkQHMP+Zh4TqPhqNGi2eXkzQuXBSD5nVUaJAsnB
	 b89XulDQGbsmKZNcaPg6YGsaEl1aAnlqYbGvTLko1ukaAx2g1SnZtsZSlMxAokNkNKRT5
	 m8ZsUmWh9csdxAuGsCMVBz76atoRu5VNEsenmpCB0EbQ9Jhtg1QwGnGOZqiBbhZf13w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAb8SYeU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11A606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAb8SYeU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD01F000C1;
	Tue,  3 Nov 2026 21:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742477;
	bh=lzeU3bBrXC4nvItOGIJ9ZWBPKhXIBtNpxudfiZFRYJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAb8SYeUp3JF04AICTwJpkr3M3/jqrpzjHsBs44oWrQUqNr0zzJmJsVo7NgTAZ6VU
	 NIU33kWUg6ijbHqJC4jwbD2AUEa5OdtT4ggF/PGdXw38YvjzsRq6rLKX49iErXbnLC
	 FSXS0Acrb2gg17rAXeBY8OgXaMSIhPSKcWeVI2IBXxZt3DlIhkuVJDdjJddjZsQbtJ
	 6H2ez3ytfgG0cpDZEyHCffca0aH9SJqgFU8MpTQeY0dSX1bDsb1OZOA+CUh6k3aHlt
	 VZCaCh3AmC04+WEZSa/cqD+7rvRjxFns5Lux0F0228btwhWSAzhxTjW6Pb846sFkK6
	 cOHIMuH46alFg==
Message-ID: <sashiko-outbox-196080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/12] serial: 8250_dw: configure RX trigger
 thresholds for Octeon
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-12-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-12-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:47:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
> giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
> dw8250_setup_port(), so it does not install the common trigger callbacks.
> PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
> exposed.
>=20
> Supply the fixed depth from platform data when firmware has not provided
> one and initialize the common trigger table before port registration.
> This makes rx_trig_bytes available while preserving the Octeon port type
> and register accessors.
>=20
> Select DMA before filling in the default depth, as before when the 8250
> core supplied that default during registration. Thus the new trigger
> setup preserves which ports attach DMA and their existing burst sizes.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D12

