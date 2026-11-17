Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896473;
	b=0ALtcAyGHQAGvemVPeXtG8wH2gc5eHtyiGctWlt0m5t+N1CXCDT+kp1rT/6ZH5YfSgQw
	 mVzz3bF79/2q3s0300zMJ1bRWE4T5o/hmrSSP2DLt0KC3HUuInurqcAbeT5p1Th+XxpHo
	 84s+3+PQv9mSno7B1m4eQ09084Kl3YslS9gTowrKsvoI13VsvGA/RT4rynaQH8rltedUd
	 Y2fqOWqYzG0OGn/RowcbibmIIuTgUWt5VRHGQ9Dg6y/f1Jcg9Hnf4K48XWzocpKORAtjW
	 arqooVHxjRZTKAwP8nDgYBa1BWnB78M3fN8a0xVI5KDYJ5f4M3g959Fw7c8FvdjFuXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896473;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pRVRA5MLEjQahlUHQpOPl3d4K0lfLaSgi97gqSmV26Q=;
	b=VCP635bgtge7XCC2frz0BBPR/eljU34eA6lKUtNAS+iClP7zMS63qQl6rBmZHAXWUNnf
	 KXKBdB++jBhz5JzI7UESu1TiDIpbWXvX+Gaj9l5/N7x7cfEohzMMO2C8ntPPECPiAjl1k
	 YMZPn8cPxPvZA0yPr/A9dtuFMvUdUoc/g3ZzzEiUy/mWcOkek4v73X9MSaUX3KAeT/qsR
	 ECbxd2Ry8LMBtz5sEO8MMomqC/hYc7m6jEhISD3QOrpJGRkJPuRqLk9V+pZcmke54e5sL
	 jzGyqC0DMiIHTYiMdv/3aJpBWW7FjAEvTPDykrPfmZEcKjIjLl8Pc5CT+lZMwNyQnnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6gwAVXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B02606A330
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6gwAVXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEA51F000C4;
	Tue, 17 Nov 2026 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794896473;
	bh=pRVRA5MLEjQahlUHQpOPl3d4K0lfLaSgi97gqSmV26Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6gwAVXatXjZMGbfIzzvtGLgbRxkKLxLxxPl+r9muWyFzYO53Oul4n9mUdpCjMRfd
	 32ALI6g/aId3pOe+N6egjcdII/rWqT9TznoZMbM8ygXAqfNmVsxePhooKPebJOPEMx
	 8wZkRtcdyn8Lme72HQFQzQZrFi3OyKKmfRG1DkEg/KVcIBPL+J7sisiv96KO/FxU2b
	 uCmz8t6lanL7N0iIN9e4YwV9VewKOar6HUC6/0Ak80cMC+8DyoKnCksOATTaFvoXbn
	 Zs8CJQCP7IBu1q1Mz8MWGFTD1a8DgpagejaZhL4uRVotEf/gfsZxYrRCRGoxfXVDEH
	 nFf+vk/Q9H6mg==
Message-ID: <sashiko-outbox-218247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] serial: max310x: re-check the TX queue before
 the after-send hold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-max310x-tx-fixes-v2-2-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
 <20261117-max310x-tx-fixes-v2-2-b395126fd23d@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:21:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> max310x_delayed_stop_tx() decides that a software-timed RS-485 envelope
> is over when the transmit queue is empty and the chip's TX FIFO is
> empty. It tests the queue first, then reads TXFIFOLVL over the bus, and
> only then takes the port lock and arms the after-send hold. The bus read
> sleeps, under load for tens of milliseconds, and write() queues data
> under the port lock in that window. start_tx() finds the envelope in
> MAX310X_TX_SEND and does nothing but reschedule tx_work.
>=20
> When the stop routine resumes it sees an empty chip FIFO and arms the
> hold on a queue that was empty before the read. The hold expires, the
> RTS release is scheduled, the rescheduled tx_work pushes the new data
> into the chip FIFO, and RTS drops while the chip is still shifting it
> out. The tail of the write leaves through a disabled transceiver. No
> FIFO overflows, so no counter moves; the loss is silent.
>=20
> Seen on a MAX14830 behind a slow SPI path with 20 ms of before-send
> delay: 25-byte writes every 20 ms lost 1600 to 2200 bytes per port in
> five minutes in RS-485 mode and nothing in RS-232 mode under the same
> traffic, overrun counters equal; 96-byte writes every 60 ms lost
> partial chunks of 14 to 75 bytes a few times per run.
>=20
> Re-check the queue under the port lock before arming the hold. Data
> queued before the check keeps the envelope open and the pending tx_work
> ends it once that data has drained; data queued after the hold is
> armed is already handled by start_tx(), which cancels the hold.
>=20
> Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardwar=
e delays are too short")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-max310x-tx=
-fixes-v2-0-b395126fd23d@vaisala.com?part=3D2

