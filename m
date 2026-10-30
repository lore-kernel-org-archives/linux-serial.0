Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400262;
	b=k6VLpTxwlAfqDB0DBO4QJeK00cRbv0WZydcSSX4Y0UQC0UQH0vyT4+evXoFQjJVfX13m
	 yxuPLkLtnkWKyU2+xPrpdsdEsBhkqSstRerf7x9mX7p0mXZcj6yFDEQSjlHp0+11b/Stc
	 +qdIyAyuJUaRTi8bqvZFZKAkbB0uU4UP86S4FFpzJekpjdL+uTNswBRSoWrL01VQQiwJN
	 q2OapvRuCfyxyfkMAJSDjlFoQxwVGh44VRo+AV3uo+oUusJI9PY2O0Y/4gneVgYxlkivQ
	 1guoJGqxxV8ziQg526YP6U+1XvcuxeKtR1k7rSO0tCypK57AgcLyCyvcQ4MNc3QgCJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gM/05kYOzqpDeucFJiNxz/EWuXouBuf3LB1Gl7Q8wqQ=;
	b=bnHaVJInk0Hmt1g3ZNpFWsToxveMvWXA2I3d+LP/wADKJ7kLuTgj0esJpM39Q5sKE8rP
	 NSRkqyJLBgq5uxM7JYzGOSp+FEOqNQWEU5l59MNpKaVyn310UMFO0a446OrfwYkvAfn07
	 B4ri3z6I58t3z4xUPzdW6XJppJ5DJiMXi8erbdcIAkp1bE2fH3TI5D8WvR5n/qiUmxnwP
	 kcZkEzawHHqxprKfKW6ySy/Ik2afmQ3CT2cTugj+dXfMsPFINA+xct1PScmyYliWjwOF1
	 nKdmi/EzN01j4TFDke1ZqTq/7AOF9gIZquS65PyC6aYhb4laolXDCins2XiBaTli4xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlZ8MIPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F4606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlZ8MIPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FC81F0093A;
	Fri, 30 Oct 2026 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400262;
	bh=gM/05kYOzqpDeucFJiNxz/EWuXouBuf3LB1Gl7Q8wqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BlZ8MIPqNVc3ekTPcmcrkYxDFIqyVXbGLaHtNrRD32j/IPOP3yFclncqRlBkMeKXJ
	 vjU1FH+Eu9spYvG9gXGoS78PCQhVkXvTcvnBLFmk9GufqDiYPOjab8OhpSMwZsh3fM
	 yvV2wXtmRStMzf4TgV4UgK92oZv+XkijmJ5yDnvZWANy8Nfw05Yk17AwEu4ff1GOYi
	 IAUk9TrlhDXW5cejDyw4lcMFaM5MdMNuVLY/sPizt9AK9xeUwNMdjWRMBcyavdXVjk
	 LhAR/FMkRRgV/1M7SdN58J3Ozc+LKbBzb34C1QX8FszeMoXMriuKq1MwVnf86C+a0F
	 Qxqe6/U0y3K+w==
Message-ID: <sashiko-outbox-191584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] HID: ft260: i2c: reduce driver module loading
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-5-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-5-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:44:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The HWMON class I2C client drivers register the address range to scan
> during the I2C master module probing. For example, the lm75 module
> registers eight bus addresses scanned during the ft260 module loading.
>=20
> In the case of ft260, the bus is scanned by ft260_i2c_read, but due to
> an excessive read completion timeout, it took about 40 seconds for the
> ft260 driver to scan the lm75 address range before exiting the probe
> function.
>=20
> Adjust the i2c_read timeout so it depends on the amount of data to
> read, reducing the lm75 address range scan time to about 200ms.
>=20
> The 25 ms per-report budget was checked on a UMFT260EV1A with a 24LC512
> EEPROM by shrinking the timeout until reads began to fail: a 60-byte
> read still completes at 9 ms and times out at 7 ms, against 5.4 ms of
> wire time at 100 kHz, so the fixed USB, HID and scheduling overhead
> costs a few milliseconds. At the chip's slowest 60 kHz clock that chunk
> needs about 9 ms on the wire and a 180-byte chunk about 27 ms. Scale
> the wait by 25 ms per 60-byte HID payload so a last chunk of 61..180
> bytes gets 50..75 ms, not the single-report 25 ms budget (reported by
> Sashiko).
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D4

