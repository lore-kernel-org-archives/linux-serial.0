Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284986;
	b=LKj+/nVxTNLkVmit+U7JWGGeR0gxPUVi07U86NzuiGal2LWf53QngmdhRUWCUIZATj6H
	 w1Q8MV7Fv/u3K6Zpcb+/+FCh3fxmWz/YDuCaqI1Kjg8AtpCO49pGfG/lpQ8HUVx8kn7xv
	 63udfZErqFaHrKDEHZ+sTDzIM8V/hvRhLe25SYws5oY6zrTi1HWWucT6JxgMT8x89LsFK
	 Xt2iI8wYx+m3+btF21CCHU8YIRs+MCZXiqexgp8pkixIlSQu0X+aTv6C2Be6cWsG2rbjt
	 X44/2c72KKXncCRyk11nBaxuZ6G0A9NHbBxVHWv2oUEYgahJ4ngmrvnSOmnYRZO7u8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZforaX+2SjUqyv6wtky6VWIJGMVO90KYrx/8MiGzw2k=;
	b=Lr7TGWGxzogfP1bancHp2xK4kYPLdRnz7Iv4a6B0HqFwNCas1eVDgjgERmVHIcOCtTmI
	 hpjj+I0tJKvcpsKoHEjqfgio18yZ+8zuqwzsHDLUMaVrnQgqL2Qho410weCepmAaXFgwN
	 kOI0xmLHiX87azpm3IqqHxeej0DImW9A02W8L/mLxho2YYXUDbMtfm2zdEZdoA/gt9RsF
	 4jpduNi7+DJVkgb4emqAxMHH5xkWz/vfSt92bE+1CyjeIYDwb0AdFRpA5jtyzJdLI+hWy
	 RLiliMrWiXIOibJvmUYXoP6H3FTV9u+WZgW5pYjqt5GWs5exYOufUVx/bvp2h9bJKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfiMCChk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A4606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfiMCChk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208021F0089F;
	Tue, 10 Nov 2026 04:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284985;
	bh=ZforaX+2SjUqyv6wtky6VWIJGMVO90KYrx/8MiGzw2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfiMCChk4J9mdFElwT6Morh7Nuri8uoQ0xFTseK72MZrS6XIr7CrVAO1t2dSkQnzl
	 X1aVlPq3a2vwaBbHxQQigOdwKAs2XR5So+x9Dub4IZUJVmtECVaZwvL3Dbd9XJhb8B
	 mZWBT8L1OBRtuYsV1wwnV4nPlWwuaVnvJyazBWrQKSsPComtD9pIQ3fQf1bCP2nEND
	 h0jOPkC6qHkFu2kHuBVSeSpyQXgQsrFFUJHGEX8VAuK/UPgkHqWnAhq5/n8DzIe++5
	 KhN+hzKep6i00UUWqApuQaPHCUTARLEI2q44QXvAP8l8on2UdCG3pVvxt/fffDjaYJ
	 xKhLUyhEVf7Lw==
Message-ID: <sashiko-outbox-206204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-6-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-6-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:29:44 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D6

