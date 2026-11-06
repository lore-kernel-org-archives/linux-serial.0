Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976979;
	b=yxJsZmTkl4X1KjJqerXmInsVUG+o8/KQggNdTLYiCGB38ol+YNQl6gIGLnegAYrxvBku
	 Bni6i7rhob9oJPx3X0rFqVfg85cEFjyJG1iN7S4zfZGX+CO+wTMfUsVmlq37MoSFhFN9U
	 EDjCE1nSifBb45/uD9sR1UiBz3pcIA6bAANLBSLSFQfpVnnY5KABT2A20/afdbF4LgDzO
	 eekNQN6DimRklCiaYZHAHbJFJqUyGOEeNzEm6qPatOgYYv/Xw9Ip4Xh7bsnZjAD5QtNpw
	 zplvJN7q+4kK0WEJv5mZOFo/VtG35iBCjIGqaMy1u7mfE/yfFiZX8lv7K1NKVncvW3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IEZWLk/AGoUYBUKudPzypu/X+xW0lzdHtoUypJviS28=;
	b=KtSsJNaqKO6Q5br+N120L6y+67S2HpVmOEV8HH2+umqCP7C+9uJJEA/GOjkmEI3ztS9e
	 jnHELol+CvwsDoyqe9R1yDUnkFuUWyVR2/pZyHf1+cW9FyZYpUgp7Vsed1q64SUvbarCQ
	 Ke2DfAwTBcFDqeCC5RPdn5GUvJofGdFNP/vflBqCfLGWzRzE8gu7AYkhckv41QdZmvpln
	 0vwVcsV+Hk8X8zSivnHFrnLyNGRVnDccbaO/3dCXcYE/4RQTDvb1+/WlVdHepxbCAwthR
	 xXmbBWPTvl5FfjmD7O4yklXhyxVLgVrulSw1cmEd7ZH4EwPcr7j4NuON83iWYVMqboQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIVEYIF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290B606A32C
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIVEYIF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D01F0089F;
	Fri,  6 Nov 2026 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976978;
	bh=IEZWLk/AGoUYBUKudPzypu/X+xW0lzdHtoUypJviS28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIVEYIF+wFWUFZisTcFzMZjuDAMI6I/EkB9RBsWAFTjnhnJSDngR6DwwlXwK6mZ3h
	 BFHtPzvKvnZmDXG/11/GYiPxpvy+38KraQMj9GyhkiwzwX4mqme8ezsOgdoD+Rv9X2
	 LIZLIAV8L2acig8nHU6tSW20X2CnBwPystXGoBir8KIPRd8zrVvPSq3TVqLWKrmEoR
	 P0kT/9TgB6lsm4ykjTzkE3CZdhX5mtw5aHUKr/oaQMrKf1Wig27BzaSjaPuQ3uiSwh
	 C/jCMeglzDm2W7UiED7zs25Ry0HPfNct9VUJyUQKg9mXy70kj3IQUyW24J5IwQ8cEf
	 y+TVTJ6R2CWuA==
Message-ID: <sashiko-outbox-201628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: touch the watchdogs in
 write_atomic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261106-pl011_touch-v2-1-8f4996113320@debian.org>
References: <20261106-pl011_touch-v2-1-8f4996113320@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:56:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> In emergency context, such as WARN(), nbcon prints the pending records
> through write_atomic() with preemption disabled.
>=20
> On arm64, WARN() can run with IRQs masked, so the whole backlog is
> printed with IRQs off as well.
>=20
> Commit 9bd18e1262c0 ("printk/nbcon: Restore IRQ in atomic flush after
> each emitted record") does not help here, as it only restores the
> caller's IRQ state between records.
>=20
> pl011_console_write_atomic() busy-waits on the UART for every
> character, and at 115200 baud it prints about 11.5KB per second.
> Flushing a few hundred kilobytes outlasts the hard lockup threshold
> (10 seconds by default), so the printing CPU is reported, or the
> machine panics with hardlockup_panic set. See [1].
>=20
> The 8250 driver avoids this by calling touch_nmi_watchdog() while it
> polls the transmitter. Do the same in pl011_console_write_atomic(),
> once per record.
>=20
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/all/87wlqtxb14.fsf@jogness.linutronix.de/ [=
1]
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-pl011_touc=
h-v2-1-8f4996113320@debian.org?part=3D1

