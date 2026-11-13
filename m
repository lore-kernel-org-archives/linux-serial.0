Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565035;
	b=peYntvE85gyOETyOyWybgKW+SrhaeTaR+1tWGw4yYKJXHt5M56e+rrKZ7iktDA7YTDCl
	 fq/SphzRYKiJMDwnJ5XNZ1fH/O0DcZFj6wI7QsnWlD7cmbUwLZhanzakH8L35jUm9Ank0
	 yfnAy0U9JuMj/4wGOLrij9ibX4DsuQvd0HYh8ld9hbEJstiq0nr+wH5USG072mImi5ZAV
	 l8xTemuVAOIGDJGCWleY34CNifys+1eAg0IH0qEucnIUEdMNU50w8eaQz04ztCIquRJZu
	 EOu152Y7evxN3bDIjsDsW/NZ2u/36NTeMKkc3DnFw6Tab3vX+dE2x1H40xDiNu8Samw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sMzQnGpiMfTW2RIxNPSr49InCJuU3AzMZRTXpLCeCrY=;
	b=u5ij/KceFRPrsNKTVcMLyMgxdxhnu8eQn3/wFaZZ/1Ya8J0OSy6yeg91a89lKI+6t/J+
	 UjhKv6sDjLjGVG8NsbaEsxpewkBkOQqX7QYq2Bl22o+bILfOQvTEqX7MblCxsyN/MRW7X
	 osQNdblVZloxfqszZH4LHgJ5qhJfZ0Q0Ft+7aZRBHwA88eUrNqhTXU6Rx32yI1skKpCaO
	 Jp1pczAXcq2mwn9c5tm8vlRHUBW4paN4OEkKRt1Zmep1z62lNGlVgh3DHynKBx7G8InuY
	 pwpoIi5QBNmkST4P8OhZ4tPqMQ1rRoGps7dzc6cD0OKqyiy77lSJuVz2zcgugQCA8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZBFWLwV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FE606A32E
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZBFWLwV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29431F000C4;
	Fri, 13 Nov 2026 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565035;
	bh=sMzQnGpiMfTW2RIxNPSr49InCJuU3AzMZRTXpLCeCrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZBFWLwV7B4zN8VDP+g13iKbfelH3qRYWukqu1srpV4L2hPrJoFbhVPJRTfa3LgWf
	 h4ResBnccJtxeZx8oqjux/DhGQjeSh6WGCw3ZohyQczwnwEwk+zl9gCpFA+xrE5I6t
	 4Yo4xI1kvfiXBWnmCI5LBvxcclGHFn6ZFl6VUnx8nERCN7CiHwECU94pInRKRTfYQJ
	 xCZA/55ph/eUZACXjqE16J9s+aShhzlvbtPPunElgoiU+XqzagaNYitZizjoDMEwPm
	 iSbx1IW9U2oZgUfvWDCN/zmt1TWuKPSHTe6e4kYFoFeaFCuH+KA9tsjCxXV6h6l9z6
	 g5mN+q+B7l1KA==
Message-ID: <sashiko-outbox-212613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-6-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-6-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:17:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D6

