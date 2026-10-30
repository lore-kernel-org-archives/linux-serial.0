Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400595;
	b=4ITG6YUe4UoTo+hYPQq9hHkj/VoCK6HBkljaVVcpGsusKhg/B+6paTNXz66+1UAKVmfW
	 1k53MvoQ3g3WEuT3H234nCsAobHoOznK9DvV4lgi79ZmIskcdCowk3FDTDPN+ZFWJI+tA
	 C0lUflF/j5j0Yl3gZtO+KHIelWRfBMttLGf87am23SDpRB1Wn9ihhaB5d3unXxjbiAw8r
	 zGn9HK/8Dico4PKtJG2XVA8U6eyY1zbyfgtCtcZKLyb7zVkpVHMj1R5WxpEcULmtr6qWe
	 8tmYVH2Cvj9bBrRbMrc2AeNEq06fRNVvG0UMwMeftC+N+ABPDebByfSqtprSIL/WBWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DbppDLg/fp5GNAM+0ROIvSObfqKNW5IO9h5mn3kNs8A=;
	b=nZvISTLWRILOYl9IPadZJwygST3zrSY+EzLwiD6I3TgK+Y9PH+tlr2TC7Xmqiu9yCIV7
	 umhZiHK/DM63p9x5XNmpfN0FyX1gTiIlCDt5ylb+UoGLERqBac+buwo2sog9OdADQByFW
	 E21QmjgHy0tde5bQmKpG8afEptHwg+wgP1M+UwCQ4OdrTiiiAF2kmwmEC+xOsiocI4BSw
	 ufc5JV02GRm6+gBW3aLLlP0uIBV33aBO9y4mDDBD6ajTxewzRclBwwKofLrLEL3MR4YBC
	 lDxIS7q5KYyMBoOQ20rSzRt3QbKYI9SL3YQCoEIbfI1h/MKWgKGnUi4mkQQWD3ay5SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHPOvhe6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F4606A320
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHPOvhe6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59191F000C1;
	Fri, 30 Oct 2026 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400595;
	bh=DbppDLg/fp5GNAM+0ROIvSObfqKNW5IO9h5mn3kNs8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHPOvhe6DD9DuD1r48XW2ajnouRHu+9ge0gfuM3QLJ01n/V0vNJ58MZjm6I/7crJ+
	 OqT84nXe0Lt0EjqNIGPNDpHq5OarozkXnQ83hgHx+8a70NGYYKHv24B61kwuehEUVA
	 vM0qKofy/RHIUsMxnPvUZD2TmgDE3wRcJT1MItnf5xAIQu6D5/2Ti2+JeoLI08tlxw
	 96VA9DCtCPb1vc9kL9BZA89Cx2Y1mUFUrlhazZIyLfcbsS4kmRwSOp+LkgrJU6DD6I
	 qc1ygnYjmRQ2p5tMucPVbfAOX2lNdpXYpUIIib+u7mv6RzBy4IAY+HnH/+mZYYv2zH
	 PO9912kW0joaA==
Message-ID: <sashiko-outbox-191600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] HID: ft260: i2c: abort in-flight transfers
 with STOP before reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-13-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-13-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:49:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D12

