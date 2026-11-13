Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597222;
	b=5W9s4lCaZc+gXwXJP75IIOafSbLbxlZGhDld6nlze0FjqNyJBnG0S9GWekz6tl8xhOS2
	 EMWacAtZQTcw3KpVp08tNKe1eXa55unWmUxz0I7tqQNR6TQrrv/uPBUopViRq0Z1zzgwm
	 IJDXHtH2BQ1KmeOaZExKCWvLTUc1jMy+3ZwXbiiA4UfGYNRV3tiUMQ3n8+wHPQVQleKyG
	 Rn7hkhEaqTRc1wwpFU9fhtTTWJtRWRas1MMitTMF7S2Io02tsFFfBxfqVmLxzUNweudYn
	 zg3l0E33RFWRyvWruMTq/iNxi19m75hWrjJ7Yinwwwy7/t9pUyLh6ah3jZ+kGZ5k0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HOe92Rp5aDdr6EWzeJTonF8yjpe9olzuaZ4/itmvD6k=;
	b=QNJ3OP4j3XX+/kNlNE4sk0HpET10miDJuwsH0UJ2YPPG7Ujx0U7HWZGS6Dn9d6C/D0Tp
	 rneKdayGmyMUZtuMx1wXMy9P0AGWjHUYbR2tvN9rQh2/NCnj7VLr9fRkbWs3UOiGIXw5u
	 vbwMWmM8owhqkL/KLeZVp3xM+aTwxahuhnTmrkpRG6rhwflN8JCny1xsnKhSVhPWpBZla
	 28hVXZ8CaSfhixQEp0z0oMSP/hM5sCc2sCS90Ev+plgMTRTyEWNEUrkDwtrsn1QIwj5ZS
	 PIkf8b2EpUfExZdt4PvcIj+0e3FsSMPFNXI132aF+pVg1yRzPQcn/3ZWIwu8GQ2uUBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dk1sAFzb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDF606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dk1sAFzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A01F000C5;
	Fri, 13 Nov 2026 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597222;
	bh=HOe92Rp5aDdr6EWzeJTonF8yjpe9olzuaZ4/itmvD6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dk1sAFzbVYlSj1WlFYZv0amg11g0HamFFSVDX5LXIxfNb4yFaO7Il+uOwLLJ2whyp
	 M42O7tIb/WS8smuvj3lbziq2GdaDFyGKAetIFqcrw3LFpOVpadBHvl/84TLawKnwnR
	 n9Vn7Iqy/QVAHP8l5+cmVw9DXlkNRTjQL2JWwp5FMwxLFke5pTBZwejTlNHM2BMTYr
	 FtdS64HnHJoPATfCcjJM8UP5akmrJ0pHWR3xIahhitxg1miHsDvGb4ljj3c8fMSDpT
	 EbV3/tKRmjeKtTrN5BtVV7Xek90pgb9TMl2i3Dby4hXxEl/lwMcU+cuPWW7o77k5gV
	 gvkeTXZDt+IcA==
Message-ID: <sashiko-outbox-213526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:13:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
> Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
> console on UART0 and the volume down key on the SoC keypad. The power
> and volume up keys are connected to the MT6363 PMIC, which isn't
> supported yet.
>=20
> The DT only describes the memory that Linux itself uses, which is the
> ramoops region. The bootloader updates the /memory node and adds the
> firmware carveouts to /reserved-memory, so their addresses are not
> hardcoded here. This DT must not be booted with a bootloader that does
> not do this, as Linux would then use memory owned by the firmware.
>=20
> The ramoops zone sizes place the console zone at the offset where the
> bootloader expects to find it.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D9

