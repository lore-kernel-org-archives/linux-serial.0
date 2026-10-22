Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639224;
	b=4L8kPOZJez7x06hQtc41VXYqfBuTne6iAlsGUGkPZnzpD+WJVrW23Pqqii0+hscLGGiV
	 aWZZpAIcUp8UL4EIVGiTwkSPS+8MsbBw8RdtWBZWNTcvV/CodLEyH4u9Wh0q+Ms2IfPtp
	 dO1OiG/Kz+CgMsmxiJnTu6L6+pJpxKKMckh2wQCGLLMfEQoJcKKb/Dy0hW9GC7uZbRMHo
	 J+UjHCtsfSiVCjg3TAiQ4MIgfYJRvuuM3+e+Y0d98O7Vi9wi2e8Z8JokFPT0pacn68cVP
	 hdJBo3pFMZB4Ck62hcPxeM08YJf4JttDE81oOtaWuvYxaJuSQAzFTKRJxnfXC5uBz1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XmYJvXPM2C7j2KAfwMSEntIxLEXmLm3wZl5MHZU8aCI=;
	b=GVD4K2d1LXJV5HJDeKJCI7rB24IS/J5X0hqV8xaDPSkmiFW0MsbV6luuZBzAfNFS4TVX
	 SBff8EznMuRE+oDzEmhKOOVyA/dM5764yqwMZYKZbrjE5XAHIQKo4lkNWcZjRo+BHTWkf
	 gmpRDmwi4vXk66KjwVdY7Z41oQjMke/caBNfeprl6m1yvLCgR5Bh+NVyqGrK5uzwKBpLs
	 y1JaIMzBViNwgzYkMdyRbnPiNpESIShXtUPX5fvk+IptKJrff4MmHE33LCC2OBAYUOyEL
	 xfhHtL88csgn23YXMPT2xOoOTROYrFw1TcMCZgRw+fbEsoauH8Va9xKfZ2Hx/de5JcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8ayY2VD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9441606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8ayY2VD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6301F000C1;
	Thu, 22 Oct 2026 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792639223;
	bh=XmYJvXPM2C7j2KAfwMSEntIxLEXmLm3wZl5MHZU8aCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8ayY2VDjWiLyFLIiE0QGqP+EFTfX4Fbii9zzMu7+N/KhgaDxjLI9yTcjZZTYN5FU
	 A41on6I1TPOQ1pbCE3oB2QPC188PNG6s8LQh99mER7LRccs3Q+rdOqQRnAiiFk4TMC
	 NP5aPy+ePBSQ6RPiA/0Pmg9juZzWREEdqMR7CyNGuCJRks4UI7bsS3lV8NBKNhsZAx
	 yywUaa50/KOVljhcfRpgu2dpu/khR3VjmKklJhRcLXbJq9UTjm8ga56mQovF8Njc1r
	 VZ9T8EzHRLabxfNQX5MaLBVlWb6g2jvX6qr14n/vicOQnn+sHL8uk93P7cusYA57sj
	 kpTIZZVXPxf7A==
Message-ID: <sashiko-outbox-180944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tty: serial: lpuart: disable hardware flow control
 in lpuart32_startup()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-b4-lpuart_rts_fix-v1-2-207f91580dee@nxp.com>
References: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
 <20261022-b4-lpuart_rts_fix-v1-2-207f91580dee@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 03:20:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> The RXRTSE/TXCTSE bits in UARTMODIR are configured by set_termios()
> according to CRTSCTS and are left untouched by shutdown(), so they keep
> their value from the previous session when the port is started again.
>=20
> On open, and on resume when a tty is attached, the serial core calls
> ops->startup() before set_termios(). lpuart32_startup() enables the
> receiver (UARTCTRL_RE), and with RXRTSE still set from the previous
> session RTS is asserted immediately. The remote side may then start
> sending before set_termios() deasserts RTS again, disables TE/RE and
> reprograms the baud rate, so the characters in flight are lost or
> corrupted.
>=20
> Clear RXRTSE/TXCTSE at the beginning of lpuart32_startup() instead.
> Together with set_termios() keeping both bits masked until its last
> UARTMODIR write, RTS now stays deasserted from startup() until the port
> is fully configured. The flow control setting itself is still owned by
> set_termios().
>=20
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interf=
ace support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-lpuart_=
rts_fix-v1-0-207f91580dee@nxp.com?part=3D2

