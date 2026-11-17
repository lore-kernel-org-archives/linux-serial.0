Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947590;
	b=y9lSoJFhrQNIpu5z0jewv+hEkDHp9fL6gsTpX4zyaO5qjgi7lcTFgcx4K96sPTo310of
	 tvpCdsQiea+NMJAoRgQ+++Xw8Kl9qr5oM8aS8MgFpUXfKJ0J2QjFxInj1hwBJGoFFsPHU
	 Ac8r/B8ipoEGrxNhNfVCMYWAp0Iq+DdcRmcC5JZese05/XOAL7FfYbFO3frcvb8Z3dU7I
	 /R+pXLXPg8aZSpTDc6qL/Y92azdG0edJ8vWOZvPWybN4C1WcIQBQvQxqkNNnk/UPC4aUx
	 +jScxTuC8uJKa9ABWX/L7wiuimjnYoa6+jjoJSGGLC3VD1QGvxYaBnlrqM/bAlU32Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kYjD4aVy1+e2fElYHxtfEwqFQ32YfMmKZhUUJCpqfaw=;
	b=CpbwFZavsn2X4DGZyjOX6wHjcK+/AEmf5pQ8I1Gi1Osn9YREF1/lz/uqiFo2A0hiT/uS
	 ufp44y60nuPIWkV3GcMx8cuffnvD9mN+3XMy8/qeDUL6mSCmIWtsOg/7GFTE4fAxIsX5U
	 j+Y+Fm9lOAoB4eP/a2e5Hhr4I/f8yHgF2fBP/YJfluvK/4/HJB2XwK6+D6DWhbXjYEkhz
	 aJsikoMv82UK9R/T0rX75RuzUjRIl2uyknx8HeIII3mXGPn90uZt3XXQy8QZvMse196XQ
	 Pi+zZw0OYcSszTB5/EMTlBPrx/ywIyB83d/XO8zJ38Ch49tb95TmbObZPvIpqDQqEgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acyLUPms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28D606A889
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acyLUPms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FB81F000C8;
	Tue, 17 Nov 2026 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947590;
	bh=kYjD4aVy1+e2fElYHxtfEwqFQ32YfMmKZhUUJCpqfaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=acyLUPmsu6ksF6n5BlbQYe785efhgTviyYe9+ScDka4MUFpBJJ3pK7lGJLd4wQ7D3
	 X+wEIr+fYhmTvgK11xuENcHG/jDpJECXt9lCIqTgyGn2vBLYesoHXcC3LE4nP7Iey8
	 ULXKYYlNcuk5zRQ1NjuqP1pv8YAI6FI2rkYEcrbg2a6qQxi9xRv305Ioglqea/imc1
	 q+9tQa/Hu68WQsqCD9mJIoJCpuwkJjLA71e3kyxyE608qcTxpmTUu1lm0syTpZ5U6E
	 ojooDorCe9hVkkUIBME7TpkK6n56mYxB1AGtUXssK3gPqJb8Q8Ae7wKvkOCjmKc4Bw
	 HWMUyUOzTY9YA==
Message-ID: <sashiko-outbox-219620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/16] HID: ft260: i2c: abort in-flight transfers
 with STOP before reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-13-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-13-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:33:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A transfer that ends without STOP leaves the FT260 I2C controller
> with BUS_BUSY set. I2C reset (AN_394 section 4.4.15) restarts the
> master but, with the driver still bound, status stays 0x60
> (CTRL_IDLE | BUS_BUSY) even when SCL and SDA are pulled up. The
> next START then fails with 0x72 (arbitration lost + error) and
> further resets do not recover; only a USB replug did.
>=20
> Add ft260_i2c_abort(): a STOP-only write (flag 0x04, zero payload)
> then FT260_SET_I2C_RESET. Use it wherever the host tears down an
> open transaction:
>=20
>   - read wait timeout
>   - read status check failure after the HID report arrived
>   - write status poll failure after the report was sent
>   - SMBus block read with an invalid count (count phase has no STOP)
>=20
> Leave ft260_i2c_reset() alone for HID output failure (the request
> may never have reached the controller), sysfs i2c_reset, and probe.
>=20
> Tested on a UMFT260EV1A with a 24LC512 at 0x51. Five 1 ms read
> timeouts each followed by STOP+reset left bus_status 0x20; raising
> the timeout to 25 ms on the same loaded module then read 16 bytes
> successfully.
>=20
> This matters more with the 25/75 ms completion timeout from
> "HID: ft260: i2c: reduce driver module loading time", which makes
> read timeouts more likely than mainline's 5000 ms wait.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D12

