Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451319;
	b=awlazeyor9GxK4/Wmm/E7iNHUl4Rn3YAXo3+2Gia7LKsrDz6gNmqPj1YoaVC1yp5doSG
	 6+13LSkZH4TTLeZKE3PD2p6+8bXWpSZTkM4DSMuH2wOUzNgxNDsk5lp70ogFzXCy5UXOA
	 kXrnU/Y6XnQ2OFbI0o3vvkh5+0AD2JZsigFIS5TiC8V9q/r+kXigo2Gt2PvbP0nlZvOfX
	 iliZAnZQGnt5XCp9ETVLA2l8NGq8erU8t8+hTE/mAH7KaUwTg69mo9isjqSJxYf2D8uhY
	 E08ES7Stg3a0Pcp09WjjGssbDMgKuir7lq3qPTyLKt7XizeIG8Hv301Y2U0qEEn/Idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=inUeb27zdf73QlPV3vCDEFp5QxjDUEiNbiDKlJhqyyA=;
	b=2O1rIRX8iXHpPo6KmWD3FotsrwEEf1tairJMTmoh32RulMSnQ/IKQwAGZr8gI3yKJ5no
	 hCnPDnEXVNvXkI4ygvzlOQxCXzRmzD9Sam46VoGXSSdnoyqFgkHCvYpMm9VKEXsi+u0Tv
	 8PchbHlz81HHAlx3pgbhhGKvOnnRxri7xiYnaK4XwAKnj7Me4QuQG+ex8QA/jNHf4r88f
	 NTw7zRqBQIudIqsSj4nFsle0xyupRradLarzLjt+N0KZ77pJExORST6ZgybWRRbTgrIg3
	 X6iiXzx9IICV0UTrmhj+mBi6pktsrnSAia56iWPGquyAZZWAVbWCpZGN4MORkXp8XwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4wxv7nr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99E606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4wxv7nr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBDE1F000C1;
	Sat, 31 Oct 2026 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793451318;
	bh=inUeb27zdf73QlPV3vCDEFp5QxjDUEiNbiDKlJhqyyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4wxv7nr6EUXvUefk6kBsosspHJTNjVudg4rD09l2FqeGrMuMkIWsfHN5vZfxF5AD
	 Cx1A5Sz05AbqGR3qAw/xPthaso2sPhW2RTFlYN3CAMDG5AbPmaZqCSQhyPp0Dh6VMn
	 VP5jP1ovip9tsgda+FvK+Nr8FR95ROpaH/XHSEwjBZVy8wroXa34iJtpYl0vXRZ/yk
	 AirBNu8YMdntE/GyHr/E11wnfrMJRwCv6RwHM5s7Kecc/PG/nmLM7k2UcNPwULDyzY
	 PX0+ONzf9RcPyPmLL61WFpF+UAJjEKrcMJ2eIeVaJqd9oe33SFjNPeT6gdMde1puub
	 yK6rOrI4LEzqg==
Message-ID: <sashiko-outbox-191949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] tty: serial: msm: fix TX kfifo underflow on flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samarth Narang" <samarth.colleges@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031123911.3784690-5-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-5-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:55:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit kfifo under the port lock before
> calling the driver's flush_buffer() hook. Since msm_serial does not
> implement this hook, an outstanding TX DMA transfer may complete after
> the flush and call uart_xmit_advance() using the flushed transfer's byte
> count. The existing check for a stopped transfer relies on tx_sg, which
> the flush does not clear, so it does not catch this case. The kfifo tail
> then advances past its head, causing kfifo_len() to wrap and the driver
> to transmit stale buffer contents. The same issue was fixed in 8250 by
> commit 9e512eaaf8f4 ("serial: 8250: Fix fifo underflow on flush").
>=20
> Since the TX buffer is mapped separately for each transfer and the flush
> hook runs under the port lock, the driver cannot synchronously terminate
> DMA and safely unmap the buffer from that context. Instead, leave the
> outstanding transfer running and mark it as flushed, allowing the
> completion callback to unmap the buffer without advancing the kfifo.
> Clear the flag when preparing the next transfer. This avoids the kfifo
> underflow, although the data already queued for DMA before the flush may
> still be transmitted.
>=20
> Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031123911.3784=
690-1-samarth.colleges@gmail.com?part=3D4

