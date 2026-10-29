Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301893;
	b=buVbXUaxoU9uatgqkX0PAFo4TRKotZraewr4q0rCAEq3hr0wg0ZKHAGNuRH+PtRY6t73
	 ylytM3b9TcrggoEX4WAM2vDcjBtoihdnv7VACBl2kXBHYKBjO8yBO793OB+dOzefVpUVa
	 x0Xj+MKXN6gD+dFe6z6yVQOGjBKPoUzzoGyo0zlcbxhFU6p45XlKtcGRfvK9AAPSrZMeg
	 xGBOZseLNZYvEUJtGGb/5AcsDTjE4s61ZtZ2CCfzyeFs0RBoUWeXdWIrGTdqF/fmy/+hD
	 Drjd0XyVHixcJfy7DVlj4DM2C5KmwKcp/DLxlkl5uNJqlT0M6mjd2dA1Oa6U3cblqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NuYro3ObmaPZlwSnsinik3uNUORaLcmokACy0MMbQuk=;
	b=2wTfTJFazr8Q7MrN/hlqdIbiJ19aKrhUIS1qUukwlTdYX2zz0iqSx+DXMx8uAwQC0jWy
	 14UC95y9BvgY9LwwxPEQq07AiA+43x7xW7SzAwSFhSyA2Sj3ti93tOCnfj7gu0EsZ/1Hu
	 +MqQN3ndb/MfppB/LYSY36y1Y9bgBlmyScRydKRrCNoTHibt8geCMIR4SEwCSnSPo8P1Q
	 EkNEAI49wIw9n0JxC8XDsLDpKzrwRDTFXgYRrZHNBWEyaF0JXXO+CTl/kA8r3Z8hD71ZV
	 uCZFeztqJ+OcO39vXTlAMSyV3d+VJT5aK8oEU9x2jAVdMu/Mt7+nc/xCWZLKIBg3EYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Luh6bX83;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10F606A31E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Luh6bX83
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D481F01816;
	Thu, 29 Oct 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301892;
	bh=NuYro3ObmaPZlwSnsinik3uNUORaLcmokACy0MMbQuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Luh6bX83qlefxj0JIgkzgKoAsePK7VqhF+GFD+oeikjTWqRUfPqSwXmt0U6PNB2jL
	 x7DULLlO8XCA0WQ3TnLLbFcvx7UziGx2H6FMmoWexsyBDnKEE3V4soZGMgzeR3Qkny
	 RTguYw8Xhf+1LLsex8x3SaHHvcKDdZAcqP92yYq4rtC0xjNR4W7D2iXoQQmAWdumhM
	 Co7mC3XKS+k2R4FHKTlvT9Gku31LIRHxmjBw7jb3G6AZzGFp90q5mAD3Xpysqd3v6t
	 STu7gEPF7vbJ5Ra48qO4QH391QvHhDO8t1O+mIF9pLv9BD8fpWk9TP8rW1M8K8oS/E
	 2E7TG8Bi4vYhQ==
Message-ID: <sashiko-outbox-189873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:24:52 +0000
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
> Validate the depth before generating the RX trigger table or setting the
> transmit load. The quarter-full threshold must be positive and the
> FIFO-depth-minus-two threshold must fit in the byte-sized table and RX
> trigger API. Report an invalid depth and fail probe instead of generating
> zero or truncated thresholds.
>=20
> Select this setup for the A523 compatible. Derive the transmit load and
> RX threshold table from the discovered depth using the common sunxi
> helpers. This handles the different FIFO sizes with one compatible and
> one receive-trigger mapping.
>=20
> Like H616, this integration has Allwinner-specific debug-divisor and
> RS485 registers overlapping the generic DesignWare feature probes. Use
> the common sunxi PIO setup, BUSY-safe integer divisor programming and
> software RS485 handling. Keep the APB clock gate enabled during termios
> updates with SKIP_SET_RATE.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D7

