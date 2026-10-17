Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992ED3BAD81
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223280; cv=none; b=UPeazw78TwG/magFfIghIQhVqKvpmCRAAiWMmtsKTz3gdsi4XH3/VS6fUcPfIf651y6gln0XqEX+J7O1FJfq7MgECaCf+cW90lJfWiHPTN43wA7hQiSvoSMEhMOcz0eiD+VWBYdsOl0/qi5AnimQhsCsDJV2EnWHKk+v5sg3a1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223280; c=relaxed/simple;
	bh=oTo9QDKdX3PUNVHnLBYv0kAYld7gHCDf6DWuYKTEAZ0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iZ8RrEllUOfaJC+rEHVWzO2vF7snnwglEZRUY6/jhgBGQp5yvlbSFpbKmXQ63VH/XJADKbTiaSvo9qWxpBGybsM+QBZChI5OhUwLtHhIt6wqv2fnIyf1JjOurEQBvJt5sTLK88vFtt6t+oe+YdDZpdKVIiMx7M6+lgNDi2WELOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+rFGoi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+rFGoi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF61F000C4;
	Sat, 17 Oct 2026 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223275;
	bh=W0n1kmqNq1TiToZ20oWRCL1OzyV0a9wQrqu/4SSxbIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+rFGoi76T4homILiw08YkmPQgT5b5DmTl4jcPyXydML+A9cpyS118wjnMKMreZka
	 6/lViqAvuwm0TBFsaCpuxXSFlzt9AAq9sbrVqihd/Ffzc6DrxHcXSGoRnRltlIv/V7
	 6U9XxklI1E9V8UWHZ9LTQqQlDpN0V5znoCKTrXgo3ZqNL8M6vvE2x9o2q9EWaara0P
	 5bcr15EqN5KJioJImfVQ9PwQGJH87rr+yDGYiMmTGkhSoN+6jUQj/UyrFQSysWOpDc
	 V/GCgDSrzwFVc3qCKb5Hw/h9WuGXrIpLv9wYaoaYq9r3J6hENNJPbFGBqRCxPwEoFD
	 0oRmZJPYHcwEA==
Message-ID: <sashiko-outbox-175371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: sifive: avoid division by zero in the clock
 notifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Alba Vives" <sebasjosue84@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261017074453.62645-3-sebasjosue84@gmail.com>
References: <20261017074453.62645-1-sebasjosue84@gmail.com>
 <20261017074453.62645-3-sebasjosue84@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:47:55 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Sebastian Alba <sebasjosue84@estudiantec.cr>
>=20
> sifive_serial_probe() registers the clock rate-change notifier before
> it initialises the two fields that notifier divides by.  ssp comes from
> devm_kzalloc(), so between clk_notifier_register() and the assignments
> a few lines below, both ssp->baud_rate and ssp->port.uartclk are zero.
>=20
> A rate change taken in that window reaches:
>=20
>   PRE_RATE_CHANGE:  udelay(DIV_ROUND_UP(12 * 1000 * 1000, ssp->baud_rate))
>   POST_RATE_CHANGE: __ssp_update_div() ->
>                       DIV_ROUND_UP(ssp->port.uartclk, ssp->baud_rate) - 1
>=20
> On RISC-V an integer division by zero does not trap; the ISA defines the
> result as all bits set.  DIV_ROUND_UP() therefore yields ULONG_MAX and
> udelay() busy-waits essentially forever, hanging the CPU, rather than
> producing a clean oops.  The POST_RATE_CHANGE path additionally programs
> a bogus divisor into the hardware.
>=20
> On the FU740 the UART clock is derived from the CPU clock through a
> synchronous divide-by-two, as the notifier's own comment describes, so
> any CPU rate change during probe can hit this.
>=20
> Initialise uartclk and baud_rate before registering the notifier, and
> bail out early if the notifier is ever called with no baud rate set.
>=20
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Sebastian Alba <sebasjosue84@estudiantec.cr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074453.6264=
5-1-sebasjosue84@gmail.com?part=3D2

