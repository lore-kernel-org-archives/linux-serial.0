Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873960;
	b=Q08jsj3ZUAFxIRAf2Xe1dxpXsS7yvNUIZiTelBl/aBD/WFvqwyOUR8bEthlQ9iCu0oy6
	 zFLfZ0SKpk/X5dLHhVsf8S13UqqO1HZ4pGcbcyxMu+zS4vrcSRT9eje4FnpxyWCbRM81x
	 ULrc/wDJaeqtP4qNXtaWPYlIBq/la3vMGlQydQWN4zKCeyaFkt9KB7gHFwg44g/glOUof
	 m0RHCJ45iRfGiliqRQZyFlVLdzRI3wMY1+MYCwxDvg/ci8EfQ2fWPHTb56FOauT/0mUwr
	 xiWYIzG1sha/PvSSqu9K2nkcjELDI9laxpnboXc3rJW3uKIMxKS7CnG0edntgw3BKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tR60Wrc0DLe6xHXIHSqCVXj9XGzhpwYSFR1749W0k5E=;
	b=a4PH3d/70pCgSH4vM2FQbpPnpgo2LL5rkpld2gtYqKL5N1iMHykFV/2PUzjefnxKO4HM
	 XCvmfBJ4gCEj+2BVSdoU77VxCZjaPaXGdut0t4HbxFez35pF7WGY8HoJ4i2nKtaYw3vCS
	 yCC6l2U6SdB7GM4rFX49oPFqv0ioZDkBb1WyKoo3UzZ2SGkO2EkJ0dKxKk1EsrM6EQoBd
	 XtbewnP4HDY+xM+Q4ZqiYL9DK4FU6+WE/YsjjyTdj+u6eDZUB9bgJKTrnJn3IL605FeS7
	 bYdlv3Es5jCsZSA7XRYzAcgKEUZ406wJM7lclITbvUooxRVmeNyoAnz9x6S7x0lZbsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REBu0Jtd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B25606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REBu0Jtd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358591F01825;
	Sat, 24 Oct 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792873959;
	bh=tR60Wrc0DLe6xHXIHSqCVXj9XGzhpwYSFR1749W0k5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REBu0JtdiP1otUqU2+hQa33aSxjtJAlVXL3+XRJ1nvkqcFk/x6KUvmM3rXseteUCP
	 z+v67wnrtohCST7oW308Ofs+7BE9+a4AYxP4xrpDxHT+S9OK1X51ZVRUhYELwwQCYd
	 DyNeEZlHu6hqtxhcHQ433K0Deqmj0vjFhKpvkcyz7ZAso0ye1D8SBqWmy/4JUWq9oO
	 6QyrnpSkG3C+v5YZsiNZHjOzzM+tvQidZdC+31cok8eMdxnp57dXIYM6RJikne0Lvq
	 NuumJFJM6nZfsA2ZFJCa7RaFtSkty3vErdklYofdeirqhNLj5HeE2yl8PsEKCkgZiz
	 bJaGUhYkGKtrA==
Message-ID: <sashiko-outbox-183873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 20:32:38 +0000
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
> Keep PORT_16550A and preserve the FIFO size read from firmware by
> uart_read_port_properties(). Use it for the transmit load and derive the
> receive thresholds from the documented 1-byte, quarter-full, half-full
> and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128 and 254
> bytes; the normal 16550A half-full FCR setting selects 128 bytes.
>=20
> Serialize trigger changes with termios and hold a runtime PM reference
> while programming FCR, preserving the FIFO contents. Propagate runtime
> resume errors before changing either the FCR shadow or the hardware.
>=20
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> DesignWare termios path selects hardware CTS handling, so the capability
> must be present for the corresponding hardware control to be enabled.
>=20
> Select the fixed configuration through the platform setup callback.
> H616 has debug-divisor and RS485 control registers at the offsets used to
> detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> those probes and retain the BUSY-safe integer divisor hook and software
> RS485 handling.
>=20
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather th=
an
> an independent baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-h61=
6-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com?part=3D3

