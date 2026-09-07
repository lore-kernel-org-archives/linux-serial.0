Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A79503BC5
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802595; cv=none; b=QdhNYHY1ZCOOy8Du7jyi2D3dsbcte1o8uPg/8HrRxe5I5lHvspiryU/kbBFnJ823FxuwOnXinSatn1E7WC3DBHNbxOcfG20Z58ChkLulCAycR9wO33B9Cm+uVgDIBpYbWYqlgrkOhY4GS1FAO9KPMVYphej00txWifsLe254818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802595; c=relaxed/simple;
	bh=dhGtyPrODQDF+J17hmKXLn85PV9V/DUOTK6pnqeCJyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7lkoI6X+/mKUXXAorlRk/IYdb6Z18Tp5xSk22AK4Wgp3PVpX38rzu3WXzyzP6RXc0LmVPEnawCDI+Eyth0C56abjZgfI+oN4LXHGH90zxKC2mBAx8PbE5oB91HdCPGyN8zgyAw+n7s1uumQgbtrSWI3uwW35943YJHz9MkcT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI3balh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI3balh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EC21F00A3A;
	Mon,  7 Sep 2026 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802593;
	bh=dhGtyPrODQDF+J17hmKXLn85PV9V/DUOTK6pnqeCJyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZI3balh/Pl634Zy/G6r9SNxVVnpoNrVLuyudjs6MPSjoly6jJByTaOA1kHHoWkKp/
	 d+08GXrZEsvvGeNmb3EQUwDNUFUqAAEbxVVmIrnimdi5AbwKQ60fYB5U+4UDqYKDzs
	 OWs4NdgcwpHjetEwbOFZVBcsfN/kr6kMmuDZIJs8LCdHDVNo//TCeixkAL76zjw+dG
	 tP5/bs1tAiNNQGl7j70bFfP6OMH9oJ1IdEr1e4cMUK5Skvf6FKYy3OEXIqMHpvXrGP
	 qown51lUM7yNZvBUAdpedWrWm3yswVkEBu/xbPZemPL/UYttqV67fp383a7UQDbsI0
	 cI+8glVlii0mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios
 RS485 direction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Thibert" <nithibert@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907173000.1254045-1-nithibert@gmail.com>
References: <20260907173000.1254045-1-nithibert@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 17:36:32 +0000
Message-Id: <20260907173633.43EC21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> __stop_tx() (8250_port.c) only calls the RS485 rs485_stop_tx() hook
> (which de-asserts the direction GPIO/RTS line) once it has observed
> both UART_LSR_THRE and UART_LSR_TEMT for the last byte. If TEMT is
> never seen and the driver hasn't set UART_CAP_NOTEMT, the function
> returns without scheduling any retry -- the direction line is left
> asserted (driver enabled) forever, with nothing to un-stick it short
> of another kernel-visible LSR event.
>=20
> of_platform_serial_setup()/of_platform_serial_probe() unconditionally
> wire up the generic em485 GPIO-RTS RS485 support
> (rs485_config/rs485_start_tx/rs485_stop_tx) for every port they
> register, but never set UART_CAP_NOTEMT, so any board using this
> driver whose 16550-compatible core doesn't reliably surface TEMT for
> its shift register hits the stuck-direction-GPIO case above.
>=20
> [ ... ]
> regression waiting to happen on any other of_platform_serial user
> that does set "fifo-size" -- which is a common, documented property
> for this binding.
>=20
> Signed-off-by: Nicolas Thibert <nithibert@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907173000.1254=
045-1-nithibert@gmail.com?part=3D1

