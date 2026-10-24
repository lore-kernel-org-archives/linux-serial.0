Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824942;
	b=C8U+vR0x/dre1FaGFrBS70jrWRgaG19Kkfrgk2ghbkQxV0Ep3TSOIXMOOrDvR41ArOJl
	 l3S8JZlR3+Wj7EMJ7pZ34GQum4VqqtjxvuALvU/+1SV7w+VBwbqIH7RzkEmPeX+/rW++P
	 VC8bsh7NeD9/nlYSeEJyStEEVBgfWGmPxODfYoqLpM/a+uWSEujG4FBaSLi7XHmubeyaB
	 UeibuchvRvMNmhzBgu7vImMHO8+F3hjxokG1FjCcfJzK/uXweoPDJvG5IPdo3/fNeulxC
	 DOzOEtKE5vny3ce18V5Aw1sjK67D1948Xv/lSW1cDtJPEti2hkgGmII2e70KwFkCdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TN76DgHGuNiXQUw80MnBtKmr6Bz9p4P+NPXEazJyMZc=;
	b=BQI8/DyDHv1W4cB8iSZBTQY6ZH4fxhaFH8aD5yxoUJmgvQhnu14hAB3pEeW7bAs+Zj75
	 iflKfkljsBIJjZ+3sTDiDPEs/3T9XVqe7ST/o9/7amnCNapn57t7rYKOwg1wGXjmBf46u
	 hzPsNny0gQkXUyESdZa76fMgqgac6bImur5fliHsZ3BkXJ5Y4UdY1Vsfy5qyyzOxoNQ4L
	 kUxeCNf1Wdlgg4IEuSFt5JmVa4tMRlQXT9SiLdTWbvCJbT6JYn4NMuT7WTe7Hs9VhGFZT
	 ODqIxfXysKJ2D3O2HxgmA/OeaSyqoJ55In3sJSFSNfuTQResjl9k/jld8oZDew2uDuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqgEAMdl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F0606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqgEAMdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB6D1F01825;
	Sat, 24 Oct 2026 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792824941;
	bh=TN76DgHGuNiXQUw80MnBtKmr6Bz9p4P+NPXEazJyMZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqgEAMdllb5SIi4s/QsMQl7H8Dfuugf91dHGGFKUeTHWlRpLd2R+J//kzRom4YlAo
	 k6AiZ1UtmvWAFXPC3zkrWUKnG2GE6rChg80QGUxaqUSbQoR3gvSChBCtWpTVHKAA6c
	 +eR7207gq+uzH59HHLJZG1AFWhyPRXr/dgE2b0VGtoaU5lVGTSP/foTaK6FQcA3oH/
	 P21HOaoJ+XDunWpKpmHy8pUw+M/lGuvXvOyLH6JY4qGwbjyeYGdk3MZmY8RH1OC+AS
	 SRNSKJEscZRjQhoBDqumr+xgYeX3YKf3A+74rKp2v+aggC8kyVuf4p5OPbzGMuAohO
	 GEfLx8cfUcKQg==
Message-ID: <sashiko-outbox-183576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-4-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-4-9e52968928d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:55:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit kfifo before calling the driver.
> serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> tx_running, allowing a new write to replace tx_size while the old callback
> is still waiting for the port lock. That callback can then consume bytes
> from the new transmission. Reusing the reset kfifo can also overwrite the
> source of a transfer that has not stopped yet.
>=20
> Reserve the flushed FIFO storage through serial core before returning
> from the flush callback. Keep tx_running set until a worker synchronizes
> the terminated channel, suppressing old callbacks and new submissions
> during that interval. Return the mapping to CPU ownership before releasing
> the reservation and waking writers. Normal transfers continue to use the
> FIFO directly.
>=20
> Reuse the locked completion processing after retirement, including OMAP
> [ ... ]
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com?part=3D4

