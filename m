Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584392;
	b=1uMnhyHV8xdCrLatALXyxJ5NO8tmf6IoVf+G2/hfudU+rL9QTOXO3BDXT+mtJpL+3Wlx
	 4e/x2FDA2cftFg+nASMJF5PN3jku0qePIuRCcCzKXxWkAF6TbpywaE2g7KmVn95YurFUS
	 Hdd9JTzoZbB5kvzc/PWsbkCO4INvNhXp0KphdJ7kfyz51SaFZ7DYk233uwZonQBccIoE3
	 sbGs/tjFti7mmKco6flwFR2sh33Ftpe/sazZRZ36ZMRBvtGD7Zb9uNeiGSGPm4552CzXm
	 xkDw09UHB0KdVyWhvKRJ9rHW/t+VRQLim4G23Ya/jBUyTLocT0CfakH2R1WQi8c/aUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aW9Rry4rMUwomOiisp1QKCsYKo7ZBrNGiG+Mm8tNZwA=;
	b=BK1Imr6CxX7s4Ogy45kSrM8tGnHsXye2jfn+lEJ190ZtNuJO+pHKE/OHtDjcOyMnImOH
	 twcMoNPZXqmscx+HkMVV5DQzS/zfpqf18bk2FPKCRA1j3vlXVgNHKgn9Z/VtiEdwR1US2
	 8c1i9K2yn30phihirQVfe1OWQX35oUN3w5M38MpZBxWF9ZWxFyTuskZF5zxe9aIOKtGQ0
	 3eTMRV4iYfM3RnoBjLDeDzezAf8xKjqDRIE3gOx8ECNWCtMSeBpcYv3FHImkqap8AWk/b
	 E+8RxYpgpdR2bEP4TraHlRSR8dC8JcCznxVtLXVbHYn4vCT+73JgZsBVRyxQdMWKImA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="blH/K9dH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C8606A327
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blH/K9dH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EE1F000C6;
	Wed, 21 Oct 2026 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584391;
	bh=aW9Rry4rMUwomOiisp1QKCsYKo7ZBrNGiG+Mm8tNZwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=blH/K9dH8s7S3oMxoziRDSsDNo86IBsYkbUNWhv7RMndYMAeUOOYqwDfKTppDTQC0
	 yIEp1jgD28YU8LzRP6ZYx2CCCdDN0bT0X5QG4Ufpi1EV1dlwiHkCkGVFLQudtArK9s
	 SbZf4DaXZBukuNZNFkbtHlaQqsk1HtI98O1yi/T8qMtDrlTEvd3bJviYESU9/IXwJ/
	 36kGA/vvZ9nSPZNdGtgse6UsF8c6yehze6u+VyirQ3Xesjw2of5OoeMITA+2tYeu6M
	 z0km53+MmtPGcdb9HtNrIA/MWozqi1LcwcyN5owb4/qK5iUnA13TV7RQ6HyNRrsNhM
	 g7F3wUuXeHhoA==
Message-ID: <sashiko-outbox-180203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: end an RS485 transmission when TX
 is flushed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-65a78e1fe1b3@tipi-net.de>
References: <20261021-devel-nbuchwitz-pl011-rs485-dma-flush-v1-1-65a78e1fe1b3@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:06:31 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A TX flush during an RS485 DMA transmission only stops the DMA. Nothing
> ends the transmission afterwards, so RTS stays asserted and the bus
> stays driven until the next write.
>=20
> End it from the flush, unless the TX interrupt is still enabled and
> ends it itself.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-devel-nbuc=
hwitz-pl011-rs485-dma-flush-v1-1-65a78e1fe1b3@tipi-net.de?part=3D1

