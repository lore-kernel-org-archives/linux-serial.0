Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623035;
	b=s5uELbbylUpD8YJ1scexkuTDpeZiz8LkqpzxUsiTmRbBPnEUhTzG+bHRfDfWMvMG+4ia
	 0Tm/wEwmW2IiznBIlZoFtkleRBdvZpocaPdKO/RL5JO24TnXTAmySntWYcincrz3FxSEX
	 CrFLAy9N+sE92l8pSkowvRoegSrDRlTX73u5XkOF6fFzV4y3yZZNlf/FyVSMhCE8KOUWM
	 H8vrerK9bAHAtrPZKg9pEAJUp701MkU8lBObEGEd6ry1BPfbzSkhh2p9RtYadoRkfP6Su
	 N1vP+XP+tKB7r0v0b9/AsbBSGE7A601UBq7lHQE+DID9JKaSRH89S4ApNkjtgA+FLzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3m5tKCqFnCWJasn+KSOB0boOhTGaEtoKEtTCKCdpQuE=;
	b=uVRzaNvTJBeJDZthL1/M2h8Es/REVCKj5EqZ4g3fXThgz451HAxutdI+UYQY0IVmzgLs
	 wtADYjd/EK9jJzYFeUBuqcRhFy2X+SM9svN6MOV/PQtHWhd1UgihpPlPT5UkmF8XVOTff
	 cqIGcTVZHyEQBVHPXf0hu9CYDQcI31THwv5+p/aN9mKlfR15t0hloc5us6zj7/CJny06d
	 00OAlWHyR4GaWzm63DyasceZQ4R+RKGpcLSvMu84DlfSa/83V36ESmNDbBz77BdMALTou
	 Le/tnrzDBvHgUL2gCz7FYwbYlCYUsG2adGnVeA0a0AU5GEV4dZqLSqqQbfKAl2Cx3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RypMZLjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE0606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RypMZLjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37321F000C1;
	Wed, 21 Oct 2026 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623034;
	bh=3m5tKCqFnCWJasn+KSOB0boOhTGaEtoKEtTCKCdpQuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RypMZLjJv5XfRYIjH4rliwZ7LN+0VI+QdzdkagRCTgSq2C0NhbFEMhUl/RqgFbnS3
	 wDj1Kz0N5VwLk5XE82uEaq6had4dijzFLOVN/La+oMl4D8AlqlEqjhJBo7HcIUwZy8
	 EslcBakvMklt2YvTvlyOiNA1eP4i5iQFGqbMEjlOFiQOxjiU0Y3ImGr7rQOF2Qd52s
	 Z4j/SmtnAsiN/FkNZSjFVJAVfNagN97z2wb+JPmHXPOmgC8IYUgvw+0JcmDZk5I0dQ
	 ln4IjrCMXtgAyNrYTt53xHeJSbEL36ZZOKDEcD6Nnf8AGLc8kvde4fv6ULdIq9fJt8
	 dWkkh5r3++wdg==
Message-ID: <sashiko-outbox-180742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: drain canceled TX DMA before reusing
 its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com>
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
 <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:50:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit kfifo before calling the driver's
> flush callback. serial8250_tx_dma_flush() terminates DMA asynchronously a=
nd
> clears tx_running, allowing a new write to replace tx_size before the old
> completion callback has finished. That callback can then consume bytes
> from the new transmission. The serial core can also overwrite the old
> DMA source as soon as it reuses the reset kfifo.
>=20
> Give DMA a private transmit buffer, keeping the kfifo offsets used by
> FIFO-window providers. Copy only the queued ranges before handing the
> buffer to the device. Flushing the kfifo can then no longer change an
> in-flight transfer's source.
>=20
> Keep tx_running set while a worker synchronizes a successfully terminated
> channel. Suppress callbacks and new submissions during that interval.
> The DesignWare idle helpers must not pause or resume a retiring channel.
> [ ... ]
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-submit-ser=
ial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com?part=3D1

