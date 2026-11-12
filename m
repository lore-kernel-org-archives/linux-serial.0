Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443226;
	b=lQCH8sjnyddW9Jomig7o7ehtCktZbZNC+Xs3eRWvhWiHCDfa8UT6yDBRzQrxmyd/AmMi
	 W/tiSzrtvPTGWzuIntbVF7uGPA2gPRUZOj+13KTCPCexamiQi2+B1w8RUWcxZPXPP0RDk
	 KzNAYZYzLA0vPqrHSeu2xM2Ql7cBH3p9jkxwoYpG/dfM0tAd9n+o1kwm1fi4cxOZ9cv9m
	 y3f7RdSO6X6OoZWO+djwMStA4hN3qrwjZP0L2QuqbVgiM8GkWhdBVdm77+k45Esq3O6VH
	 moNxR96jwSshiQZViw7pn+sVW6epGeCrRLhzQvQXjAvceN3gMvkO2m1AZHnT9CSaYoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SO2WgEczuewFbUj0E15k6gtc8JTlOzGO7w2XcNGOfvA=;
	b=Vdu/s0IsqWOimWW/p1rwo/+X7/asXkkYvbO00qyZnKVpZ0yhXGi1j0lfleH/+BcbOppP
	 A7W4cUUYLdx4swbmVRyjqBAUsGS2CZJUg33JJhMCsP16ARGM4VYFt3BKN34OMKw24K+6k
	 vmMzBXTjGH4V5++cfKypWrOzbB1njAupU7NM3BOfsMnA4rHpGAZwdSsbfFPovBHcRfPQ3
	 mKxVckNCQD6bhbdOglmLYw/rr9D/+Xs4I1qNzWEOOl9bUG2Ex1aGpIYSESwV0vF/s9++J
	 StJLu6XPNVO55ihu61236bmGhMVZ3RHPWyAbHIznYTnHeQZcarcRGdUQ8rWEIxfVwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbR3yZyL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD7606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbR3yZyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297E11F00A05;
	Thu, 12 Nov 2026 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443226;
	bh=SO2WgEczuewFbUj0E15k6gtc8JTlOzGO7w2XcNGOfvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbR3yZyLDnOkuLEy1HAh2mJMCN59OUIW6nMfE7fuCfvrQP9YV+WkYDIxT0CNxRVVU
	 niKLQxunzW2Gm0CV+DM3mJoqngaikEYYv6S56+v3EmmbxhKjRU0vASYM2qGGXb+Lq0
	 4Y2wEdWg+yKu9qQmqr/VtTZsI/vIZTBk1+i89yLz8BmnzyJyH1+f3TU1YFvWrU9kTD
	 1+QbqHBp7z9Ayz94HZFcV+Kf3PB9q5ibh8eMoQr6CkP17WAKxS8/Y0sUYafCVWoZaG
	 we3vPbTykC+CM7hFBAvNq+QqFqAeJbv6me/nirHVlhurVnBCV6YyIzqWVxOSNp/8Ia
	 1nznB7CuETWeQ==
Message-ID: <sashiko-outbox-209915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-2-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-2-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:27:05 +0000
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
> Use plain port locking in hard-IRQ handlers and in helpers whose callers
> already mask interrupts. Atmel status handling is also called during
> resume, where lock_suspended is acquired with interrupts disabled; JSM
> interrupt processing holds its IRQ-saving board lock. Keep IRQ-saving
> [ ... ]
> the restart worker during shutdown and removal. Release Lantiq's hardware
> lock through the transmit helper's completion hook before notifying the
> line discipline.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D2

