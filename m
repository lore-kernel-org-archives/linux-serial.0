Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446372;
	b=geEfaQCCwOBHfT91z2KWYt5U+3TbDalqYe9wiYUK8dyccRFiHETJwwK1IYMO19xSFzmR
	 83ugbFdytbSYvE63eQJ+Kg0AzHBSxzBRqme9gB6sfBl6PXd9tmfMatMvEUrFmCQyC6A3A
	 2TybM/3On3QUvoyeOo9BfwBlOsA+1+9h3bqqbGEvbPlu+OeBt7XkK31mVCDbAGLw9qcFo
	 ZwDTqTo8Iuu5wJdAVwxaI+V3DFUl7CCNsbt6QJXo4KEBXs6rdXCED3eVsTLosAGu3quZP
	 srd/kCTDkJGLga+TIugg4nzKCq0GdMuLsHoRX5+XEMMaqFKQeoxj/yA68xtTLawOzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dqx1p68NQHi/HdS11aS8isRZTtiI14kuleZkRF+m9WU=;
	b=SFgP1dFg+4KbnmLNhpuvohhpUbM14O/dClQeyBbZHI8AjHQeSKMYlYTKmFXJZF11FFUJ
	 Z7Yu6rdi5PLCZn0HdLgm7zoyBLQvLJJGC2k0G1qW8wp/0+lok3I3SpcplPJDisDXinvBx
	 UU5jq+sxH5QAs+V7dFNynpS9Ivk/tXVAR7qeUDHk2bkVNPns4dH/N8OjtqYUfwX30hdCR
	 CZhKzU5zZ0PrWug1pqkZmp9ZB37cYYbKKGaVpInzuL6EgDGqJUhiNQnJX8qnmm5ZZLgKW
	 MuWfjP0MgiYLwd20LyuW9CbIxr8NVduvr+trLsbhuWqNkjXngH3sRmHsVp+eInDdPcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxolSD+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B5606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxolSD+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F60B1F00A06;
	Thu, 12 Nov 2026 01:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446371;
	bh=dqx1p68NQHi/HdS11aS8isRZTtiI14kuleZkRF+m9WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxolSD+QT1ELPp6Tq3DLCsZ1ME4pl5yy2frvbfmVpTC0jsgpj4oi0FcKgXXfk5+2f
	 GjSQwpq2s94hzF5xZSnRmty88pInh5cN9BI5oBq/5qmHcwsy/N0RYdbrHtqP2sWdBq
	 ypat3YldpF09qrplRvY30BOWCUHNjWFLGzK+eYFSF1X8tGH8J2BPHKiqpVijbcFZa1
	 wAnOkAMIBGEugDge0jlL+8Sz669VlRAeBZPI/jqCMyEAFf9EmEH7gvx4TFVv1p15QL
	 hwN1A6TJ1p0AnhEUfcRx02kO4+Mq4XiDQJGqeSrMbMpxj8JqQbPq/m5R0IIUVCB6LK
	 tA0P+D9YQG3qw==
Message-ID: <sashiko-outbox-210061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-6-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-6-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:19:30 +0000
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
> tx_running, allowing a new write to replace tx_size while a detached
> callback has not yet run. That callback can then consume bytes
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
> that guarantee for controllers which previously lacked it.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D6

