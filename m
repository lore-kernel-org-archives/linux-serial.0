Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790123;
	b=KDHsv5U3Rtjka4vVYSOszPNWjcaIXHbLn+x3HCu1a2IQU8a6J19Mvi5AJ+XZ0aKQQxz0
	 16EzW+d06LF6yb1hqWsH7Uo6pglSsoLg4AQp2nSpB7Y9+r4nX5kKIYeDfg5JCjHsEzh0+
	 Q6d0Ujl3mmFxx0nOEI5N+anhYHmc09OMDgcZzb6j0jWHJVxgFgtQUbyWhCG0PcFEpX357
	 KLNh19MznBZ3kxBYAKS0zMfYcYLcW6ICAPijufdp/3gfbj7QcYpf85NWhOODBhZn/oDIe
	 b8g4v7R3/8yXskDhI2O9XB1nQhmIopYJBgZJlYD+N0/GDzwQbNlyTeGLXcm71ogEeUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y8jmoenn5x6HnOWI433fGlVPwdvHn98UjlBn+9E6RNQ=;
	b=Z/PVcWO8lSRmbBqh2sul/ch5xTrM2wXVIE4R2SVwoa2fhNWkxqhCIZg1gXJBmsPQ8RFM
	 poVIoGrymrZFuPzyBP2EvKOldj+b4tNlpUF0IECySZ7P7/IShEwjQUa4EB3s71/Psmwog
	 RjC9/UMaVVeDHsmKqDnMH5hdRINoRKxnuZgJWIJu93LqFDUzvzgM4M1lZfpVSg5lTw2eq
	 7soQ2DIR8Ghh6RTnCdRcv+n6Y+U5E8yd73qMZeM1GHVOsd8nTlkAdjgbBm00WQjTjMrHD
	 dDg0q6XVWSkc5qWgs6psMPBxgZp+sW2Jxn1UWXSDJU57qz/+7Ktl5gPpRTiqwQ/ywBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bBVZ5Xp/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D3606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBVZ5Xp/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DCC1F000C1;
	Wed,  4 Nov 2026 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790122;
	bh=Y8jmoenn5x6HnOWI433fGlVPwdvHn98UjlBn+9E6RNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bBVZ5Xp/u1nJDGEROb4Su82vLzkXxMgOrAt78xCDVs2KQns87dlN8oRfw+ymrj90J
	 B5+BE3mfjvfvOGvOgpwYaX89nmTBtIzkbsAGGmCocfjGFSvj5ag2er4xkA22X4bQz3
	 u84uBBBs+hv46IFCQspellDUVe90tXqflrLOr9MSbr1n7847ccZeZXNovtrOlaShHk
	 oehrhGx6xSq1yo98KKMVHPw0Qbi7UijRkKBb994/8v+XxbFz+RXgJOOYSfNLwNVtRe
	 oL6RxVZC38IXwnVsk7seKhjOzSIoqqUnHLTOgflXGYnjtqlnH+JH+M3J9zIUThs/Nz
	 wZdsWkfSum1yA==
Message-ID: <sashiko-outbox-197137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: touch the watchdogs in
 write_atomic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
References: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:02:01 +0000
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
> On arm64, WARN()  can run with IRQs masked, so the whole backlog is
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
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-pl011_touc=
h-v1-1-e292bd834e14@debian.org?part=3D1

