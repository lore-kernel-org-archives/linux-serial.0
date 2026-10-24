Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826803;
	b=PWEMszebjNiFOzpQ5815G55nOIrw3TvDpOUt8tOpYj3C3vkNdYz1mB+MIxplFXKP75Xq
	 27/PqwlVafvWWe4vp8dqsITe7KIaT9pyTEqnK/VuUAZzZlQnsNBt8QH2f2UuUb5WNZtxQ
	 qyzLfRUqmmYjMHExhA0IUm0KLL5LUg5SN387XYDMjOfko0ATl0fim3TZkvUzX095ItYaB
	 aXxK9Rnww9s1+uKIh3W+ZC1FOFa9RnmQdBad2uddDEhw3BJ/nYFpQMMDrwFhbqetmIwJO
	 pZFZq0nZv2/9miTIyv+oOmIT5gMrSMSEbwdakXQUCO4jNWNKSrnQKsXRiNu6+dl/GqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yxIFYFR6kA0d1vMvPA25sOWsSnKFJXqu3bCZge7B+rg=;
	b=xXg0JSX7HJ/fDoeuBMTfUs0Aap0hg8qJ04YuogFYnJJL+q3nZyMxMHolxwmEdRi9t79a
	 yOlsB0W5GIzjD3lB+VF5wC5qHapkEjiczCNOWk/EBAmSZyPC+AlZ1t1/0euu5RG4uFG/N
	 uzq5i6FD3Vkz+7XvbtOrMHih6UttgJ8ecHOeFbZMXP+NZI70XedgH82P955hWR50f9fLP
	 M+FZjY7b3l93yDqjX1JG852jrBW/TLWKo6QVWPQuy8wCwl8hVSVfgAbPS29PcwNqanmwD
	 XLmIF8yEk7FvkK2wloOEglmt3lgs83u54Q29Ik9awlplpyG6+bqHX4tGqoiQKt+/O4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFIjPaQf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C7606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFIjPaQf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71871F01825;
	Sat, 24 Oct 2026 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792826803;
	bh=yxIFYFR6kA0d1vMvPA25sOWsSnKFJXqu3bCZge7B+rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFIjPaQfhshvELrE1pDqPMvPsHFCC2gethf/c3V/d8IBBkKhsmHgnT/+tg4TYFyyE
	 U6L0LWmn48LNM62FPgYyXs82980LB1/DhG1UJOwOowk+yqAayrq+rUY7CTANazR1S6
	 yJMtw8rHQd3QtovRDKBNQjE2/l2dqF/nl29qHAFzAdJDsEdBZ9p6fag6MXqcNMMOkQ
	 nZpC1z6xiRNmQkaDxQlnanN9PNpzyZBz9mxjQMY5rGSqQC1oWzl+CboI5r5tSLugEz
	 0Xwbz+BfQ+rgE9vIsG/Hk2QGlhJ2ZFz3hi+rXpGYDxbnHAmxjJTjiT+sjnGY7nDr8m
	 dRwzVF+XoZE8w==
Message-ID: <sashiko-outbox-183583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-3-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-3-9e52968928d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:26:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit FIFO before calling the driver's
> flush callback. An asynchronous DMA transfer can still access that storage
> after the callback returns, while a new write can immediately reuse it.
>=20
> Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
> flushed storage until its transfer and completion callbacks have retired.
> Serialize the reservation with FIFO producers using the port lock.
>=20
> While the storage is reserved, write_room() reports no space and write()
> and put_char() accept no data. Defer write-ready notifications until the
> reservation is released, preserving one-shot TTY wakeups. Keep the flush
> wakeup under the port lock so it cannot race another reservation.
>=20
> Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
> high-priority flow-control characters, which use separate storage.
> [ ... ]
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com?part=3D3

