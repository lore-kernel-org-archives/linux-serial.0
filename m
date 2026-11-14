Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698182;
	b=jgS1ykUakxtDKxvzdozW4OyHytWqEmFb26VA1/YWTMbcGFZpU1CBtF14Z6dWlzIjJmYA
	 6Y/hkH5uZoKuAd/wJXBgcr8xFCk3qiiDgfRBkl4cHH+Eaw6cMXLU+foopPD9FO2G0dn63
	 0uYHij6bKeZp9ZrTwr7Cdmy6b9VzxSH3CclxXVGtd07PUicNwXatvc8gH0/CdvmIvfOvg
	 93IzB9fp9v3kdGRZuZocMyrcsGXwyRE1K53yBa/MJnduF39gSCv0JgNI7HI4GnjJScnWi
	 JzCXv4kABCDR+0q07xCn3lUPvQ57hkQUZGGfTwnHohh1HIo9LIaTL2mZcG8kE7uJ0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nIDL4BsnQQ0RPCIutC3Gg+Fuud0V+9vuyWCmPorRsDg=;
	b=UpdW/6yf9GKwTEV1BbEpGZYYUONTS3zVWLINP+w+EVjDCuGzbkrOHL/FOeYLN8ewiWYG
	 UJ7OedWRYhwG7CDivIhzYkGvI5TfHD3J85rZlEYgDKqd73cGMGwUI1rRrnfCu68WLu1TS
	 ueRXzxEJoJ075/bnHfqYHn7HSC7L+ix2oR0ZZcm0nrz58Fdlapg6YTxHLfZiATrH4b4II
	 1KYCL2IlpsgqK+BOZEKinGcK7VhkMGvqTf7xz+EKeyuIGAuRw+lsvliI292C/DyR03EWb
	 0R+PZmnLgkwF2SrQD/bgbZ+ObfwdRUK6/cCuKvqmkgl221tBhBZOydbM544WxUMiz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYWgF2WG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44628606A327
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYWgF2WG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81D1F000C4;
	Sat, 14 Nov 2026 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698181;
	bh=nIDL4BsnQQ0RPCIutC3Gg+Fuud0V+9vuyWCmPorRsDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYWgF2WGEMOte1BwSvVw2JgZfdNkPIQ6vq0jPYX9N7AWX2RbRzcbzXEwuK9kOyjuK
	 Gn4K6Ptjyw9RzkOtLK5dXKmpaxVXyiRiH57XL2mG7DDeVt8xeBeHIqY2qzJnzZL9Qg
	 tY7WKrPZohozNB/alCU06+n2F9l0OPDi1M2j9rwdtjwJ6aOuG17qPfSN8wDXf/GwCq
	 mTGPNvEgYXV2FI1XCqvtEK+TI6s9A0l1KtgFRAWmQAw4s8093B5Vb0iQDcn7RW61/m
	 Pg2JCPlJMDYxYjVDv+hyypcQk6R8Y6WAdMNMVJ832zjnTrZ4muVZXypcNidPb4eGOo
	 pNIZ+HnKgi75g==
Message-ID: <sashiko-outbox-215096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] HID: ft260: i2c: abort in-flight transfers
 with STOP before reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-13-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-13-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:16:21 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D12

