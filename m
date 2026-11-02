Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651360;
	b=goONGSW89SXvIOGpCkPUkIhiPcAEyH8l0Knr33n2IV5KFEwnH2eR3CK8lHJWy6aNhg2t
	 Sr9iW9iPwtQJEnKv2xVTlu5OSaMHSual4SW4A5n95yUA6ojuERrjEfCL23o91lqpSZ57q
	 YJ48lID56pwAWvmHlbuulWJyllxG3wHTv692oK1xd9NNXrW+W2R3ZZbkQZByloDu0cMFo
	 eLjXhkqmwcx5Nu1yDdpjGFpi8sE5OXGVVUBgFpXe0KEO3aH2Sb5L3LjaZTsekDFhNcCjZ
	 sw5TV04sOfYDL65LcaojgJNKsFXJExaIVpawYV9D2UA5CPkT+p3MpDU72W3dLjcVQtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651360;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=deMGw2zKQpDQGoy4HL1M8hIv0nM51G4fFGSaVrK0Q2c=;
	b=jPx0GrfOwMs/dDt2XshTDWiRZ/g3N/Y8d0xPwtR1mG/ZAad5hdOF76vzsgydF7O7XVWf
	 3CPjz5WoMDycjJYAGc0qX3kO/Ka+OE4n08sYFM54PWzw1KiyvN3jKisU3ps3OJ07iEuhJ
	 pDLamaUZbf3oX+INbiJHObJ+FbMzCY3zA7E1neuA9Ia8plDxxw0FND1uPBQJOmIaOFGQA
	 ZdzAMyHUkF9KORIYC51pdksDsPLzi5sNx47jbphV3ak1eNJlfF0N4H4rB9D6snw81+7Yl
	 EqzzTEG1j4QhGBQpcELHf8Uy7wsfUIUgsgAsDEo1yEyqffvUcwncGcqC4k85XgFWJPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+kLfyhz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB504606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+kLfyhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648BF1F00A16;
	Mon,  2 Nov 2026 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651359;
	bh=deMGw2zKQpDQGoy4HL1M8hIv0nM51G4fFGSaVrK0Q2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+kLfyhzU3r/yAbP39TBUHYXBOw0d7DJh+HMtrWlW0AuDXK7qE1FNoJqXnliO6q3F
	 EYrjOcApyJszkQ+YkPGF1MHqvdOm7jQuGmWP/NcEjYcAv529LDUaVN3DHk1yRRa9vY
	 spB5S5ejey/FxDQskD45eyw1pDx39H462B9WvUjbx02xL9gndVXDr5geS9WMroMEs4
	 8JGxKFs2e3Wkjl1p58gxUEiGDUSzQiZp/bXfRuzm2hkcFjfVNAfsv4Bxgpn6LbcF88
	 s/6tjiQjMebUF9vXNXCwda5Py7em3ZR5Yb7JaOZGeAx/wsKXgDhbaH7mtgp35reZ+8
	 koTJOU4LG/OGQ==
Message-ID: <sashiko-outbox-194118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-7-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-7-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:29:18 +0000
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
> [ ... ]
> the common sunxi PIO setup, BUSY-safe integer divisor programming and
> software RS485 handling. Keep the APB clock gate enabled during termios
> updates with SKIP_SET_RATE.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D7

