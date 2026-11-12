Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472123;
	b=N47Rzarf3W2wOIJDFj4Rly1MvFy3c/mY5gz2x9xrspyCYCHlKp0nJ+Czmhvc1d6mlM4e
	 fxyLis6vOqhdsOzOxHY6VDfKSCjUy4wR/z4nkshVgNEBCGhSL2s9gDBU2t54RDoBO+2cy
	 rcI03cWMNyGBspeBQNfniKUKqR5eoT0dnPmZKfq+Zjvex6RccEW0Wi0t9tdB/DMHRfSik
	 spRYmXLmnCk+rekPh+dvbiwuqFAs8rZMRx8j5LRcjo0AVHSQk26hsO5QPgSMIj4Jg+Bvh
	 5CZIvPr+AJ5JHeqV50Ioh29o0VvS5tZUrj7MncDtzK73h+5X4qi1fDKrK/FIpf21HzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ncoNO1qrrUKkPb21ny7mFa4NZ5g8EEDWMyOZq+1ob+8=;
	b=4Qjo7e3xGs9sb/J2MQjOp+zvAhDTpf1lSvxf5pxjx0EejpcM4V40B0KInANDccLTfgx+
	 C3/+e8cxX7RuyFnQQlbCu9nzkZ3UuPJj3UMR+PXQslFXcl6ONQPUswv7eCabKLl1gr91J
	 8guycWJoAYch74GWTC/4XK0GgMLwxvm1D+4RXSiEmgq9kr4eyZwSe+dVO9ff9aisJR97S
	 rCZePDHuap13nwevfg/IM4QLeIrsrD+ySbSUGFfcdIhwQ9i8LsJdwOxVuAxLFtGZFWGTq
	 tWLn6v+U4/hyH3RRnrkM4X/z4EjSgH2q0nA7DpXPMR8FpKar+OcY9YJ2xXvxsZGE46A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kj/tBedI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60706606A321
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj/tBedI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D378D1F00A05;
	Thu, 12 Nov 2026 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472123;
	bh=ncoNO1qrrUKkPb21ny7mFa4NZ5g8EEDWMyOZq+1ob+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kj/tBedI2jiZzJiagc+IhJwjtrx8D+lYk6jXcVEwVnGjJypoue2z5lSsOiVRL9hxc
	 soSzwDm9bMXyw5z5BJj2Z573bzRsrkL83mbrlbHV3hdSyeb/IjSMyQLWCJWXK0bpTQ
	 +CgQUtu0xv7sKDU0GgqX99gMG4kGrL3iA30svHIIb39RIAkjoJElZPSqpmIkAAFCYo
	 ubKt8GlZAdWQ7nN4iMnAJnJNiMupi2XfeXqKBR2j2Y5a70e+U1w15pZ7Yb53w8euYT
	 hAd7+v7sW1IeuT1V+zqTxQt81xKsmWTHadBFmfPfSuR/mZcbfD881u3MhuP7ufnX0Y
	 FoY35KSz2ZiQg==
Message-ID: <sashiko-outbox-210721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4 2/2] serial: amba-pl011: keep RS485
 transmission running on reconfiguration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-b5c58ff3a376@tipi-net.de>
References: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
 <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-b5c58ff3a376@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:28:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Changing the RS485 settings while RS485 stays enabled calls
> pl011_rs485_tx_stop(), also while a transmission is in progress. Unlike
> pl011_stop_tx() it leaves the TX interrupt enabled, so the remaining
> data is still pushed into the FIFO after the drain turned off the
> transmitter. The FIFO never empties, the port stalls, and closing it
> hangs in pl011_dma_shutdown() waiting for the transmitter to go idle.
> A start still waiting for delay_rts_before_send is dropped as well.
>=20
> Only stop the transmitter when no transmission is in progress. The
> call is still needed there, it sets the idle RTS level when the port
> is configured or resumed. A transmission in progress sets that level
> when it ends.
>=20
> An active break counts as a transmission too. Forget it only when
> leaving RS485 mode, so that pl011_break_ctl() still ends the
> transmission when the break ends.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-devel-nbuc=
hwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de?part=3D2

