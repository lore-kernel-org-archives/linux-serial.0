Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB234AE8C8
	for <linux-serial@vger.kernel.org>; Wed,  2 Sep 2026 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387959; cv=none; b=P+/Ntxz5E8bq6MsjXpcC47vjNOilzVoZwX45uKdwVrgkKlgVIsmFIX9b9vxCpTaO1yZcaExH5Doee/0G1BY7EMbGYlpVDnrwijKiQE7QxBuPG2NgitYvYr2EjXtrHEuYmg2eR8/Ul60K5r0nRfgzvedd7iSZ/zApNAwROUg1fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387959; c=relaxed/simple;
	bh=Syr8WHtRJBjzLbYmzsmkhEvoHT0q+6/tcIzT7U8h5+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uSMz6sghhGYTz0TtJiH4jIBcA7+aWIVPHT3fxh82vRiJvVOMET2HR1LPGJLejKPnMZzEN/ZtF4DcxHcKSilKnCWFxPFVOllV7xgH/pMXEBy5wDlkeTwOQaRYfUcNQyqUyItJHYNTiKVo5oltEp4NM9ZousKb1hpnepcRhS9OpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NErvb9ED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NErvb9ED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C151F000E9;
	Wed,  2 Sep 2026 22:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387955;
	bh=Z3KxHAG9CUv1Cm+n5S1tUZacHEqwB1TBoITfJ+tcZgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NErvb9EDthAAUS6q2I30bleBmL3YpUwQm2gCksUTNPE4cx4gs5C/9LzXcD1LpEHTj
	 zRX2tlqXST0f5fO5iE4v3yfDGRrZi6xkCF/oEXmz/4WI9j6kIXHEYIIUC1Mds9SUi4
	 zw3vifUVCQXy7K+odLlYKHBL/tIJXGycg5ZQuAdp3B7WA7gWDzlFOvXOFctyduSS1g
	 2zLOZF8nLigpRoX14WjalgNu2xc60rYGWsOnH7E2I+ntj7SCnBN9MIEBwBR+vnaq7Q
	 WygBsn8hKhqkigpg4M8gKDJ119yjcDAn+Bu8GjR1CoZjVqDcV67hnr9zZn+T9McHni
	 tX9DC1EInysDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: Add Armada 38x earlycon support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260902221709.340393-1-rosenp@gmail.com>
References: <20260902221709.340393-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:25:54 +0000
Message-Id: <20260902222555.30C151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Runtime PM circular dependency during port registration in `dw8250=
_probe()`.
--

commit b5bac3793a0a37f84d80f37cd62c9577811449ef
Author: Rosen Penev <rosenp@gmail.com>

serial: 8250: Add Armada 38x earlycon support

This commit registers the Armada 38x UART compatible with the built-in 8250
earlycon implementation. This allows stdout-path to enable an early console
while preserving the vendor-specific compatible to retain DesignWare driver
runtime handling.

> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/82=
50/8250_early.c
> index 44ec209f37c47..265d49850e150 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -175,6 +175,7 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
>  EARLYCON_DECLARE(uart, early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> +OF_EARLYCON_DECLARE(uart, "marvell,armada-38x-uart", early_serial8250_se=
tup);

[Severity: High]
This is a pre-existing issue, but since this patch relies on preserving the
DesignWare driver's runtime handling, could the current runtime PM logic
cause a circular dependency during port registration?

Looking at dw8250_probe() in drivers/tty/serial/8250/8250_dw.c, port
registration happens before runtime PM is enabled:

drivers/tty/serial/8250/8250_dw.c:dw8250_probe() {
	...
	data->data.line =3D serial8250_register_8250_port(up);
	if (data->data.line < 0)
		return data->data.line;

	platform_set_drvdata(pdev, data);

	pm_runtime_enable(dev);
	...
}

The registration call eventually reaches uart_add_one_port(), which
synchronously invokes the pm callback dw8250_do_pm(). This callback
attempts to use runtime PM APIs:

drivers/tty/serial/8250/8250_dw.c:dw8250_do_pm() {
	if (!state)
		pm_runtime_get_sync(port->dev);

	serial8250_do_pm(port, state, old);

	if (state)
		pm_runtime_put_sync_suspend(port->dev);
}

Since pm_runtime_enable() hasn't been called yet when the callback runs,
would pm_runtime_get_sync() operate on an uninitialized device? Does this
sequence risk blocking tasks and hanging worker threads during device probe?

>  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902221709.3403=
93-1-rosenp@gmail.com?part=3D1
