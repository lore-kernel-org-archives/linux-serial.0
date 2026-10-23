Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716554;
	b=0Ts50DRH9sXOX15VmOIZ6tq8wUuPQFlgakMUlcnuOWOHmN2cuk/UxLGS7VbS/1Tsc8hl
	 t01Ff48mJ4eFT4VQYU7CXR3GjSWsXtY3r3SZkZ88w25Bf0VQlvSsnbRI4wjfDrtB/6E0X
	 cDAy7i7bA0nXAhQk6oqwyXMUoo8PAu64qEDMYFiHBBEqggp/L91mt1SUzKsQXnwKErray
	 YjCj1lol0XFVD9ctUCJ7OYPhBE5yZ7fcM814GlyIycgbaw1lK5yd53MLlfG0oSogM+zY5
	 /soA67PIZ2BTmPb+0ZFfykiu15ZklTOxgg7EQ5vbm+CyK6lqdFsjO0IMhL+JaY5/4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0vqzobiLXhkfDMi0+QLqZop06F9qFvjhMfvdnqvadDI=;
	b=f4uej41r+7NDxeZ7YrARZFtgyee3se5QOqP4xdKNkESwS8U+boTw9NfMt2Sgr8S4pmv8
	 FkobTOGBRs2sQmdTlVX/d5KgNy0FKBbPq6dtcOicSHSrO85Rlc5G/nUIc1KnD0drQz/6B
	 XWleRsYlP0zDC0FzrBHVllOX42m+LN8Nri86i7IWd7KmJvUHjQljBfw6Pajk7rwP9DIQ9
	 IWrQeXpDl2TcX8runKLL5szIUM0wiTzVB8nYu2UyJ7x1M5wRgYLt6L1Dgol/uvAIWAt8r
	 liyJom1nHob5QoRGRLqNiuwHhr3+7qNZa4MlstzAXWm4L7D4YSTGHEetkRnKmFkNKww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzbx5e7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260A606A319
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzbx5e7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F2F1F01825;
	Fri, 23 Oct 2026 00:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716553;
	bh=0vqzobiLXhkfDMi0+QLqZop06F9qFvjhMfvdnqvadDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzbx5e7jnU6u80qvXuxzcH8gfznUTHv8/hZvkgh9x4jIQtNvR/t8lcnenc7lJ6B4V
	 XSm7q6z5KdsLnoXjVUocZo4ohRj/6VWP2sBkGlO6IDE4AyfEX0C3YC/0eMwjijAA9t
	 sYKfDfnsY7auixvjd/ugsRrje9yrbU9FSBytvZKPR1y4vvIOWXlyt8IvJCIL/EC95k
	 DBF6DkCYwaEbcNlD4hz55rBAQ8oJ/QzxdFbELIlWsMWpBZRV5HIqNo6XktlJpyJp0l
	 s6yTTB8qOhiFzYpIHNmouHobnXOD46M3BVe7xcs765IlqpYQ+JerKVIm9JHuyVC9BJ
	 2Laugun7EeUgA==
Message-ID: <sashiko-outbox-182184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-3-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-3-088ea51e3891@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:49:12 +0000
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
> delayed register restoration and transmitter-empty handling. Take a runti=
me
> PM reference around worker UART accesses and drain the worker before
> releasing the channels. Shutdown releases the reservation after stopping
> DMA and unmapping its source.
>=20
> Track a flushed FIFO separately from the transfer length. If termination
> fails, retain the reservation until normal completion and account the
> completed bytes without advancing the reset FIFO. After successful
> cancellation, process a zero-length completion once callbacks have draine=
d.
>=20
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com?part=3D3

