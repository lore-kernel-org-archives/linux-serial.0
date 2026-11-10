Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280914;
	b=rL/CIU8CZCwnyqGqjLwAkzWhxwHI3JUYrxYWpihXFzC8HFM/6Oe7ugKCGIZN0lLRlIqL
	 WNt4h6rnS8OX4EwYxcOasqZkHcd47nj3nFHkxydIg/f3rPUKggiv3t0vFzhBWxLZf+VgH
	 2urhAszjN4G0qb3Uu5pSOXkPLehYyVCaHzs/f/haYfV4s0ZKXf7Kr61mkhtdi68bOx7oc
	 uK1DsomYtJAhBB33me73pAqbrIQP8ePuBs1S/3/Dm/vRN/+8OYQU0cpMHaPOcAyCVXxQI
	 5L6ayLte/4fTHlpTfOa0nC4Pzee+28rJ0kEazQw94gsbxCTPaUf9LIy/k9StZOfaZsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yCmo+fzgHI8WYIq1SNmiQEAy5XGAM9Beu8By3PJjGCw=;
	b=TJAW4Ezd0HEZDAoAZxLtbIEPUIttnrKFA8CvGVm9FKxz9UAH+pmlgchJkRgx6AHiLv2A
	 lZrc6C6K0PcZ2cbiEhnDGtnaUg93uEZEyebjGMuz/7yM51IgBJEMANjYURZolazibFl5f
	 0HzcXdXUGPwXiG1me/10tGIkYhjVi6yp9c4MgRjRK/Kvk9scAT5zC01uM++vJc9BmnpWo
	 OzmyvMMvB8s2yt1rPudPnj12KZfbbmojJsrpnSlw2cDud88qC46fWYASf+Nj8vXUkVkaN
	 SpEYF7BblGlSKHxXDzg1JevA/rd/HlXvDod+iAgZdZRMrTvr7Zze2KUjYQbI6L845Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNIm+6OC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7258606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNIm+6OC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE21F008A1;
	Tue, 10 Nov 2026 03:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280913;
	bh=yCmo+fzgHI8WYIq1SNmiQEAy5XGAM9Beu8By3PJjGCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNIm+6OCng66X1v0K5q3bJA/iYNAYKcBQoOQh+cuLtb4+JBB7AcaUj1C0NbzfplK/
	 NZXk3ZX4ahQxAptKrnFmDApsWDasSE/1QfvKbGgF8GlRHIGKI5YDrPxhbdVRXCt3nX
	 vAjyzBrU18UfSPG1Oo8gqT1Wed7URtxF9BgXq80AOvDK/GV266Ju44OYzRGaozGC/L
	 +DPEwAXmV1yGBUUiMMgchIZrBpLEz2lr01Yj/C210BXrY2zzaSKX+m3PxArlHx3AMe
	 NREkL36Ugh4+D1WuUniniCTyULs+34MYdidpodsNFDj1AQSlFXiX9BZzOo++lPlrjJ
	 +h0Ilicg8pK4A==
Message-ID: <sashiko-outbox-206110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/11] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-8-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-8-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:21:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
>=20
> Keep PORT_16550A and supply the fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth. Use the shared
> DesignWare receive-trigger setup to describe the 1, 64, 128 and 254-byte
> thresholds, with the normal half-full FCR setting selecting 128 bytes.
>=20
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
> DesignWare termios path for hardware CTS handling.
>=20
> Select this configuration through the platform setup callback. H616
> has debug-divisor and RS485 control registers overlapping the optional
> DesignWare feature probes. Use the fixed configuration with BUSY-safe
> integer divisor programming and software RS485 handling.
>=20
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D8

