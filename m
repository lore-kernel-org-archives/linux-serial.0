Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472802;
	b=0Dyk01VujNAhDb7RpCUpSxO9kbOktzH5FB0L6EFoP1TXN291b+H2JEMMpHeyxvyWmP3j
	 IrbrggdtNtYwQTHQGvQN6sPGB3gmZspr7RYh4vbn64dhhrNvZ5WCI4UBdhg7zeeHC+0NG
	 Ku5sP4LHtpNujA7ic1QJA0v+ixMbhbUgsYdPWCZboVSyCajuHirKiKEpTDOnppM5LGOAf
	 TEcVH43LPDYIH/RUEDiJdMAk2qDCAG3i46c4Yx2y8I5f1lWVgiOscW2PlkAF8GwKR3qSR
	 ZmA9ufyUgmG64ofiVxNW3Ek37uvw696PQsPfw6yL4IenpNBDg+dfTyxWcI12+F9nPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nXoPDYlKR0gM+lE+LzRYcMeuw5FDjAGVV+iUWbLUJ/0=;
	b=yOYrMhvTDAygDgS0aMtBcrkvoTX9u5kWY2ynbXAHarDe63I0FSJhz1y2DhokmqHLrO/e
	 BUsymlv0am+lSzsXfxKNE4y+03XuRanmsbLUF59rHnbATIDoqOEpvEj9YUUiMZ3w2xrKN
	 Wl8JSgCCqfi8J8M62m9jr+F4ruNK+sj7AkeuLUyz0IxT/o4vCXC5uq1w9ESsbY+kHH+Qg
	 pkd5t6cZHHIz+tzAmVLp1bASDJYeDrwnF5U1jqfhcxyvFx21StmIBBCNtYQ4+unPUeWf/
	 j8zom31zGHFy1godLwzS5ymzpi/brn+HV8MBT8K58IjP1yKSiJiGXL7wytB0b9W+bkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVdhuxqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C85606A33F
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVdhuxqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDE71F00A06;
	Thu, 12 Nov 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472802;
	bh=nXoPDYlKR0gM+lE+LzRYcMeuw5FDjAGVV+iUWbLUJ/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVdhuxqX4otE4QORU6dpCvXkJAGDPL2b2qs3GUvIsPcxc1J57gErVrI5Cq+1AmEZN
	 ifA1jz9z/4OrJSbBQt8ZGM48rjVACIZo0/aRbJB3uKi2SWlzP1Uy59BvcaWFad2uA2
	 AYbJuJ09q+VYWkfpqtJFtLPgu3Q77CFAjNGLYKn98Cr5kdmu1BG2j1ZGfVJTefvGPc
	 If3ZfiYmM+AFJLs9lK8lvDCxWYyPGccfsJm1rQ4UpvbO6RqyF7cRq1fd9xaHvS5OL/
	 igEPOwP0mu5gOIrjtKbPN+PuIqDb6PH9YnBV4jzKt3tCVEOa4RGE2nKb/PEathWTwF
	 Z3CkntmivBTQw==
Message-ID: <sashiko-outbox-210754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4 1/2] serial: amba-pl011: finish a transmission
 still running when RS485 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-b5c58ff3a376@tipi-net.de>
References: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
 <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-b5c58ff3a376@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:40:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Disabling RS485 during a transmission keeps it running. If RS485 is
> enabled again before it ends, the state is OFF while data is still going
> out. The TX path does not end a transmission in state OFF, so nothing
> sets the idle RTS level afterwards and the transceiver keeps driving the
> bus.
>=20
> Hand such a transmission back to RS485 when it is enabled on an open
> port. While PIO or DMA still feeds the FIFO, assert RTS and mark it as
> sending, so that the TX path ends it like any other. With only the FIFO
> left, drain it from trigger_stop_tx instead. Data that is queued but not
> started yet, for example while output is stopped, is not part of the
> transmission.
>=20
> Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when d=
isabling RS485")
> Cc: stable@vger.kernel.org # 6.18.x: 1b6d660e038b: serial: amba-pl011: dr=
ive the bus during break in RS485 mode
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de?part=3D1

