Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314143B5E08
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618294; cv=none; b=kpu+E5FF9r0F9UP7+rdTW/E8md+RA3/9BfWuTyCuwTdMuUQ9DyI7Audm6O2Yy4qUwLaF5ABx3Zg8MN/zwgfHRZlSZwlumWLBDCZPGAti4m3WYfeXr7vPcKBPzmOSLe8l0NtumBlwO0ZH+sOeQ8GQOncG/4dsWe5M2X2OB0m1JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618294; c=relaxed/simple;
	bh=5iRWlB/Doj6TSlhwTllpfNcdxmLp2vhfJ5bIqZYM6lY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uG4QFNJ5bajrJ+eVNrhlm0WFnOV59E6J4rt6vk5SRJ5CJz5Nkdu3Du20brf/EbjigGvvAwl3wTHSs2RhlBBq7wWqtRRwzY266SpgPw14+ftZCZR/woS3MxumN1/2jmGQmjio/yT0aP++/HsUK6MBCxsoMoTxOtYWY47cfLT6kQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vboweo3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vboweo3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF86F1F00893;
	Thu, 17 Sep 2026 04:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618291;
	bh=xSKQIWAXdDqj+DNxN94mQC21wk+yJ2tqhiJpEXhBFsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vboweo3oU9rOLLPTJwjYMlo0CICNAhfLcxnNU0MzrggWNHM9WmToBA+Z+9h2EceSR
	 eEh35Hqb3PeeOq+lNdnP8JlLTEdUI516T0fH6EtdBX0er73Y1BId6VzJ/QkG4vYJEY
	 kapxMjEvaqCpp+pPOUvI4EaTsoiV7ArzY9kmwGp9TeWMwx+8xteTLp+Al6C+JexpmJ
	 sp2B6jNizI0V3EWheglAJvs8tzi0vlbc5wtIszdEj/bpY6ycNhM5znsrCB7g9fHLYo
	 iFs/J7YFDRFd1ouPJ4B/P4GB4gcDKCMYDxd+Zi48d8SdJvisO0mrCmeZucWjqojA8q
	 ZEhiGvV0SswaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Malathi A" <malathi.a2000@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260917040511.103232-1-malathi.a2000@gmail.com>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:11:31 +0000
Message-Id: <20260917041131.BF86F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> uniphier_uart_probe() enables priv->clk by hand and is then responsible
> for disabling it again on every error path. It misses one: when
> uart_read_port_properties() fails the function returns directly, leaving
> the clock prepared and enabled. The neighbouring path, taken when
> serial8250_register_8250_port() fails, does call clk_disable_unprepare(),
> which shows the leak is an oversight rather than intent.
>=20
> Rather than adding another manual unwind, switch to
> devm_clk_get_enabled() so the clock is released by devres. That removes
> the error path entirely, along with the explicit disables in the
> register failure path and in uniphier_uart_remove().
>=20
> The clock is still disabled and re-enabled by hand across system sleep,
> which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
> device cannot be unbound while suspended and devres always sees an
> enabled clock at detach.
>=20
> Found by smatch:
>=20
>   drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn:=
 'priv->clk' from clk_prepare_enable() not released on lines: 205.
>=20
> Fixes: 26e8349c0d76 ("serial: 8250_uniphier: Switch to use uart_read_port=
_properties()")
> Signed-off-by: Malathi A <malathi.a2000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040511.1032=
32-1-malathi.a2000@gmail.com?part=3D1

