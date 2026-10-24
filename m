Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876627;
	b=dam5CKJtNgt0/CdxZuDGEczpNl21PJNpeRM2CDUVb/T9mr+vZy78LFlSWev6Cvbh2UqW
	 1cOfGRZFPs9x5YBIPfP3jaOsbpyYM4oQoeDSSEiOQhsfKT+wmcRRJTL2GzH99EUeGLIjY
	 nIvQU8BbxNxH8q53s/u77QToLHn13UqMskxHFSi9pLmbKLmsUXDXhFNveh+CAcK1Jwiqz
	 wOA543Eop/b18LHr3Nn/TUIAxMdDiN8sb80jBSS8VJL4oQF9tj0wq32K7qRig/4k5t8bs
	 iZXOk+YIGnr5Av6pTHBx0rc+vmQgQsSFNAcikYMW+pcridiOr3NWybmLrRt7bMDmQwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876627;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qlou3tz6OQLkDStzN5OgjXNxcO6Gh+22YQT4pNen2C8=;
	b=AB6i1mjP6Qe558x4g16UbTPcgbDaADibiC9BK06LN9rpK6g18u+UmZd0fwnM1yldLdWw
	 e6DCS+U224sCJzWrqwWXKojR3Yy53vGSg4e+hCmxGMrwq2XoAbJhlBdEIKeDr+z+a6rah
	 v2FyBNJjTH+lZA4ERy9OsJ8PIxA+v88LBF27atLj+ZDUS5EcBcbI8z0APVt3sw1n0MPUJ
	 uBPYPcEY3pSUShLwHHBoqAqWVkQwZ8DHZIHAKEG13+FMh05WgTOpglFAhyHeZDnyReLTb
	 AJtHsFSb28iIVXHcDWwuQgNDwL3jHxu/UF6hSl21E8OEiepae/1CWvILil8S2ERXpcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6cK94X3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99D606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6cK94X3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A841F01825;
	Sat, 24 Oct 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792876626;
	bh=qlou3tz6OQLkDStzN5OgjXNxcO6Gh+22YQT4pNen2C8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6cK94X3tlfLbIf4lZW9KtbdT5e0xYygv+mMv5s9Hi02VuO/0pQ5diLEWae4HA6Qv
	 xAEB+MNOrwBVQGqCoF4RJrIP43yIQ7dqv+Qj453LLu5qBy6RGqgr+5WH/Ip3lvpHZu
	 ilYmvxZB1sGcRdbXfwBW3Qvp3qLblqsF9ZkZX5t7WzZmZdJLZPv04jH6YOABaIi5/p
	 WLhDiyLpk5qfmW/B0wMhywzR+DDBbf3+6AFz986aR7PW4fLEF11fGMx7xC/T84nJhv
	 hJ6RlvyqhE0iHo/CnIZOoKGPkekFuIKLIMfu+GLZtQCQpui4SUz+dWCunoOtiGT9mp
	 1PmRBNj6MdjqQ==
Message-ID: <sashiko-outbox-183879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-4-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-4-6f366591f566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:17:05 +0000
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
> [ ... ]
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com?part=3D4

