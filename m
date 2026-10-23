Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796234;
	b=DnWp5BFDcCPTCgYtmBOqnSTEZN8n2lGDsFRrvP7SS0p6WUWYIij4zCwfWPMyZmb6BZnC
	 joVf012Nn7dER9MN/go2xb2o/rhkrgRGiQ+PEl184yXtbHLs2JjIEhn1yAQDi89VubrfW
	 ICnjez5e/B69HaWzWhpXnJHKhtoacreCAgHcSGZ1sMQUnz/qFSgcrXLchTtVHK91gNpsZ
	 OKQL4r0Fq/MftwNMED81clSP0G8Wa05e5gsxatSnFnOtYSk9m3GAf2Y+HNZ/VFeuC7R1N
	 PE9PTFzkeoifXTsQ1kCJBJIW+Y7KCoGpuEla5m1e8HQMSGpzWwt247an1PSV1E3YqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WgqYgDM7g6K07howgJQ35RZZUxLjmga+F5qUQ4hFgLs=;
	b=McQfArtTZEcgVo9Czy2kn9xYepdlIsdY539ROcDtyWBhBPkwqN3gGdSr6B4M5E4LKSog
	 L6DNJTgJELlooDiOkxTfwc3NgXPlO0qHAHdbvMlwSSjFhqPK/6Hp6xdnHXYTggp0u8667
	 fL6dvyc8fX/j9Dbbah1aUsyaKG/m3jpx5OGXzT6fRlmscv3icUgPYwDeCqaCs9BViWTgM
	 1iPI8tCXh0uDEr+ln/Q1bAdWQwi8gWIjf4aERnQRyPsybaHO1HIcoymLMc74782jDxCi5
	 GIY/h/707fhLgnb1kER6r6pdYYfGyQPaICz56tZBDI7zxGxmXqRD5NXEDU0++LVymZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCpPSbPg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6B606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCpPSbPg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15C91F01825;
	Fri, 23 Oct 2026 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792796234;
	bh=WgqYgDM7g6K07howgJQ35RZZUxLjmga+F5qUQ4hFgLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCpPSbPgHtAXwPHVREkuZgHGcBTCTPoQn5XqPhH+rGbm2vFiUtA3ejQI/RL2iEUtH
	 7GFFITrjLGtGLd+a2GG8r5Dd7DKb/uUN6034bbamufX4OgGg41wjo05D3QFRyMsx9f
	 I3a0wPuw3brN1ABTXzOLOkEYG1Y+119NUhd3xFzJEghGIexyd1oXjA5gAB/PA9+6tF
	 G2bXb7jsTFFX8tTlDjcvGKTPW8+SYPRqTODyq70jmTuzpjdTd/X8pmRVfR/GTnVTtC
	 3WjBCnU+Raaq4EuNjG0SV+0KEBOAr6WtiYzTvomgd0/zqaJL3X8yukLek0/O+gKwSU
	 4G4VFG74m4lNg==
Message-ID: <sashiko-outbox-183336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-3-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v4-3-e759de1839de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:57:13 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com?part=3D3

