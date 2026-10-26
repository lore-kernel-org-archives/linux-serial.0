Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030718;
	b=1gJZIECJTiBZzCi/zYksngNwXXfZJ6Q9PXcJDXRw549WH/2TPSxdkn0RVuDABF54PIk6
	 hNmTHcBoEftomX3kRom1nNyt8PnU1v0NWOG2Nanhs6fAPMK7Op5AGcu5Y+n7Qsb3vCizv
	 4GUySVBnJDKpWjDXUhHUi968K3Bl1qa366XjzJDcUDN1g2t1znic+rZVbmD2DMggqTdVd
	 Rhw2LBM0F/T1idSlAWIzeXX9MQCGT5uYMDnbOekN08gLjiPA44hZDdquMNU5kST/FrKX3
	 AHzsVIb5xPYYtE5vI+hJn6FPO+lmETdsHlm5/rQMRgJMAX+9E0BhnTtq8+jvM5er1cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yZvWnAJ3VH/4ud/aZ3ktEpqmyaxd4H7MHtCCUOnfbv4=;
	b=voX+mukEsT/3SQ1f7O7WlbSYt8qQR6MI1ETYC5qetY+Ye2uQi8vP/cff/FrnQnx619Z3
	 U1P26N+OT1Q4BxvshVMs4tHCqGs7GmiWVX8odz8JmOwGPUQ2DzAV8kqanlhk3nP7NatJ0
	 G4z+cFRotGs6TU5JD5WVsmaEl6NOpdsmZKupT1J0tOPBPuRK5d9SB5piBMZsNEmaef4tn
	 GtFt9MHvefxn05VO1wINYCn4tvNy15expTqxjSL9QJcIQmXJ2KeR7ySGQOOE++JB6HdtW
	 TUoC2t7nJjtorPfwasKGmhUOVL1LIH+0NczhWkPQoAT+FmmFAbw9rCpQfF+essKHuZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4Qd0EE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EA606A31A
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4Qd0EE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702121F01828;
	Mon, 26 Oct 2026 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030717;
	bh=yZvWnAJ3VH/4ud/aZ3ktEpqmyaxd4H7MHtCCUOnfbv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4Qd0EE1/zxviWOxUVa17NXpBGGKqUflABkzxNYFd70nOIHVvA63+kSh5+GIZdVoV
	 k4GkrQiey6+GuRsIghJkr1IKtcYW6znLFgLEbRd1qqulV/uHubQA0P4ES5juvMB5e0
	 5BTCpGKMjIO4HQslTxb3XWb24BhQzWzoyug4TP0nwRhevIgczRDlhV55y55/KcXRoy
	 ChyENEYpxLzO4MTtYgUBcgW+Xvwns7REC7lyIwhtjbYmqtcO2j3pgCsRElZZMN0UrK
	 +Hok2vsZxPI9CQj0IktzLcQRAbcR3HKVoSI1x+LtpDWZsjf3pDSJm+171IAR2WzqIl
	 v0LgqkzM+z3Bg==
Message-ID: <sashiko-outbox-185487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com>
References: <20261026-submit-serial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:05:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
>=20
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
>=20
> Expose the library's fractional-divisor calculation and DLF write as
> shared helpers. Install the BUSY-safe setter after hardware discovery and
> use the shared DLF helper to program the fractional field only after DLAB
> has been confirmed, alongside DLL and DLH. Select the shared calculator
> when fractional divisors are supported, preserving the core calculation
> for integer-only ports. Keep the check for fractional-divisor support in
> the shared DLF setter so callers can use it for either kind of port.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-submit-ser=
ial-8250-dw-divisor-v1-v3-1-7dbd194e1f38@gmail.com?part=3D1

