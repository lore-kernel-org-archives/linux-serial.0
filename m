Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662083;
	b=1zVaaY7HtIPPetSFrnd5FYcmOy/qM2IVKzTyAJe0b8rvew7Hu/qPRAjeRW8k0Jl4QfKx
	 /M07PZAASd6SneO77iQ3unF93UqLUTpEoBdpRE60OuqiSEZ3dEzo9w2T/eLqq6CFst+d5
	 Tc2Gjt2HJ0SZcrh9OQoVJ+cJCMmUOcKc8tGc92V8P8A02YViGLA8pvRm4U2Emng8fUHxT
	 ESxHd/92Y0s28vmO2r/6y+Okcwh8WVtuLUSIdCvbfKiYTlhAtM4jActlhALOpXJombTqJ
	 6uL6grux/sj40RXGnHVpvCz1ecZMe9kl6R8aNZ/jesc9g7YZZgx8j3MEwfG3InWCO4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662083;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pdh2PngBKJewVaD11AxV4Hmv7GZdyASJ+R4kwdKmO9o=;
	b=OPlpxlzdAXLi8Gtot4VWKR/B+F4IJ+BDfMSMtJgbOTpqy/3YRisGZtypdOQWpJmWVEXL
	 AmXFJJeY8UmDD2c7KfvQJAce0HGz0T7DjCLmpH/xbPqAA8v8Ql4LD+Kl6ojPdp/r3IGKa
	 dUaTzJhQCgKk6Q2djHMCc2GoXAAj3nTf7n+2Q9u24M6O+z+ollZHlgkp2z6O0NS4poehY
	 Fy4ALSD2R4y4l++e4BHHJzgy64Y6OTZNp+VRoHU86VStXxGVphjqM8ZozomWsTFRP0pqU
	 yogH+ceL/iUEPeXO//2VsUoLZ6IS2K/Jn6M+Npmtfzvo53XESFW67QVmsrZZUgzeW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGLyd578;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015F606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGLyd578
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D91F00A16;
	Mon,  2 Nov 2026 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662082;
	bh=pdh2PngBKJewVaD11AxV4Hmv7GZdyASJ+R4kwdKmO9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGLyd578tWA6NM8gO0RU34kd6cvCukTDRUQ5xFBPvL/ZPO0Ea3Mdh5hIK7GFMz/OP
	 F8k5praMb33+Jwuc9Vw7jCGBtwpDaJxFElyvDIwFoM1IQHAM+aU9C8iHxOoU/kNM8O
	 QCaGFGuaZNIscsEfHDRR+yufN9WCte3np0HR/E24zRJnsTWzgbQBJg7qayguZsSPYf
	 FqB+au5bBwOCaYIrJLoZeUjjeafEbju43oOYT2SQ6tCzIU6ITLxYbCeKmJ1zV/M0Ph
	 nH2VqTQBC8norx3gWWudzABYi2kF33pawGdSLrU79sHCs3XaV5WaLOVPi3NeXiyhnf
	 KcQxEMoLsPyWw==
Message-ID: <sashiko-outbox-194333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:28:02 +0000
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
> dmaengine_synchronize() returns; provider callback-lifetime fixes supply
> that guarantee for controllers which previously lacked it.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D6

