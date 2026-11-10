Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280820;
	b=D7es4Sss4Fcv528o4pPon6sE/OaeD+Ge0OgU5oujEQ4S577qiHHNKLflMay2cDdQezeP
	 Zx9aPdDEGZOiaXAtR5iBpw+7JxMazULwqWfXnjWlbgaXaAAqF8nHhW/nCIluFCMQOsTZY
	 Vrw+V4NnZwB33m5lrClT9J43nTC2m0eQiXYT4zbSGB724Fvomm7z5Cs4rsdn7+Xi1djWo
	 9+yolUTsG8O4vHJbv5BYARdMbjYyTfOPmRTUt+5aGm0UCMJFWC7dkpc1j7b9sMo7YUOfH
	 N9iEai1mElXwKvbvmj4X5nSuErsdHQhZ31CBHknjhlGAeaQ3Fpd3qzreoVAFqRY5Yzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5NDCoxfWI2LcUpTmH1b7qNPNdQYWiXWXPCceg7SOz5Q=;
	b=eM+zTJk9IeVJR8oMY519jYBivtpNcNTXxlcpoJD+yl/Lo0SwpM94XMxw7npeVue4vqOA
	 lele3o6cWtuCdOr1+dr1XVUg7RDNJ94YU7slzVCM2Iu3YhNv0zNZUXQ4VPBnEO1AIUUDn
	 IXrqQ+HH1SO0OIEWqS6sbeelkd5DYAcZyix6lnRrmlv28PwzzHfDKf/aMbDxUjPP8ZoKN
	 U4A5AkJfBB0ETkAfpNIZFb0k3paeEljOgRkGOau1PbkNvpiQPCSyEfbUl3ZageCJ/Bm2S
	 HN5tsV95mmki/qgcflUjphx2ToimG1Idtlf8Vpe/MHit6LY9FywT2c1yxC1jFQurQwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQjHgzdj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9B606A331
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQjHgzdj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39C41F008A6;
	Tue, 10 Nov 2026 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280820;
	bh=5NDCoxfWI2LcUpTmH1b7qNPNdQYWiXWXPCceg7SOz5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQjHgzdj4rzy+GbZW0fdPKfAk7r+Zh99fE0c6yL+EN3QHF1aKOfJ4WdEN9jzl2ehM
	 jUP+4p2svVgqb56Ldv+moqtXgfmQNfD9YCfzWSHy9tY8+zGzWer87y6E1hVI2l7/xT
	 22RGElj6DSHu12CGFhjse5w70zeTfzbKyJar4m3Ov9XLb3unNwTNqMitTviF/cP6GB
	 S4IDyc/mF89uujOdDZ1EqgKRJSV6y+JIqu7D2O3sgD5LfDn3lwmoBO4opn8HPSV847
	 pmwdi1UwpB2clHOsttYWck83RuQh7z/fYXI87TvqGkV5CpE2kxrzmtssYUj7h2wN4f
	 e4PD9nU7OKmaQ==
Message-ID: <sashiko-outbox-206107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/11] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-10-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-10-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:20:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration, also used by A527 and T527, has 64-byte FIFOs
> on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller repor=
ts
> its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
> offset 0xf0. The field holds a byte count, not a logarithmic encoding.
>=20
> Read this field in the sunxi setup callback when platform data does not
> provide a fixed FIFO size. A fixed size takes precedence, so H616 retains
> its 256-byte configuration without accessing FCC. The probe has already
> enabled the clocks and deasserted reset before invoking the callback.
> Leave the FIFO clock-control bits untouched.
>=20
> Use the shared DesignWare trigger setup to validate the depth and build
> the FIFO-relative threshold table. Invalid depths fail probe before
> registration instead of producing zero or truncated thresholds. The 8250
> core derives the transmit load from the discovered depth.
>=20
> Select this setup for the A523 compatible. Like H616, this integration
> has Allwinner-specific debug-divisor and RS485 registers overlapping the
> generic DesignWare feature probes. Use the common sunxi PIO setup,
> BUSY-safe integer divisor programming and software RS485 handling. Keep
> the APB clock gate enabled during termios updates with SKIP_SET_RATE.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D10

