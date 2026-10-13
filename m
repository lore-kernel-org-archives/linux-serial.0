Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07274471CE4
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863627; cv=none; b=pW5dr5Ou+mraxxQtXxaXDyDNjWLfv5pZcbkzftti5co886jqc+M7jT9VO7BAfOH+eWjn31N4bbhqTVzM95gZakAP1/dGLBcfAPcosKqh9iHuzLbvjgn6RhDkEZWyzk1EuD9+82QACOXn26aI1Yxw+Wc6ekfoSdr6WclT2yXzEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863627; c=relaxed/simple;
	bh=WYIP0+X27uANT2mUoI1e0Xj84xWrCNbja05z1N73B64=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gKpdJ1orfo4yKRBqAO4vl9kYUGXtFg+Cx/tQ8Kz52o5itj6HUTVSNRFwC2WscQRIDVWCOTaSKDbT4s2iINi177ns/LonGKZcce1oqBqKWxCW9jq+IDpKLM0JqMXAU4NNTsI5+HLnVktV7kPv0LvCJDYMjtYtvIu6o21/mg47N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMGXKSLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMGXKSLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C23B1F00893;
	Tue, 13 Oct 2026 03:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863625;
	bh=WYIP0+X27uANT2mUoI1e0Xj84xWrCNbja05z1N73B64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMGXKSLhfIYCb7WdRrrfOnaEN/76HRPCwHWBqziXIT/JpTbJyFZttvr0ZSMdAMiT2
	 d1v9uiNn0ZkgtVg5SWvwuDI9qCaK7h9rrfVnmXLDM0MTpv/aHZLRq1Aies04pFxDIF
	 +BPmEuOhGm1hhogPQnSfdJao1G8QccJY3ni7U9TsPJlNpqsL0A0yv+WehmkQO5K3Ce
	 M6JS377L6joP/V14WndYJ62NXCbS8tnhqCkF4/wM9AS2BGNpGj/RRu2yXWd88dT4qm
	 8kyitK/p+cwcgDnrP9RB8J62JKOyz8SJm/ED1BV4HjLUyfbXaaxMWoShX/jH1a6PJM
	 oFoRU/cIftxNA==
Message-ID: <sashiko-outbox-168931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-8-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-8-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:53:45 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

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
> describe the memory, the console UART and a ramoops region, and reserve
> the top 64 MiB of RAM which the vendor firmware hands to the packet
> engine queue manager.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D8

