Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664114;
	b=GACkGRyLEKOYXpDvumEiejmnQbQm8MgVommwEPlGOYjQRETM5tt1mE0nd8zcTkeRnGYA
	 MLlQu09rr0x9YRV+3064AfxIhXbAAcWNdAoO/MHKdxocuY9wPRxrol3oa7kM2bTjp3g63
	 cMhJK8EXx2/m33eGsaN/C4L1Dd3YMamf/BbPH9+/zE8+qstdR2qxlxFhN+sls1drSZvjA
	 /Mke12rYcbRgZzxLow4mJyOiY/XXLFo/yqtmdzB1yTLamvFZ86kSi3P9BD1o6MV4tIU50
	 38etF++XPM5/V0liW39pFjADrfZst88kktVPcCC/eC7mFFyVeGOenDOtabawfhjy9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YFLQrgAz0QgMAZKogVK1T5bXloVwbTalE4jyA55NHT4=;
	b=n7ep6nt3cxLqm27bhlqGh+739tzjwLk3+pAE678Lhyjg1WS5YpfWgW5J2q3dSM7ztUXz
	 z1GR6Kt+0pQYxsRTYuQCmRg2hZflzU0ZYPJL2KU4HI0tYdYfJGdhUtLjW2f+0P+HyDn6V
	 Yd21RRW58F+zLygBIKXXzYq7Ix9YhYWYxjCKJfrNTtXT+UKSCFxF+/eWrEzML7xVPILB0
	 u60KkjT25dyKueIpWFDfFPaHY6SGVjJP4DvP1Ue+yvq6zvOYUf5Z/zJl5SMWa64gaJL6X
	 K3VQatUeARhGaCIJYzAe96dc+YgNrH2plMf4QS0HMfCVLnaVuxKuwAIWSMjx/n/0UAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwnqKLc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5C606A882
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwnqKLc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7378B1F000C4;
	Sat, 14 Nov 2026 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664114;
	bh=YFLQrgAz0QgMAZKogVK1T5bXloVwbTalE4jyA55NHT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwnqKLc7yyQYorcRS+RO7DX8W/XEaxv8X4XEd92ZY65XyG1PT9WM9CnBVKczWFcDE
	 wm+BsiHbbcaxrf2YyWTxl0Jo594bU49jvZeqDMzYvxQdn8LVUXmuON/pLjannjI7t2
	 q1xFqOOk5asCmu1E4DqUKKfkEbuqGp4v3DO6XKHKVjhAbOYRF2rVtc1Kz3tvEwD5Eo
	 gKGMikUdlbp05b9axHcmsxInCQHb7y15nQemk8deKaBqZCUdppBjx7RzbNi3OpVna6
	 L3uCbczshSGheAQB81swqXyYm1QrXn/UejDv6ANJjpAzZkQTFYy/2NAbajA/fGRxnP
	 WDOP6B4WPZ/OQ==
Message-ID: <sashiko-outbox-214593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-8-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-8-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:48:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add a minimal description of the Cortina Systems CS7542 SoC: the two
> Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
> PL310 L2 cache controller and the four on-chip UARTs.
>=20
> The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
> boot strap pins. Until there is a driver for the global control block
> that reads the straps, model it as a fixed clock whose rate is provided
> by the board.
>=20
> The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
> 512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
> ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
> describe the memory and the console UART, and reserve the top 64 MiB
> of RAM which the vendor firmware hands to the packet engine queue
> manager.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D8

