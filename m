Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779748;
	b=RbR6nZ2EONOjprquF7kFaEitmeOmeLgWosI7EqANu0zcADlYCbuku1bfD2WwJkohxqL9
	 S7gGbv7numdxoD7k9Lr2nn/ptPyOUlFmwLLTnSw+EohE57ddU0/MgLFOvgYVNpdFqCp7w
	 pDYhrXtBjjrgzx+TfFRuVgrTNuYuVs2VsjYRsiflwrnEF+pchZQ+l0QsWJcYrR7cHYG/K
	 HFwVjEY99jrPqdFtGNmMo64cdRaX1tQTJcrzNiQX3AaDDr7ihOuQu6PiABBz5n9vOlPc8
	 q4byxtnl3VxbEtc/LAIukLQTFsXK4UQX9Ry9bHCd85V5QQ6vboBhJrLo1tihtHzTc9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779748;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3FOKtYhNCcgemcNuuixVWDCFmvP3jWhp0dgF6wqw6mQ=;
	b=bvKHyOh+duURQl06E6byf1M/gcLpMzeh1AEUzFS4l8gKacy1Ct60LrSei8dW3EZagNJ0
	 IbACaqgX5dJTzpiDw6uirlnD9iRQqu78bJaaflbhD1u1rITu/cXFY3UtxebW4RItPO2aR
	 greCs46so+OeoWdhJY3ryyor9NvzhkxdGHEUQWX+eZMvEqBSMdcAlw9PYjPM3/FkqJi7p
	 oBn2QG8ddjwpaVnAAwzAuMeihda56i3TqQs+/sxTqMtaQs826ZPvTsPBarXvErhui+YlG
	 cGd+7iJMhSRNdFH7d7vwIQ1DwO27PkfHxi9tB3AuaHQA/Tcv/JV8EoKMssbs+JEfGCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vdpkf9fX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910E606A322
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vdpkf9fX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C681F01825;
	Fri, 23 Oct 2026 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779748;
	bh=3FOKtYhNCcgemcNuuixVWDCFmvP3jWhp0dgF6wqw6mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vdpkf9fXl7VZn53XEWk9m7uNMQRXSP24JtOVCi35pbMw0X4lCDO9mgqn5S8Wlx/TD
	 vV5wfU6imjl/O+cD9rkwa4rrmFmiFZryQHUG4iALDgszptNkJbCPcNLmNqV5oVaEU4
	 zAo0WgvKfbdRgcqHMB9tMWlCXGx3yjrQ/ql95Ujxs1EEU4y+7t6sdBu3RMWBHkXJKX
	 ahpbfKi+YNFjkPt+zY2JLSdCgbAJwpcti9Ddq8Y/giPaE6Ro7TH8R/tSxwTB6ucwPt
	 JCnWbDM3qGBFPVGxntpQP7ZRtnyYA/aWZ55fsNBrBqe1v7i6YNq8BCl8LvlpUVLhVY
	 YwGCu6rx6QXpw==
Message-ID: <sashiko-outbox-183060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v3-3-d78f9e4c4932@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v3-3-d78f9e4c4932@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:22:27 +0000
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
> delayed register restoration and transmitter-empty handling. Take a runti=
me
> PM reference around worker UART accesses and drain the worker before
> releasing the channels. Shutdown releases the reservation after stopping
> DMA and unmapping its source.
>=20
> Track a flushed FIFO separately from the transfer length. If termination
> fails, retain the reservation until normal completion and account the
> completed bytes without advancing the reset FIFO. After successful
> cancellation, process a zero-length completion once callbacks have draine=
d.
>=20
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com?part=3D3

