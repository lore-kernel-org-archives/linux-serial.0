Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444287;
	b=c2XSvll4hDkqGD2GQ3XpUJGCWB/x7maz3nesDYnIy7L2wJ77byiJ8W6pRPwVjSR5n5Oh
	 7lBLr8Jf434cLJQRDIcafaDkKmsfM0O/eLL5y25e14of6v26xEZVoAC5bifQwcInYrSlx
	 bNX/MV4nmyUiNesazoJSyUlpwfla+8yMZ6exHNUTo5+va5wOWDlgMTnPiFW1mSheJIXRv
	 FH3DYLvj9kHLnYPZj5+runzJ4IihbilZB7LJ74Cq15JO8LtpR3nEEp/gwydIxqS040u2s
	 o26tGatBXjpjHxcvVqE2Ji2rdj97SiNrooaLMiF1hxkD+hzwodf5UeSRdra5tajn08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ly2BjLWmj2JjNwYWe/ZdUdRWiClMcD92BjL+iV7LfU=;
	b=Wz/b22kCTIzfUT3BNP7KLzJsWiZi6NvzlarS3OZJ7QRBTi1xK5+DBGi1YhL5FId/mH1b
	 Im4zG5/9/fsbyAnwSkCK7V5+Fs4O6Stb3deUECjhZ1Z3TOv6ZauTHiD7IQD9N6SFFjPHA
	 c53KUrmNvL1ojy4PXiieFuw13NHO5miHzPDDS3UER7b3XiyN5NDg8COm86gizaLhnQ1rp
	 WO0ivTwT426fqqJCkqt2dikqgyguLJ1kUs55AOY8XbovNWQx9KHX1fHovHpKhXR2XFb6N
	 tQtO/CpYt40uJw81oVBT2g/3WOo9w+DvGHIdWTPnHFDDihUDexNaAEja23y24vSB0uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RchNDmm2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAD606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RchNDmm2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179B01F00A05;
	Thu, 12 Nov 2026 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444287;
	bh=0ly2BjLWmj2JjNwYWe/ZdUdRWiClMcD92BjL+iV7LfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RchNDmm2gcgRra6mED5Mp2vzgsxQ9vcBZiPVkegtn2guKYLVNBLnI1tBweBR0pywA
	 T8P0naZNUbo/eM6mKxRQtcDXrcFhBpth3oGh040nElad2U2YL6gYpj2CCpYdLpSR6n
	 z4kO92GXyoOLl3i3izn9bMqbzq7YoHW6E6IahLDZsl526KNARHD+pVoSvmucPh/3uV
	 k2su1iQwWI/XbAjHy3/M1jTHCGpBCSKg2pt255SU9Ovj+v/rWY9rrQSqUAayWJ3uuA
	 CTIxogRt82eCxwqmEk8qyNwLzSqg7DAq2BFTgYE4dgLWtqtEJDErHkUO570/9nOUjB
	 TLjyWxkH/DxGQ==
Message-ID: <sashiko-outbox-209982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/8] serial: 8250_omap: quiesce DMA IRQ handling
 before shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-4-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-4-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:44:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> disable_irq_nosync() masks the UART interrupt without waiting for a
> running handler. That handler can have observed up->dma and continue
> using it while shutdown releases the DMA channels and clears the pointer.
> Synchronizing the IRQ later in serial core does not protect those accesse=
s.
>=20
> Publish the DMA shutdown gate under the port lock before the final RX
> flush and interrupt masking. Have DMA IRQ handling check the same gate
> under the lock, so a queued interrupt cannot restart receive processing
> after the final flush.
>=20
> Drain the UART IRQ outside the port lock before releasing DMA state.
> The lock excludes competing RX processing during the flush, while
> disable_irq() also waits for a handler that observed up->dma before
> acquiring the lock.
>=20
> Clear EFR2 after draining the IRQ so an in-flight handler cannot restore
> TIMEOUT_BEHAVE after shutdown has cleared it. This also waits for the PIO
> timeout workaround, which updates EFR2 outside the port lock.
>=20
> Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for inter=
rupt handlers")
> Closes: https://lore.kernel.org/r/sashiko-outbox-206203@kernel.org/
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D4

