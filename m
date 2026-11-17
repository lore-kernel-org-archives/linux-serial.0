Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959215;
	b=j7IPdzBgTJBzF0z82vaJBjdhoMzbmeaG8LDz4U+H5gUMiaQoiWTLhrUVL2fkZwAPXC4h
	 mYGGN8na01U/h2lUfZygJANNRcfg74XBUKxHrS05opIbglzXYXQ4luUGA//pwHGbEiMjB
	 x0xTKIM+guat85IFmm/aRR9uNvNUoA2ZObUub9JT6cGPIcGQ8cUFq9BTNUrDzAU4sPivB
	 7Eu9rYwVRQUezZAEjFWHE4JSeJyQoyke2PMeEyj26SKhfOQ1SnvGnIoXtJSNGcJkIIwq4
	 Sk4fRGKJ36RHvnlGHzBIzxzWL9vos6IMqDjY4uPrf2FGlLYn3Rhhb0NE0grJo4xEQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FyGyUJCmQB4xEuSvdD/02hx+bsMhS+qlJAW926EbzaQ=;
	b=IuPkDbxamj8syMpZQI08j16LgbG8nNXaAIPBoL+OX91z37WdQHt7J8zFNQpKQ3zbfV7F
	 mwHevaQQ//RgaM9q4F1i0P9D30XYounT6krkKVmkIqnc7RBcCN6j/nE8qpi9GKf5bpC27
	 aheTFZ86474t0DawEYBAL2no7MEAhxXQwMc6pvz+76WRaKPsoFMfJerUxL/uxRpvXwiq/
	 DsXGI7gBNCHIeyYofl0hFgf5Yg4cFjPCYREGoLA9XkkuO5XqmTaCMTFWl3d1uqSuO7G9I
	 KMDzPa56RLTNVwvfAsBQbl0VfpXSUZ5pNFl3LLb/UlPtJSTawi/t9OdwNPsMAZQuqXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ6ql4k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E7606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ6ql4k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79001F000C4;
	Tue, 17 Nov 2026 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959215;
	bh=FyGyUJCmQB4xEuSvdD/02hx+bsMhS+qlJAW926EbzaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZ6ql4k3sGE+Yo9n8NAnIzi5EqkGoh7gNATxbeXL+/D43mRBBzrv1KnHHtuygnk3w
	 6c63o03873LFMsen35CAWZ3p5t0t+4bnZDZtJDwczlCOp4IOnS1usDih6yC2y2q3qr
	 aryg3jYG4cvVyv7k8/3WZrg9MWQg0OaWaELpFkHP261aOPZgNEUR/Rk5GyF8qI+gYU
	 WE/uM+RT38CvXt8LLcrpbdUwAVfKNFPzNLpOrSGBEJYIs+y+uU7F6Ol+8c22RNcYAG
	 AWC3MRpBJNmeojvzAvygPAG0UzaEbD+9szIdo+5JvOoIuvC8XjPyDYJuPwEkOpkomm
	 Q/yUbNjIfdRag==
Message-ID: <sashiko-outbox-219805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-1-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-1-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:46:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
> SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
> PORT_SCI once the transmit FIFO is empty.
>=20
> The hardware manual does not describe disabling the transmitter to end
> a transmission, so this special case has no basis in the documented
> programming sequence. Remove it and let SCI follow the same path as the
> other port types. A plain revert no longer applies because the driver
> now uses a kfifo, so the code is removed by hand.
>=20
> Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D1

