Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876949;
	b=rF9ET8i8O+e3v0OlqDPsn0j6/pDql7r1QLNaP6odJKUlwq6BdIVuRtJL08pKtXUyy6uj
	 an6OXX3glnZF1phFwEafi4PNp41DPacn4E5uHfCAR85psL9tlo6Eujvucmki5IPM3At45
	 HJ59e9hMNzrwM54/reNBeMEZDmeexUaWbawtwYJlW+w9P+mBgeBDPcrvgQIxZ85fmieK3
	 q9aYifqCqT9ABBnfOMTptwblxE8bsUYHlgNsDDoSC54cKH6QXVt2mGFJazzYnTzrH1kXo
	 mmICfbFZSIWdSiBPMmBUWTP3mUF/pX2c9gtfJtFKJN9W1P1o0Sr8O/bkoO5McAFxNGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jet5v9QHf8TUZd6f4sTbi36Q10jY5SoVpodaBmqd6tM=;
	b=sGMDcb/7mK9OPo4YEPCyJTMcESY5HFq3OIW9TZfMR5CbBu3kmvFRtajCwYIZKBpNAAKJ
	 9WYZvnIi3J5SAsQZ++O/1bPQUGA8KRB5Knl2tj5eiSAX2P+g7kYK12VacDZGZPNtwlrlK
	 aIet/MAOFDv9C8Eb7wuIYtGEtU7sYcz/GWNJhTszmH1Lf8suMdqktNkExS6HRtCY5nF+N
	 YZjdvwRKBysPQCLwM25ijoiA7XIff0uqyVSYBZ89jXHZAuYRXOPUMsyjg4kkftggIR6wX
	 F3S+WnUip6RYTOjTwTx5gS76sdcZS9qaXwwzAdambRlbOpPKL4e5N0cqdbHw5zO+zwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgA5NZsJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46D606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgA5NZsJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B11F01825;
	Sat, 24 Oct 2026 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792876948;
	bh=jet5v9QHf8TUZd6f4sTbi36Q10jY5SoVpodaBmqd6tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgA5NZsJT7PiRS4rrbkFv/h6lHi/gI1XDTmejl5vwgvhybwUzefPwN4gTwRy1fZVv
	 wEUshsB/bG6hjXdmnnvdpnkqQ6jhGE2wkmv1QVwjUx6SguqCZSg/USkmH9F+onv/Uu
	 XcmOnSvERMtWd+0qhITopxizsyf1UwHvbPhVUmuxIVjnjNSaZl/EB7NIze30Sqzkt3
	 4cCzga7N2p5j+2jax7uPjSQUmxgMbItJBGBkS7UN3Tw4E1NpzOw6Dw9AxWNsImCzye
	 3uOY0xlG9VQ5oyqnrETqKJ0xtCW0tT/JRn6KANR9Arbz0v9FLISF75fmZvqIJYGJxh
	 UZBDJvxW+Gr7w==
Message-ID: <sashiko-outbox-183882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-3-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-3-6f366591f566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:22:28 +0000
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
ial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com?part=3D3

