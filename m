Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522320;
	b=NuT5l1a6pXlSTGrT1PwX0xkXC9ztDanH4y/Mog4J/RrubfhGaUF0r2BfkXF4w24N+kpA
	 wqsV/Is4Rk1FfCcSQLFDToY4Q6AWpnlZOJLHjk1SrWVoiVtRmy9SnMfYWcgyjyH0GjLHs
	 4mJKE8CSeUenGMvZomnVSssJb1Dx5MJ0NbOE6c9qTooNvzPA7HfoZB72uZq2jNaofVzMY
	 wB+MsKInLD1mN9EBtJGghEAdSSvAgej2YUMXuGvrzCJRGWvy5HJSv9S5Pl0Ht/Z9xiF4V
	 ggdcmf0Nt6GDJHJnfcjBwP2F8jklMPtaVQE4QB64L0kEULndU/xpuqGbbWk1g3ZRj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xyBxjWYguVciuGoA75ZGilxlw/LOJMfuuPvbaddFpBU=;
	b=P9VyhOExycuHf/TZYym2Y7UA/Ys9LEyacmgP5YFMjMHElRwxeuOOgoaNhMbiSVSO/Knl
	 UdSsRE+nM9sziv1Ay34Sb4fGS4WP10EUdglRSN3liLJXUciaTzQnF3mz27qpHJEiMF6jl
	 m0IYjPb5xXKnbjbejfAIxxWgARPhz+7ubs5zNhwjxZWsEGWUiaDcSStoBh7R5J8PYhYBw
	 jNrefSdEDIFT4o4hduxyc+WcmywiwfYX8XhJzUH16/S8ptflW36FxacSfefWaAuqbxJTI
	 QZjsQvba7GRkOb6kwHgCRBBYB6iw0D7YTaf/Val5Hx3R31xbRv6Ybf3VYKErczq1JHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Laykrj4d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE01606A31A
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Laykrj4d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E91F000C9;
	Tue, 20 Oct 2026 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522319;
	bh=xyBxjWYguVciuGoA75ZGilxlw/LOJMfuuPvbaddFpBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Laykrj4deIdj28VuRLoN3yyjH0Ddr+c3UPXXS4LOFxgJs019Rq5+epLyjFwfx+jWs
	 dAVvK0nEfdNRU7yo2ZzmyRbWt9y54Gj3QxAkkY+c3O+AOkaNqO7buOFUi/VHujQI8s
	 FLSrc5gJ6kEAnaK++2yQtPG5QIzrR4wd+d0PBjhmMJs8SuAJniBAaDT6PCaOA3DwUe
	 n7JpWhLt+1gQZa7P/zaS50yqCrrlMzKNGy5yTDYzgCkNYMEXxHVjYJuvPHOQbqnp6p
	 WW01xoAcwlipc4m/HIzx1Zyf2EIn8TdskUCQwDGn21tW+YjSGCii+1TvjTqPHpmLIu
	 iSnEJMv1dI/Zw==
Message-ID: <sashiko-outbox-179496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] serial: core: fix division by zero if old termios
 is present but has invalid rate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261020184131.2893575-2-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
 <20261020184131.2893575-2-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:51:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> If the old baud rate termios is present, it is implicitely assumed to be
> valid. However, if base_baud is lowered via TIOCSSERIAL, and the new
> max value is lower than the old baud rate, the later will become invalid,
> and uart_get_baud_rate() loop will exit, and return a baud rate of zero,
> causing this:
>=20
>   WARNING: drivers/tty/serial/serial_core.c:547 at
>     uart_get_baud_rate+0x104/0x180, CPU#0: uart_baud_test/782
>   ...
>   Division by zero in kernel.
>   CPU: 0 UID: 0 PID: 782 Comm: uart_baud_test Tainted... 7.3.0-rc6-...
>   Tainted: [W]=3DWARN
>   Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [ ... ]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Hui Peng <benquike@gmail.com>
> Link: https://lore.kernel.org/all/20260930125901.778868-1-benquike@gmail.=
com/
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020184131.2893=
575-1-hugo@hugovil.com?part=3D1

