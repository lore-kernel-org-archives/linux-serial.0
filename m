Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262421;
	b=pFzlmRc+cyvphbA9iLybJh4DoelA5LJKqFMtTY0cSCmRihYvWqCylvAwccOie4bS/2NS
	 rN6c53Hs3QEFRVVppk1WIEvrxPzFlYBfzLKJqqx7aAdrkZ/gbNyGurHF6t1+16xARtoyJ
	 c7KX8rtMGljrlFMGMmSQpBIZ3t99gUYLYTKGMGk9TK3PikVGWtOoPu4AOBFUaMm3x9rFP
	 0do2IBwZjRSD9l4e0KOan4dKKOhTKz0UIEK1I3n7T0SeqagsgWANsEOe80Jd8udIBljlq
	 2D7Se07P8iOEp0XbdRqMNqNcBTzOaWc6ikO6+35nbN4tXlkiPYJPYne7ZX3oe+e93Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cr6TeSdNfMHw/1nJfKi3H064sp9lIKphveB9fXNWYOo=;
	b=chWUFVhVyvIiWauUMDEQ4ePCOpc63p3NEbN2SztPEaXj6CwfWzqWcgjSznlM8kyuTD7Y
	 9nAQxw9/hIYBiOc9hxCfdAQ2dmZ2bF3sYLWsdQvQ9ka7Grh/eVRL92Sa+4IVwuqFtm0to
	 RzoTuMzfq5XNxVxAWt6KlkzprhKzngqrUexfOOLNbOMnZDiWMgJSGb3xr/s7ZWIFNYPP3
	 Z0aVMQExoDbS4U/XPIwbvc+TPe4FwFIQqlwa/ili/pCAlMI3UMHb8Hhf0C8qy4O8KwySk
	 2EwuC9xhqniVQzthumcmbdPdd+IbQ9K8T75vvBaEUN49ckUCt4wtuv/VTt7ECfXFkoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RX/YzDpP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC5606A33F
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RX/YzDpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597621F008A4;
	Mon,  9 Nov 2026 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262421;
	bh=cr6TeSdNfMHw/1nJfKi3H064sp9lIKphveB9fXNWYOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RX/YzDpPIhZApjeX/R+y8AKAVrNWU9j9eFknu45NhduEpDn4T+LUAmTzRucD+8dDD
	 og/bLMrP+pqfyMVMt0OEi71zkD+TXc/QfqQAKyUVU+QvEZ69v6BETliP5qhLOFYjPy
	 +c1BaTN+7oE7JlotVpD1+Fs6+zctlREOhWWiXN1U8drr3/Ol9/EbmbQUd9ACSwWHiF
	 YuBe5iBuUXSFpHAkypg3HecYa2q6DRwnHWsgDBLiopd2NWSLzokz0xGEbMQQkw1GEg
	 CEdWY2q9QYXQv9Fvn3gWbuWzHUQMMkICuq1UeB9i/jw761fYo7j+P7I0xYJsWLcss9
	 d27O7VpQLRuhg==
Message-ID: <sashiko-outbox-205706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_of: add Microchip Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261110-core16550-rs485-v3-2-4294334243fa@spacemachines.com>
References: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
 <20261110-core16550-rs485-v3-2-4294334243fa@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:13:40 +0000
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
> Match "microchip,core16550-rtl-v3" as a PORT_16550A, and set
> UART_CAP_NOTEMT for it, so em485 drops RTS from its stop timer one
> frame time (plus 1/7) after THRE, as it does for DesignWare UARTs.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-core16550-=
rs485-v3-0-4294334243fa@spacemachines.com?part=3D2

