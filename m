Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301462;
	b=QGNwdtIGUdGNmzqd2t1T3xMPZI1zR3/dMUrX9puEcl8wdNN+xvENW/QT9PPW4sOPVFw1
	 n5b4ALHsghU4qXjlfXUDXGlC4mo4ht8Qd0TewN3BjZcGnjds66+k7+MYWABDnNvBP43on
	 sylMn4x3HgW0JEl/3PGvryWm5j5pwH2if0RUzPS6JFUYObLta1/BzQerxBZVKy17mh3zN
	 OI7eZ/MGFIe3qdfRYoVpRG5AjwZpbISMpAMYvUQ9iPPBVmIAxt/h99cMQQQNRcf4roYP7
	 LPE9ZvQo1UNsrnbthm2vpSipGIHpdwPyCA7FAVjkDokoRnBuB7xv3M0A5tmb/Hy1+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JBuw+g2m3jQ5l7bMusBFIfpY0e2fvKQEg9WDbxROlJo=;
	b=3iFvjCl+xVSuFEVcEbcI6EmbyprzYW0qQUpA/9xUNLFv6/4X/rBPEJiiwzzfnnBG4R99
	 5mb3K7PQwZDplyCYopTCepdmshm4EcTpcA29Gy2/dk0vEhPNCLTl605kpbjupKjTo0J90
	 0xsHrj+dPqxPh1vIdzpZtx76h6b1DT6CYUC+DlkXBe8SN+r6HJpZRzTUVHE/syOSCCrPI
	 3hNsFgj0hQsExq22LKjR07xnhK3mm4CdctXcUgtepYQR5jNwPFNHqbZbkAAXILIaMJ1zZ
	 Xd+QGagAlwlppY1X2NUCZKmhN9Nj91nquFE82P6tErZMD3+zFvMcRuBbdsa5+GrlV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEjE4XvT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF822606A338
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEjE4XvT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0731F01816;
	Thu, 29 Oct 2026 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301461;
	bh=JBuw+g2m3jQ5l7bMusBFIfpY0e2fvKQEg9WDbxROlJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEjE4XvTmQcDbjvEGj4g8+J8MdrlqxXqQF+guzOCccOpSQoYGrcFKYUZ7g1jE+/GO
	 z2qXNhGRbfZD9u8Hpg5BRhyVmiaDKWbwypA9RqJUOw2OdBAC81kqO3kfAG6mf3aNP7
	 2Hh2NKDns8MmS6TxYBWrPCUtSzta8TZDshoXuQzYAzqmjkQGvxKk6VtF76PtutGXfJ
	 j0QBwDP0L8ONPwyQ0cCQBrU08rD5oyMDdDMxVkxrqAiyCu0HaC1ZtVJnh2Gnbv0ekZ
	 9mOsf5tnY+tGMjstL8qGG1E2CZCc/+/zK8EqoPsKGLcCqq5ZHdUfWObG9fpKy++PGa
	 QX1UwT0NKonRA==
Message-ID: <sashiko-outbox-189863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-4-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-4-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:17:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
>=20
> Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platform
> data. Use common Allwinner setup helpers to configure the transmit load
> and receive trigger table from that depth.
>=20
> Derive the receive thresholds from the documented 1-byte, quarter-full,
> half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128
> and 254 bytes; the normal 16550A half-full FCR setting selects 128 bytes.
>=20
> Allwinner encodes these thresholds as fractions of the FIFO depth rather
> than fixed byte counts. Building a per-port table from that depth keeps
> the mapping in one place for integrations with different FIFO sizes,
> [ ... ]
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather th=
an
> an independent baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D4

