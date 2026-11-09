Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197019;
	b=wMNfO6go9hP3reWppvDepADDF1i44OUu6DA3jjVvlKTfaGJm4gJFTPVut9MW7Vp7RGFP
	 r3O5nrBjxW6Y02eveo8aIa/LFUDGjaOAT5zVC33urUk1ZZJItW6avP1EPCshNHDNXOKTR
	 9vxTngIMJzk+5+9BrcMA/Bw5sfA22C8nBlD3v33hv9aVGfSMIigDLMPvREny7lz0LtsSz
	 xQfC968CZDFq2AWa9kt+rWE3oYZp+Naj4f/eaf1w9MwB49WKa4IM2XKxHOd+cxdji92nA
	 TrCWACRNnrWBOA8i78rmyna8PkYWvxx85VzQiLwavXCTgUX18t6JbbfQmuZmyjvo8zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9R2bmQVWP5hRw5GT7HTopzEb1JjS8yyaCcEzvs6zQ0U=;
	b=3j17D3zmD4YmAtlmXoAoQy/2VwdjqiKR8e1OKoljpLZPbz4hMrLJjF0QanpjUr1OUE00
	 Es2oPZAduRgFDI1SaMrW2byyw79q1N3zGgmV8Bx1jcgdhf6TlgaVIxJaYHjPaaHVUgdr9
	 opxX0Dk0qD1bOx496U12IF2NJSkB08yd8rgKCY18/bINiZmrjuBAcnD0SQxqkE3Q91Ljm
	 V7/o+6Z+fmH7mtokm67yhxSAcpUouG3bwESIUQXNddY/dH+FqW430N/NzSzr2lD9mTQdX
	 BIzIrx7eQgmI335v9Ofs68XZq9RStKgBHwyyDkhl15WiebO5GmOF2FtXM3HfZsTYYeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmURTPd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FA606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmURTPd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A631F0089F;
	Mon,  9 Nov 2026 04:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197018;
	bh=9R2bmQVWP5hRw5GT7HTopzEb1JjS8yyaCcEzvs6zQ0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YmURTPd3kx+hMNW6+iqIUjDm4ReOmjQvLpawqYw0v/jVTjnugUtow1tt6ptxcOR84
	 cUis2KFdJQJbWqGLsenlwpxXv8GvLsqP2duYkk9TCoB4IL1e1zP8L3QzutZABUN+AT
	 FGanE452MNOuXWgYNm9FjuOQ/ISNK0Cv398GwqJji5PI9khSvRQbWRet5jl/yAFn01
	 b/4lf40P5n0geGG9+EjpAA0/VfFCqMTGRL+40gXz/nilifWBswSikvO6o0VZIgoPHY
	 h/93y8xINlBflWI4nfBm9oItF+YDdNT0gCUI1RE6n4RZ9vkqBu73csgpenuSk6ZZlz
	 WtIOsOnQEjCCg==
Message-ID: <sashiko-outbox-204390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-6-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-6-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:03:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D6

