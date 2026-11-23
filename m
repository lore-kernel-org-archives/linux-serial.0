Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474704;
	b=wopKXkTjfCXP3uhDGW5eXZ2QFfj8JU6aHvLK01EVBa3rh4PNMO16ROkvcqRtbPsIodc3
	 JLMExA/7vt0kJQdFYmsZ6E/8JPBYvqTig7RoOS+PPUKKu4gW39pa5VWjXATlpAAzXicNt
	 DXWtudNJD9Y8qOQAqH7p2ARnkL1sdn4zafvDZl0TLN0dPRtaJwxStw0eglPR8NxZbI5Kh
	 MiHdkdpeh+45PZSE6Vm0lrDFzj7YVsacmdhPw03UXGQYRww515oIDDKZb9Vi6UAl2FZcM
	 1Fu6F2kJEmsi4fBobEioWYn2jY4vaTpSLMMy13UMzD80yS/aYhBZGhZx0uhhfxylC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qw8R7JhjihMIBumBOrhkO66WpI2i97BZSVRfHkZ+98A=;
	b=uSnc4pN5RGMd+Tnj7fm/ll0WEJh2RV45SphQUdMRKTb7c8UvkPnLvYTCDMbuItdo5L9S
	 lb91DNVyCLA0OmGyJchvypKW3DUBLCIlVwTRJKz07bdaP80+FLFuQ9+PTNWhKOM8zsI8M
	 qyV4Hb25TTS6MEoI+YCDOEOkMTU3NnCuWP8NKJFxQI3GzniE5fIg8QrDTVYl7MM+yVb5k
	 WdzbnWGGIynV3Lzn/micn8pzIdAttdQsE2xhzYJu5MwOnqWkeQseuilkKAZxn4vrcNMmB
	 LnngYWcc7ceINv60ledIFhuIMaPvfSaHIwUbz49kgegvIpFcvzhknBTAsLQxRWxCOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnluorfb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D873606A31E
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnluorfb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D551F000C6;
	Mon, 23 Nov 2026 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474703;
	bh=Qw8R7JhjihMIBumBOrhkO66WpI2i97BZSVRfHkZ+98A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnluorfb13MomtA+zX2/Kj1Y5/Cj8vUXE+CzHuTi8a4yOkymycp0aQqYafYrFZT+z
	 awQhb4o+SSgPwN9ll60mZhJgdd3X2LQpOiAqVraUqd23z6Sr2uQrJeJ2v82iFoypQF
	 6WPprWLFFBI5vhwTtWmzs26MmYWNf9ohI7Pzl+HNF5GOgPygxiusBv7/uHEgCmC98x
	 gZYRrrzBgOHrzaZW3XyOwAqmP56f1BUN3XxOGwi9mOCvro6NfUH6VMcphGM84tqWVw
	 wlfHL7Xd4gGgRyyRny/z/rii8CR35WQtwqDuGSgmwLcnk/CCo2OJFqhthTVwXONGLT
	 GE2TRYt8YNggA==
Message-ID: <sashiko-outbox-230176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: take the port lock when setting DTR in
 uart_set_options()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenwen Liang" <zhenwenliang@google.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261123225239.1653134-1-zhenwenliang@google.com>
References: <20261123225239.1653134-1-zhenwenliang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:58:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_set_options() sets DTR with a plain read-modify-write of
> port->mctrl:
>=20
> 	port->mctrl |=3D TIOCM_DTR;
>=20
> uart_update_mctrl(), which uart_throttle() and the other modem control
> updates on an open port use, holds the port lock. kgdboc calls
> uart_set_options() through uart_poll_init() for a port that can be open
> and in use as a tty, so this update can race with them. If
> uart_throttle() clears RTS between the load and the store, the store
> puts the old RTS bit back, and the following set_termios() call writes
> it to the hardware (8250 does so in serial8250_do_set_termios()). RTS
> then stays asserted while the tty is throttled, and hardware flow
> control no longer stops the other side.
>=20
> [ ... ]
> AI-assisted analysis. The patch and this description were written with
> AI assistance; a human checked them against the source.
>=20
> Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
> Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123225239.1653=
134-1-zhenwenliang@google.com?part=3D1
