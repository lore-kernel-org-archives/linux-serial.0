Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742359;
	b=brIpshqSnWY4lPG5TcK4Kr+93oP/u5wYM5LSPzUb7q9WfCBTMlHoFkehOkm5LAbLVEZw
	 UFzvOl5GWICguTcKz5KVbdg8Wdqd9W92033VEG4X40uQ5bONckZ5J0eyMSky5agBtVMeV
	 6bZ9Ey8TEpVciVwfWu4IpKA5L8l+Xe4B76akqKGq7KHsDxaTGPeXJcLSnMJdYUMtpB5Nl
	 20EC7f7er4a4bvNeewOaPKHkkD3vM/GjV5V57jCQ0At7hLvNCvDBk2oNln1cGP8urWfAZ
	 VPwlodrWn5XH5UUv91neE0CWCw1R2f0gv/ndrKqoMDBu4UvArrqjZ7J0UIdtsKLwxKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742359;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nmLc/0yMTyqfsPUYIvyCpp/zso+DZrwDmqLhayHZNXw=;
	b=QckM8AFqxN8Ij4Jvdg5l90ARWezMtdpwWAidQGTy5edlWLr4y+vysyEw2k78393ZOI10
	 vnQak5zANW75PxFXqM76MIZ9PeT33wNboxuy9fof6xtZP30gM2hp0kCvngYJ+yC+I5mac
	 nhWPsXRzEgddT0z93Wwu8oCMS21Hs+Km1lT0nPGVGh/sB0rlLi3xJxYTH9OVpGhpXhMP/
	 qPtYk6ipTpj4tkseJ1Ay/lZC3Q+XwEiO0pMjPCBs+gag1lNGrPg3m090BxJJ6E7V+HUkE
	 Atku2emIkOpQMJJEuns2k1yUQq3wnt2kRnCngwKSTt22Kk3OGfoO/i1DVBdUEjxmhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2vrquOd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F8606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2vrquOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FDE1F00919;
	Tue,  3 Nov 2026 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742358;
	bh=nmLc/0yMTyqfsPUYIvyCpp/zso+DZrwDmqLhayHZNXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2vrquOdK38U+D674DHJ+voD5qx78LbBDrco57YO2xygxi1iPfjeR8gLpMnkRuQ6X
	 EDXrbieGnO0lfHsQ1tQLQbldTIqv7q+758dYMXLB2sPFD9tfnaM8Y5AbYzvdCHGm1K
	 hny2iLCjHLeMFbqjv09dpNZXelzs2evww+URrm4SAXFzcSFoEnpRt/qz/PV0W6NGNQ
	 yc/OlJdW63eKvFU3R6p366cHLVyTgEoY1ljNanpAGBED+GQPjMUpjHf98CSIFOIsJ/
	 bt/lpS9umMe2hitKjoDdqJGQqA9/xCLgDlDXtWXWXrVZYkLr45RYwDVRrENlnHqmfD
	 zfcL7jTidpw2g==
Message-ID: <sashiko-outbox-196073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/12] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-10-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-10-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:45:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration, also used by A527 and T527, has 64-byte FIFOs
> on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller repor=
ts
> its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
> offset 0xf0. The field holds a byte count, not a logarithmic encoding.
>=20
> Read this field in the sunxi setup callback when platform data does not
> provide a fixed FIFO size. A fixed size takes precedence, so H616 retains
> its 256-byte configuration without accessing FCC. The probe has already
> enabled the clocks and deasserted reset before invoking the callback.
> Leave the FIFO clock-control bits untouched.
>=20
> Use the shared DesignWare trigger setup to validate the depth and build
> the FIFO-relative threshold table. Invalid depths fail probe before
> registration instead of producing zero or truncated thresholds. The 8250
> core derives the transmit load from the discovered depth.
>=20
> Select this setup for the A523 compatible. Like H616, this integration
> has Allwinner-specific debug-divisor and RS485 registers overlapping the
> generic DesignWare feature probes. Use the common sunxi PIO setup,
> BUSY-safe integer divisor programming and software RS485 handling. Keep
> the APB clock gate enabled during termios updates with SKIP_SET_RATE.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D10

