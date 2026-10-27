Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145226;
	b=jqPQbMVIp3V1OAaOj70xA/0wOpPJsV+lhm41sgLxlvNYbOJ0ehh91a5B418WTsMCApIz
	 BkHRnWm95cBXYX7LjAmI9pRJ/G/E3FtP9jGSlPiOI0+mzm8qeV8uydzaoxZCZ7oyCeTU6
	 w4VxIYmAfJhIqD6Ovg4A+oH8d73hbaPhCB2a70IYP+8S/7aSDqt7FgYYYdOpzhUc9p8XU
	 NHGak3MA1q6fh6lfi2298BUSdBZIN/epO6guWWmvB8kVA94NgWdDF5YIwY4JMfIzvff0n
	 altYKDYB+mo8HRcoLjTTR9C5cWTSvRGvpSOP8Bzu4jvUAEN49kss1x9aWfjz0CXwk6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oaxrxOZO9V84re9vhTy4TS2xj9ktudn5JqD42E+BQCQ=;
	b=LRryxUzKAQWvMy6knnKdIwmmtRyKTcTKi/k8HJr7IJB2XjZYiNoMKstpOA/kfRElhi1d
	 RKJeiiKygwd1ITzgmdEmGI/azFFnG8B7VzNsNSgb6bWnC4s0irXKdpoe/b2aets1rskac
	 PokarNWrHiNAvgm1O//YVHaHhzybq5uQc1DIjh5UCYq7Tv0SXxqs/YeKfT+jgdcsMoRga
	 g7MM8bkAcqoJ/aaLdDSB2RN7h3GYYF6o0/4xMioSNnAmPZRwRLhY3lPwzQ/MkIEPIs4PF
	 9sdLPNIUCfw+b03gxeE3a2v+KezVa5BTDi5P7Ik+pOhyj+e1gsdwNXOJlHmtQhgNM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrPZyJ+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A3606A31F
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrPZyJ+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D801F01828;
	Tue, 27 Oct 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145226;
	bh=oaxrxOZO9V84re9vhTy4TS2xj9ktudn5JqD42E+BQCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrPZyJ+9aL1j5lig//gvyad6w4wXSh9f+BRnbD/tbfDwAvIyUvsIv13jDPRhfl6vc
	 3xCUHaSIOvHIOrR7fog/+R65XmMzZ80Oa8Q6ChAIQE9vE+AHe1WbPiaGp+uUra5xxu
	 1yJrRfTSY0lw228w89SaL7UW8xWrakhtVEcRio+pcJbD83kpKo9geEt9VWPbqgYkvY
	 AJy6FG3SXtXos0AaL11H5Kmi3fT2Jg0kwMVg9bv+4fXMo2/0hRVeXBX0krW38KSwvW
	 KeLtAWSVVQEFnJkY7FpUpOVwPxlGNQew1QrJbbQwfMc8SA7nBIlZVRwctBPppQMp0G
	 ScFPZ4dKvFvdA==
Message-ID: <sashiko-outbox-187241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
 <20261027-submit-serial-8250-dma-cancel-v1-v7-4-985a023ba4b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:53:45 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-ser=
ial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com?part=3D4

