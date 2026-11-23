Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427496;
	b=gyd2I/j0y9Vh1QxEKaGWm2AeObCm6v23nnPCO9D2prVIXAkaonIbjPk0B1NwNLeegLEF
	 lK1G6gUiXxs7cw/w63FsoWmCVR0qs3eQSTlcTHlkpVwaRFx2LMWcWg8NlfHaCRrIW3wmJ
	 Jf8XFyxvspzzC5Ad3y4n3VVzc6oNU/nt4waggFgbnorHx/uM8+2vDmlCsmzk5zFZ8sNJs
	 chcYo2QieeeKeWty511SS72Hud4DGo8gBouyUNN8njZKJehaIvNneTsSa1saouJQ6uml7
	 HKodu0CkVxYcDsPLZWP7Z/R/c+atqSsLAhyYa5b35oMAjkmBb/BmXzjPD2PcSeBSf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T7z0ZYdqErVjSMNApq25on7+uX4mdRCH5zHyqDPJMmA=;
	b=rryHLm/Os1Hijdlt4NgigFyih7319WnE5uC7FBgWp8G2zfXGyD6IYAIu/UM8OUfW4Epb
	 lwRuaKbZEODbj7E/NUX4w98WvYOTe7Okm9x9A9dPjP9MPER8f7dcEXsuoBOLJCM7SjWFC
	 dR091NXBhU3Du2tr+8ev94jEQRWZTdXTYyptllrMA3YCW++CVqWED5wmsOa0wNN1bbyET
	 TWcSey1pLIzyowlEXhNhuid619+jhpgx1bj026jeHBhjBuz1dHTVL5y14llJlgiX8XDjV
	 YYskBE+YznvcISirROcVwH5P/eF4nedP8XywhFCJ7oVQHNMozuHmEIcNPAtY8WE8mlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bp4zyXuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0897606A31E
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bp4zyXuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305361F000C6;
	Mon, 23 Nov 2026 09:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427496;
	bh=T7z0ZYdqErVjSMNApq25on7+uX4mdRCH5zHyqDPJMmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bp4zyXufOJqCaYr7sfzzXRWfFYs/di2sLKd6mpZU2xEeEHo0RCHOAusKBajMZ28Tg
	 ypvqeWQS2jWpWh+A6W0qs3fMg0AHu/QymFdti8beA0RMF8UUAdT7TWmzcXIRuDRAbE
	 MqYCtD7wZpkLILeHDnVHbTTkMeokSaAMM8977/2PjQ+XnK9sc10tddzybf56y9vwsx
	 lnhtKpu2MjzbSvyvYqUFDwCruJA6KChB1f7/LT1+eh+nTuWAaHqvS4ROb4gAKojCmh
	 WxT2TR0lcCJfgBspfpKQwiBHDS8xpVB68ZNTSUbwSFYVdreE6SwtfOTUUelaW2tx5P
	 obGOXbI/Jm3sQ==
Message-ID: <sashiko-outbox-229011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: earlycon: bail out on zero progress in SBI DBCN
 write
Reply-To: sashiko-reviews@lists.linux.dev
To: liutong <liutong@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261123094843.540808-1-liutong@iscas.ac.cn>
References: <20261123094843.540808-1-liutong@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:51:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> sbi_dbcn_console_write() loops until all bytes are written and exits
> early only on an error. When sbi_debug_console_write() returns 0 it
> stays in the loop forever.
>=20
> A zero return is not an error. Per the SBI specification, the call "may
> do partial/no writes if the debug console is not able to accept more
> bytes".
>=20
> OpenSBI can return 0 here. Its semihosting console reports 0 when a host
> write fails, and SBI passes that number back unchanged.
>=20
> Fix the check to use <=3D instead of <, so that a zero return also ends
> the loop.
>=20
> Fixes: c77bf3607a0f ("tty/serial: Add RISC-V SBI debug console based earl=
ycon")
> Cc: stable@vger.kernel.org
> Signed-off-by: liutong <liutong@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123094843.5408=
08-1-liutong@iscas.ac.cn?part=3D1
