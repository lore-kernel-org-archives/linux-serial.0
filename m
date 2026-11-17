Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946319;
	b=IVFMS4lrHjixbflxY65tIEnc8FFloww3kHasJSUAxu1/SGBx96v8UJqn8GQwO1HIx2fZ
	 tdbb6T5AofKhrra415pSY77SJ+MPfHXhAb3ytxrd0YWOddb/iTNtoMNDkL1DyBpK4vDLJ
	 omaCxO8v/moEP/qCfD8k/bv1g60CI5grBDIWuDxmsz0Rewr2kljMj14MqhPEEx+RPVwZi
	 PdOKr/XlQHPp8XBz5zOoD+oq9TMNhAc9PMvcYIgo+XR5tGLryG9q6J80deF51wRgPrkR2
	 ECtc7809nFqGZjq2SiO9pVk5M/PMf6Ji2918HBaGRbUc+MKEExxtriGXDb5qkuSLkvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZSmM9gYPOmoxXvAZt3+0HYI9/AC4kYRDIMsTT30P4+Q=;
	b=HKZX0Of3jnJyrA5MoiCVf6+VJ8blztr5pD1IgGxOVYhx/uAyFT/pPsFUmIY2X+gIWVxc
	 6Qh9g1fLbtPSk3Xw2ZRFOEGRHXoZM+6rmTSosWL2EjIW52Z9mUmF/vTOs/4Dotmr1DK2Q
	 k2MeJFBmaYwRYuQQma03Pql3uMbHP8u6Jo8bCEK6WcbpzkdR0vIshX/n8Ta0qv5UcjDcN
	 flzmde2jKH4xR/CJ4B1EGDHpnUvr+fNKQcfdeby99k1GIdrJeX0rz/oSTawgvZ176r0RC
	 bAZen++Rg+6bheqC2amwTvuCgL7laXX7/Hsgs53hp8V+Ct5uFV2Ckx+/FsI04q9S5RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ7ZraG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EE606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ7ZraG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2914B1F000C8;
	Tue, 17 Nov 2026 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946319;
	bh=ZSmM9gYPOmoxXvAZt3+0HYI9/AC4kYRDIMsTT30P4+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQ7ZraG3izCcK9N8dh+8XS9i/9bKKR8rsYlVYeoKQ6gJDxzNpBQ+11e2ztMIy2DDE
	 G9K0/gXNALDxZbliv/0zYn8D3OaOD2yf6hZPKkPjrSQ6SilneZQnFj+XwFsjZUs/Ja
	 mUx0phjVMG0TBJHu+ki+Xyxvav8U9Ap6IXfSqKI2KIOrwldh58NwrPIT4BqAyv6XU6
	 16xfyzVvlC+53oxFhMpf/ic3eIQQjV3+XhNgCh26xLmfhSwdxW2tAXtQ24OEuxQw8H
	 uIKBLWydUCkrfAsDLZKB2ee6ZGfu2CGGUh9fyesYWsl8l37VFOGwisDt+ykTVOgJBz
	 Wd1Lw+Bo1NqoQ==
Message-ID: <sashiko-outbox-219573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/16] HID: ft260: i2c: reduce driver module loading
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-5-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-5-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:11:58 +0000
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
> bytes gets 50..75 ms, not the single-report 25 ms budget.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D4

