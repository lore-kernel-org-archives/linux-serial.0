Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284644;
	b=FgiMeuwCaoAM28mq/MjZQLhEdJn9Y7TVUOCqyHq2wvSpQPzvxGg70757T4kx4GCXLhvd
	 Dg1rAEq+Np9j65k/c9sspW7ylv4jwD+H5PTKgbS5zwAt1jKS2nAal0HLqekIHqlMavroT
	 j9AZM0hFx9VL889XZvp+eQYmtnoyjgdwLWqhXadZOuYsAoePfGlfmQzxmv+eIjk7FxaJ7
	 F1pUc/fHtlLCPdz+PjoI91WlbyJ++S0cI4zlgyQWZpMZpXDuPIE2pn1dBh/YXE7KpT7py
	 /wlVMYcgyMyj0Q9zCi4WWyIa/CEOe50kGYWlBRgSc1WQtQxvvO1n43GA6soBsIxK/8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zOWJ+733wDqOfRLr6kmYyJwm3B0Ww1asLcO7D00Oj0E=;
	b=04/c7jd6k6p1SoCCsi5yCQ4dOKOrvRrWXKNKiVeJ2CM55S1zqNgHMtHNIH+HywgwEDzU
	 a23jiYs1bJjLTZjUXaJcozKmMVo6zjUKNNHzbj3+G8pa8skoQg/8PTE6W5WoBEeg40lTW
	 INcrW+95QrLEXugzBIAgyMHAHLJdAVYlWgvGOafQ0jhdaEyn/H4fhmWlArixR5ROg7x+f
	 gx7WFN6UpnBoaQH79pnWJ+pFYtSjHxAoeryCbCM1vtL6i51cJ8qjScmFJ0tx5FS4G3o+N
	 3021TWwuDXJUJtlZmj1OcCjg/OWdQzX+9TrsU5yPlmWnU3ndDxSK11HeaqndfSKFgXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJB8kY3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8B606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJB8kY3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F42B1F0089F;
	Tue, 10 Nov 2026 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284643;
	bh=zOWJ+733wDqOfRLr6kmYyJwm3B0Ww1asLcO7D00Oj0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJB8kY3KnC3ob1VeYU0kAD891MtJvUSIIvP9rnirhBZX580FfAir3tRq1sQCzK7Tu
	 TNzfcLVnAFOoJchgltt30IfvKsVWu24c9dK0eMOhd2unigcASsu3baVnUXqHKrRj1E
	 X7sikLBqvaUsnZP1c50nUNPtjd/DrYxit0v+/NENDraKQ7qr62tRIoYlxNOf8a6end
	 YUbRDSfmahsrUmRRTwV+LtVsb55waWevKD1OPHR2dMLOuUgHQrdy6fxW+sTiuF/WO3
	 JkOOQOQMbiWQ7kZriQVqvS3tBgx3anON61m1kQocudbA+AMMwm+f2HFi8PomaZyqZ6
	 KvGD1F3MBgr9A==
Message-ID: <sashiko-outbox-206190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-5-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-5-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:24:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D5

