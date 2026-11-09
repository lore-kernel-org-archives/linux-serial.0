Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193190;
	b=pgn55wxyOq89rfD33PpYdZoVH/31H01GXRIREqW2Mz9+Vpcg5golQxTGoisH2Cua9xde
	 2eNKOIhd6PdL5QVgAnfhCl/psR0N926vquiYvaVtOdLVTy+xp0HHj3uubvPJ77/EyDvCi
	 FGAAcW91fayYYn+vZIYBUPOkFuddhvl9+bw3uvHHiGeTnE0PSzJqr896VV7em9UVfvHZm
	 2+frzu0XfyNmy1DOc6DqxMDQ2L8FkNbEGmr0Q2jxv03Bof13u5MnwJCzRHRwSZZ2+xjrP
	 cDh+rkNKLHVkt4oTohZLd+kifeiQ3AMKK8yLcGE7zvoqPT2w6zoyE6BRUoSG3dqPgUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193190;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=93K1fr+B14DwCbta/Qq643oZmk2xAbO+p0qiD4tzrYg=;
	b=WvTjV255O9HaoaoEVEsaMsLTbc7fsXNmp2QTcSFOb95hAnbBbnShUrGcLT6c69XJ3aI8
	 KkyvEVhO11Cg4enkmleXvwjtRnjaUPYysjE4yHHcd3MJTUwFrhYllar88WohRFOU+gNVl
	 C4KsjtBQJcu1n2u5YxecQhUw9Gfr10b6boTpqhc1MEMI5nAfcbGVy39Z83iHoSfjcGcwc
	 uTZJAIyXVMU2yHyMWYWAi1MTDPes1FwTXSgMtICbH50VFwVixBiXh2CK1if4hLnILvuOq
	 qF53OIqm1g74Kez1er7ux99Vt98EmO1nv1dMpedNeHGB5HDSTY5REvCIDiPc/cx9VLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnbPBts0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9768606A320
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnbPBts0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614611F008A1;
	Mon,  9 Nov 2026 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794193189;
	bh=93K1fr+B14DwCbta/Qq643oZmk2xAbO+p0qiD4tzrYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnbPBts0TsZurFhRFDzIhad3NZXzgO+z6dhVC9QmTpKhj40Vtr3QE+WxaDScqv0zf
	 5x0DSJc63kMjVDfLPI054de1nBynUG3eZHSzLoTkrg0sx0eA3uFPqJBNOZB5oYhkgE
	 n44P8WlTx4Fj76OCorwqjhx31H6jwg0NeDOOYkIR7ym924FHnpxlKCh7t6u29Ekw0q
	 WM2YAYRLIaLZL9xdDkNt9f4GcB7g+SjCC0oxEbRmiJ1+pGKLtWp1IVV6impHFFsGqE
	 wzVYFWSZAL7U8ZXLO4/HlVnPsSdngP5qAHPl6cOfBc7zYIYjmNt6GTV2uoFSTVcWNI
	 z/fb681HEvtnA==
Message-ID: <sashiko-outbox-204359@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: 8250: add Microchip
 Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-core16550-rs485-v2-1-a15933c7b907@spacemachines.com>
References: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
 <20261109-core16550-rs485-v2-1-a15933c7b907@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 02:59:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kohei Otsuka <kohei@spacemachines.com>
>=20
> Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> including the fabric of PolarFire SoC. Its registers, interrupts and
> baud rate divisor follow the 16550A, so a driver that knows only
> ns16550a operates it fully: transmit, receive, FIFOs and modem control
> all work. What the generic driver cannot know is that the core raises
> no interrupt on TEMT, which it needs to drop RTS after a frame in
> software RS-485 mode (em485). ns16550a therefore stays a valid
> fallback, with RS-485 RTS control the one feature that needs the
> specific compatible.
>=20
> Add microchip,core16550-rtl-v3 with ns16550a as the fallback. As for
> Microchip's other FPGA fabric cores, the -rtl-v3 suffix is the major
> RTL version of the IP, Core16550 3.x.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-core16550-=
rs485-v2-0-a15933c7b907@spacemachines.com?part=3D1

