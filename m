Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876657;
	b=qG8sl7bWSby0WQ0sCtMAkFqy0eDGaEYgyqHPgtLCdh7LGKx0p3zGuch0SRHcQxbjKNPO
	 OCASHb0Op7vOPPxkCfLCRm52w+I7laRkZYhywxEtgHEIjGwV0ZlY8SVFrM9TFR7Q/EL12
	 INCyRNGlD+AdNdVdEatOnRGD/ALaOsiXJ2jzeE40Itdo8g//OpJaTVxF9FmirO/Y4J1OS
	 wwME6EM0pPEwEEZzF9YhnXm1TKg6N2e6DjXGBAYh9m2XK9iboZVcZsElL+U6CsmOKMm+H
	 7HneBVSIp3MKFlFwFtbAvPs9FL8nLsfcArj9ST3tbiKsQ0KT2Ad0Hbhcq4Ah7mdK5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5MLpTNXbtHcn0dfwbkET5yKuNY6iAhVyP2TEUkcX3ZA=;
	b=Js89iX/BhhTAqhlCjNI22deQOd1gsma6rphlxQiWiV+/eF1ujsN6g5wi640NOxQmRGlN
	 SqnlCbmJzOiwMRryiPSFD7IQCjI+zRXJelaajdOHxHpzR0Dqvv9fyz4iGwqPW0vJFvaN6
	 WoWtWLDxEbY+172SuImZx+5jPlvr+7gYTZxPKCGUGZJJM0/mjvL5yky8dfxKneaUe6gf6
	 h2I7qaxGAtHEKqd81+uYkRqcBTUgZmUrOevPWP6JmbmP6heSIYYOoqQ6ugqBP7pX7uq7V
	 5QX+z8eSzXNAXCzOcCh74g6pvsU25dxTxv7Sm8MA925Jv6CuLF/49wll2u6rymIoZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGeHtXY2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112C606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGeHtXY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8421F01825;
	Sat, 24 Oct 2026 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792876657;
	bh=5MLpTNXbtHcn0dfwbkET5yKuNY6iAhVyP2TEUkcX3ZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGeHtXY2EvE11czrGPpUSbaUY8WH7ACSwNx3jwc49Jxzdm58iD6HvQBFwBATcgkLr
	 2UgUmIRzZpfLHLPZMCKKnnYCA9uQto5izxNC4z0Rx//qzkV2bke1wAczyrYXR+rx1k
	 ttHTY74ivwLOmJg+2/Yf9LyKCYER+H57dmPMk6eJ4PGeQAdvVuG59gVnacCI8REYIV
	 YJuHexd2VJUHr9jNwN27qR2NgTXF8+dUSXfpla0mOZPAzNvnvwyX2gc9HjH1TLOObt
	 ItPjjMDtfXUkXjYrT5U4W4YZl2W844BLvQ7Y21hFm6tK+hVI/K4RFg64WByeS3oP9l
	 DGB180HgvmLyA==
Message-ID: <sashiko-outbox-183880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-2-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-2-6f366591f566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:17:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
>=20
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
>=20
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
>=20
> [ ... ]
> This serializes write notifications with port-locked serial-core state
> changes, allowing readiness and transmit-storage reservations to gate the
> notification without a check-versus-shutdown race.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com?part=3D2

