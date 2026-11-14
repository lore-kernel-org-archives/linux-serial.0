Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698704;
	b=pRkaiF3SxsAPrYzQjhYuQAaEEyCwuBpjnW67tNu8mWKD43tYPQHahxLLjFw1XJ0r7JBC
	 0HebOizFmaeQJanqj6vDOM3rd6xUeFL1tnGAgTiZ0paQgFwzC3B499TTE+nOJg5oxEZ5k
	 TE5k3F3E//3xO8NasdHw1iWDBz6CnjVtqVfj6UtD4qHvtub/gItmB/9l50umYYeiYLYrM
	 X338eDFnt31fIFvrcaU5XYjkQ1D0z4JvwBI5BvGiPH+873ek/xQ63pkTHtxlNeO6g8QJO
	 T17jZyEQgCCKJXZ+r4/w8Dk6A/tPGWL9XxgW+5PSdk6ols9GOHsAQLI9Yx37j8K9euQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=us3d6XmMzpC3a5DSZd6uicMhySCgUh1JFzIyzKD3OcI=;
	b=XoBvj5NP3qccjr5SYjTkgbxDGMdrFbWSKJYPvL/jwy3k5NnEWZdowl9k7+MSYBPGayeK
	 Vs2MJd/tehCZdLeAABsxOaHP+je788Z0bdMxlmp7jWyaphk+fBYC9vEhxGTcRqJtXb7Po
	 h3eUth/m1bR4Vkucha2vsPsFBmCFs2d1TONDDRUttsHbLfP3gqI5DSK8t1tv27WbBZKRC
	 e64DBY9DLOQ962IuPmUeE94wsds3m50YHN6/wdW0gC/ObDRb4/5TX9j3CpPpQcopZKZsB
	 XPdU0XuBubHgdfCBIAQGi1Lqn7p5tg/rLGnmwH4N3cHIjSYGx0JuCnvdKACm7KWtI1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4GGgvai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A35606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4GGgvai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1091F000C4;
	Sat, 14 Nov 2026 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698704;
	bh=us3d6XmMzpC3a5DSZd6uicMhySCgUh1JFzIyzKD3OcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4GGgvaihqcygHwmudNtjgrtBTcAwM+U4ABaCIOL/ZGXCmzYpTeqswSsYHp0IzjX3
	 ZcSvD218u8gprwPXCM+GKuuGOhJKCjA/NJeeepNEMMSoiuVnkRCdLITrsEz+EmQw8T
	 KYrRADODnM+8QbqlxUBj26sBPTQVNT7S+YavmflUDilotY+3tjDHf/HiIVh9RITEcH
	 m4E9LjsMmQEjPfB4X1mVJW0IjlS5CfBGLXONxFBRCFbFX5uK1vGyMCL6CNHQ4Lms66
	 LW1h04khd2YmEdnMCAcOpzFLmtcnmZGUR5zJKTZxV1+yaXflDQe1ttfx4UVSqV7pLx
	 UQbnUGQlLHTcA==
Message-ID: <sashiko-outbox-215107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] HID: ft260: i2c: recover a bus held by a slave
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-16-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-16-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:25:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> An SMBus block read takes the first byte the slave sends as the block
> length. An EEPROM has no length byte, it answers with stored data, and
> ft260_smbus_xfer() rejects a value above I2C_SMBUS_BLOCK_MAX. That
> count phase carries no STOP, so the slave keeps SDA low while it waits
> for the next clock. FT260_SET_I2C_RESET restarts the controller but
> does not clock the bus, the chip cannot put a STOP on the line, and
> every later START ends in arbitration lost.
>=20
> A 24c02 holds 0x68 at offset 0x80, so on that bus
>=20
>   i2cget -y 0 0x50 0x80 s
>   ft260 0003:0403:6030.0011: smbus block read: invalid count 104 from sla=
ve 0x50
>=20
> killed the bus: every transfer after it failed with bus_status 0x72
> (bus busy, controller idle, arbitration lost, error). The sysfs
> [ ... ]
> recovery: a full i2cdetect scan of 112 addresses logs no "recovering"
> line.
>=20
> Fixes: 2d68d67151eb ("HID: ft260: fix SMBus block read protocol handling")
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D15

