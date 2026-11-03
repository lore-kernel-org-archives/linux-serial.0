Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664979;
	b=bJgjaKLZgXbZsYtydUB7BRBYFp4C/s4Fz5TTSj9jvs+M6EMVYbNbl6nXGpjbWLIZDdJi
	 /uDUuvpw8AOm6HzdK/TQL9xadLPTax2obG5l41BcAwKZBA5L5v8VupSTSmEyTe8+X+YlQ
	 pTaa5dkZKVs/ZRAYU+mZpvu3Me7ECRl+Ep7awhF/nukm5syAYhQva/yVSClSUY5iuTpaP
	 /fvllW9szgAlzjEsxfLEpBBwM4XXoYchTZe6Ie89BT6xbH6obslWRMKB6XrYHQWG/25zy
	 k4UNaOPFNnv+dY4NXvS858eJBq6ecCIWC1qzeh3MMx+iMo1o8xEdVufSlzKbhUd5U7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eXafgtpQyJbgkCDGWubE0hcnwcP0ysZP3IQ+JMPjMr8=;
	b=wmqZ6Xdz0ZzfMbWs/wfe+DFhOMwGPRyKVUyZqUQ5R8E2Uvuukiv8B0xbpSmVG3z3gXm8
	 lxubnrWBYnbFHAXGJhhgh4wwFKSqi5Z6rWRqNtdllQAdubWQX12luEnyMvUoeS/A4tok/
	 TExO2yg3HOnL3KvtPZljFi7pymq+WSQMvS4S9G2H6yxzy2rV3NvnYdSWSsNibAs/QmrCR
	 X6q8VGpiBAwovCUvHeaImcFAULga4F6mhx6nHIJ1CSC067j/da/BO3aShOhrYm4jQj4k8
	 9H3Gto6cLs0Lr+5/sqqI6897vwJ83nllWGkhmlo4l4naF3JnG5s7p9p6pkbxZM+jfhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVeNF8IC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448F606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVeNF8IC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D01F00919;
	Tue,  3 Nov 2026 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664978;
	bh=eXafgtpQyJbgkCDGWubE0hcnwcP0ysZP3IQ+JMPjMr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVeNF8ICLOnBtS635QXt6oqcC4HcjRhLHrg9eq1z15EwBh8YJkBSQTh3KK/n0C0co
	 Bpdfq9Hu0tr3xn47uETHyM8WAoHTu24lse4Gt4YlEU5078ACTvEl3hhDmUOwelZSej
	 qaH5LAq6OCUlDrn4Urt6hhZL/lwLl6zoZTzlg4NYWnvF4FvZXdX/24bl2ggxG7iSoT
	 0X5T+JLs6bDtYdJhRygJYO69MUWD0/gmUqvyXLItFHku+m8cajz8txD19S4GvWlpTj
	 00s7e/nNeC5s1gToZrCEBLbQNX/alOm9IbLKjCifTdh/lAX8B7NHHc60tjyRPNGPGH
	 QTv8KfjAFwOTQ==
Message-ID: <sashiko-outbox-194368@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_of: drop RS-485 RTS on Microchip
 Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:16:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kohei Otsuka <kohei@spacemachines.com>
>=20
> Core16550, a 16550-compatible UART for Microchip FPGAs, interrupts on
> THRE but not on TEMT. When the last character moves from the FIFO into
> the shift register, the THRE interrupt calls __stop_tx(), which finds
> TEMT clear and, without UART_CAP_NOTEMT, returns to wait for a TEMT
> interrupt that never comes. RTS, and with it the RS-485 driver enable,
> then stays asserted after the frame, and receive interrupts, disabled
> for the half-duplex transmission, stay off.
>=20
> Set UART_CAP_NOTEMT for nodes compatible with "microchip,core16550",
> so em485 drops RTS from its stop timer one frame time (plus 1/7) after
> THRE, as it does for DesignWare UARTs.
>=20
> Set UART_CAP_FIFO as well: with the capabilities already non-zero,
> serial8250_do_startup() no longer fills in the PORT_16550A default,
> and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
> the RX FIFO is not flushed at the end of a half-duplex transmission.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-core16550-=
rs485-v1-0-6d15ebe1e5b9@spacemachines.com?part=3D2

