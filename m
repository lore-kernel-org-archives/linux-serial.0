Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564417;
	b=ge3MjjwLt+OSjzrJhcGYkNnDB4egeE7Wg50UH9oUVJlturGlBg4NSZftrVZ4JzZH3cwU
	 U0bmh63H2IzMsHqxVrNMfRQ+C9DL9n7yg0iaOcBWcYHyrNsjH0WfBn3fU2QPDZDAezBAH
	 A70+v61NSyUhP+Y4TBA1blTq1FW+zcapd8rrunjpfYwlBcrqrFsgtnvRiiEm7wh35VID9
	 YaIu/VIfwQGPIFGESCR5iNL0MxKKot/NYFxa9D+JXVXZiFOY31ZzLSuKcVoB4txqqYO14
	 rkOTqKCh1N4NaUEugLbTOMdfxj8mzP+3rKske3/zr3NxicRXRwd9NvcfeRhy2OMt9YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564417;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZYAVpuIw5c+qt9QjOAPTimvKBrijfTGemPeZXm9mzQ=;
	b=GAWfRBLodIqH3jjrGyy6LUXKRER13JxhJsHeOa4HZzRzDAp+QocbXbSMNckhKrI6mi4y
	 L2qnA+fdI4mF/MRRAysNbNe/ts2VUACORYSo0UWJL7Ly2tPZo0mXgrzOSFofFHbgeT0E9
	 l7KMZk9BHj+xt/KZgy2gkh58LuywRkPTsvxLqkw1lzOuu3CA6xA+bPiU8kp5jj0B+mkvM
	 AERMZj2cB2OLp+u7R/4QyzVTerXCdNhMu9zEdmQmjwrYPtQ+al77zEVb58GzIow12gI6H
	 0yZnEQ6GUeh6/falNTN07gzf0zWryGwEQaTIpQIPotxtGK+CYPO0xJkkq8Z+jx+pc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWcQlySY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4C606A893
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWcQlySY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A90B1F000C4;
	Fri, 13 Nov 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564417;
	bh=ZZYAVpuIw5c+qt9QjOAPTimvKBrijfTGemPeZXm9mzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWcQlySYlxB8uhVSQsvzNIYhBxBpyXAFncQKweBtrIClEQ1wgl2qVYq5vG9s6Ba08
	 EbkhXw/5XYCM4U3q2HFRnBxAUG94uAGSW8vk7+J23cf/6ulAWzWVWx8xB3MOFORy/O
	 ZC5t7eDbFyy02tgJGWnfINWvdFoZ1abBopMamFd/nNWPjhxfjUzIpLWAlM1Rn931Hp
	 TXuSQBukI+dPROUlAA4K1zj1noNoOT9PjuDzDQK1qefPXY0oicnwa86TQUZ45MPI2p
	 SvzSpiMZ6PJNyMxtOv+ruDDiWAY+nzT1i0VVdlNpay/3aJElfRcZKdi6tE5kpMueCN
	 BAURiwVE5CFxw==
Message-ID: <sashiko-outbox-212604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/8] serial: serialize asynchronous write wakeups
 with the port lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-2-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-2-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:06:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D2

