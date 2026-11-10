Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284121;
	b=tIxxMnWEOmDplCVocfUKyLR1jTHGSdjIUoSzAB60NSvQBVdUdBlRtvIwRv9Fl7tYyhqg
	 VMIQB/1UPwzE3Nc8yt71xTvICls6QYZgbvdZLwVlsOjsHp8fg8k0PcZDLcyTzndxrb580
	 uj9wcEM2CTBzdwGK29VOjqhqjK6QgVSpQLdLy87RNUy43sCaey6ZjM8QCEQEVhYgVRegP
	 F42/7wxoj9j+N2H+WfP2Cg62OA/WRLb/BuvIluDzGKpAOmYeYWncSJfcfeBTpgudij0v7
	 jYKkwB9AVOHEDQ39Z7h1yPVMzS+9QXTtCX5QObAjTaEpIEa7pvjQz3ti6JMEZ89DRjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GEZ/OeHNAOaiHzE4Uk4Plg7lkUNLFKrBh7QtKZG9u1c=;
	b=VfW97F4EsbDLlT1n8TucuVpaoQFEhxWUjQt+iEIZU/QTkjVjYQfyMjDfIiq3qpLxnRL2
	 RA9Su0gn9ImRaDdTSGOTi/tZFWXiFQICuE4twK7CH2YQrYE9Ta3t8z1fN9VucIU5wFa5+
	 g0PQZWQVJV8sEQwhw0dIAVvWRmeIXjbZA+XPCjmSgjkl9WIHtLt0Vhj77r358h2vcT9KV
	 wLhf3Nke6Co8AKCdJkxiL9U7/C94Btvlj8aI2eao9dPb87ZVypvLmFi203VJOVY8v9jKs
	 qjLK58XDsmM30iBLktc+xCkGFaBSsc8Z85MVK3AEWld72DpNN/IN6EPiSoR0i96NHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZDwBgLY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98712606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZDwBgLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9300E1F0089F;
	Tue, 10 Nov 2026 04:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284120;
	bh=GEZ/OeHNAOaiHzE4Uk4Plg7lkUNLFKrBh7QtKZG9u1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZDwBgLYU9oLiB9qd03pUW2D+kGnx43ZSiyN3Xv7SSEdqdiVYgrI5PUq3CIRP2nUZ
	 9mEbZ6k97IKsI0uGbubVdI8JfvGAEvidcpiWrrJB8BZNFnwwrxNPWXC8P+bf69me0Y
	 rleFPs5jPLE81TQFW4icPsQFaRurzsJ+NMsPLWFLwzySrqka1STjMbc5OqzkUAioUA
	 SwfkLkM6Uja0JjLNm4Ab2+intLHsokcPc24EJnDmZDdggjm0J7gN00jV36ju0KZ9Km
	 6twl3jL7b7yo6JDAxkjKjvJ/+JjEOei/DaMUl4xgiw5x55L1VJLRAYI9zAwwaGQni1
	 1I2o8QnwEUhQg==
Message-ID: <sashiko-outbox-206181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-2-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-2-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:15:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D2

