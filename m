Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948274;
	b=tlsmilYlRJ1wnQG+gus8jWuVeUc0Plclm7mNz2S18sRGhSs8kS+Mcts+FKxasaGb+JUL
	 w4h9729qnT3RpHIfNvD7OxcAXQ59O2qGNGdnO8jhaVNzFo6tBkLt26IkLyb4rwVGyBFL7
	 x2Z4BMpsuUnS/zpia6v/uoJWPYjkK7Y5okBNcFQSz1QjDtXnOAUuIO2652OM87XOjiO2k
	 SvKn/M838MaLByxzPasks1Gu4wYlGKZZWU5d+8WlnmyUFNjmcHKX+Ng+9XBrI/QLCraiz
	 0BAel55iSChbrCALjB6Sv8aWqCOIyPvTWh0ksGSgG3lEDLodswN0EStEA0VplsPiaDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GzwlS3tHFpe3hskqhm30y0DdDB6S14uuFm2a78ehgdk=;
	b=0Z7Zo1cpXzXfTW+WpJnU8jTbN5+vSQG8XGuUZnXz4Wi/d5RpIJDpdkOI7pxkxFJ6aW7P
	 cOmUM1AFs6iDOrPCeXxRtZqCn9ZqHBYViW1DyJws0yAR1678J1sjmCWbmO24xfcLJ6OVp
	 qVyZmGqyEuj3ou6QbvBVArSgrhxGvGWlCF1i5299zZeXKnaKJ9r4kddLUr+CCeo692rDl
	 O1ns32rIkNp2oZvEqJPyJFwA929nSWI2H6HfqH5Sk0oJixPLK8NgvkibxFxsy8jVqryXf
	 72tsSDsfL3SujLPUUI/0r+cqoO/SGHN6GHw3WR8wNvay0vYtcoVihYe0F0XbPDVvIxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2RJ0+4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B99606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2RJ0+4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A151F000C4;
	Tue, 17 Nov 2026 20:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794948274;
	bh=GzwlS3tHFpe3hskqhm30y0DdDB6S14uuFm2a78ehgdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2RJ0+4MfA73NukmC7HwA1oDnPffv7Cg8AppUZaP8yyRHNwrHptH9NJ5TiB0Mi1lG
	 pU2bx83QiyIaoTvO8yLP/GyUpHJMjyUOP+JluHZOBKaSGOMAPn4f3U/qW9KS/OkPfN
	 cT4UaWYSmuVIMfXLPDWAoAk+MzvnE1oh0FY1G2oJctaQVNqG/NcAiXuxo92Rm6JyOg
	 MP6Fz8FnhILsTQKUlVDwbmO2MDRXj6Dxd88S6nwa6a2ZvvYCxFPQzgJh1Fj+qtWnDL
	 Y8JQFQ8gC2ilXlbAY4KYRvEt4nBmIbSPUGzJBQXrfl+KTScPYkiuCvcosU2Ly+SWeu
	 lSfwrQsVt7Org==
Message-ID: <sashiko-outbox-219643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] HID: ft260: i2c: recover a bus held by a slave
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-16-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-16-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:44:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D15

