Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445557;
	b=elj+POOFAYaJzsp4AHpQ+3l3ZtyWsUknolI5WWwVgE01sH05AJnUej4TRTRcODLPXTpm
	 WL/5e1aNkPj3kw2m+dfDUN48PMjAae09D4XqTTdUZNNPdf+oz2xblPYGTWu2+kfT4CNZJ
	 mslIGE8wtTl/PBb/LcrdsjDgmZo8pz8dMavMxWRvGhz7C2Fx+w9+zybpK9PktNgI9PrwN
	 /BaIDeLHtpnoHw2c+X5UVfaPvhXjfkvw5A7m9m443Kw3EnJYFscvzRdNkd+6R7VRFND7s
	 SYx352CrtfnbrPGp1myu4NYimfP7BrJeRBuF2X3AKJ+kMKuJpCWBAvl1LWI2dFZRnJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FAxNNxYl0BZgd/TNgXOsV9f4tASOVcbaW9Jb6Cd1R50=;
	b=LirSbrQ6ROnWsWyolUY3ydDGJBsv42QOviEuEJF626WN4yDYB8rSQw/B3aaMcGqNVodA
	 tFyYGUKxVmzAhE0yhZPDcf0xGO2pmS5EcqZwPmQ8Pmd5Vj8S1RWisTGgKcnxv8u47rbhJ
	 EK3bbQ1//5RtOiOa/YtnC7AKYk7bni5QgvSficSyiQgYNwqqHB6HCXS9UfUMbR6Kw70qt
	 iEpfbCbudlbn0b/uSY/8jqYYZW5VGRiyXy6U0AXhPL99APwgiTvSFH5x4Bx4DhV+qqKbB
	 oZ4cH1SRuiMi2FG6MQfX6y7R3Tbg8TozEK+bK83uG58O966u6GnhXAwd4ckKp9bTLpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJMrFP0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB4606A885
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJMrFP0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C71F00A10;
	Thu, 12 Nov 2026 01:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445557;
	bh=FAxNNxYl0BZgd/TNgXOsV9f4tASOVcbaW9Jb6Cd1R50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJMrFP0PgsVYSxj0pUJrjdxZb6QiiLY/vEyFHJ3NJ8dC1E9goaD3AZrLCyi0sgMLh
	 jTmtIJaQZvH6Ma1WoYxeJ10GXm/tZWDsedIp+qgvmalLnzc1Dw3eqadfs0zpKrStrg
	 XqNBuOzX0cK+nnbH+kHjwhkzNNcsRminLRwA7mO5xpWhJrHnEnwgA/i2TOxCRk+cqv
	 uHwtrSJiBi9nz69N90k6tj5Pv+7a/TflE1IxjVwAkMFVM0cQRHtZ/YpQU5uitv7W3w
	 qjFLeuOG86fBgTVxqtVgtR7Q+nySF9Bnx3ARzGxKusR8llxhSeZXLT9WGP5Muz+MgD
	 yAefqHDP4EbMw==
Message-ID: <sashiko-outbox-210035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:05:56 +0000
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
> reservation is released, preserving one-shot TTY wakeups. Keep the flush's
> write-ready notification under the port lock so it cannot race another
> reservation.
>=20
> Wake tty->write_wait after flushing even when writes remain blocked.
> [ ... ]
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D5

