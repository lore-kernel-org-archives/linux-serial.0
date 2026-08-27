Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4713369208
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795829; cv=none; b=mOveK61M0Cd2ts+Kolht6aBMRdaJ7SvSJ3cgK2D+NmEqQPO0rDQ6QezhQ9GdPsunwDPbXLkyVoyrefy+D222BNxQ405oNue2v/3l/SNWKF95gV7KTiqMCvCe5nTrgWTkK2xnzGDVGS+FD2fBqFlAhSElx06uBXf611YUNN+rB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795829; c=relaxed/simple;
	bh=+roZj3ANpDhcYmbHkVQe9WJaaYQCoZE4EZkYJyowiUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R1hXnUDHqVuUgd4MxKe99TrxNA+ynHkaM29JDfMgiAwft2BKdwMgdI2GKSDPXGnVYKZA2iCkcSlZY7MTEmpdTMvdAYXv5Sg9bo8dXre0fMJizrs4J4uKAs8zUPFqN37UKSDvausQGXxSZa9kY2OSECxIe6c3Pg85bbuV3WxXKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idUzU3aP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idUzU3aP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C471F000E9;
	Thu, 27 Aug 2026 01:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787795827;
	bh=Wx3rpXwgG5uy3IfB8Go++LMgDh7fKVmPT6IFfuas3yI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idUzU3aP5eVHLlDC0nQyKFiDQJ5wEYT2s963WlBHGgHWCOTSu4iFMAdwodi8kEW/x
	 gMigymlU/bE6wkZ+D0l/J7H9x5ZoMG+RF4rNyFYxiUrvBkuQmRmPRjDyyZ4LRBobG/
	 JuDDZcICuezrrkOzxjLaw8jdNwoItUfT/ERwXZxA8bHYEGulOAdQXelZTLWjr02ZXC
	 MeTn3zLhLVPNZOCJeQQ3ESsZBUKg086mk0rKTuRZyxL5L0xMWDT1YQY4WIdzExn2nz
	 DUIKIR+Ht9iKiEyWU+SQkNndc3jCJWEUaa4H4DVvvR6QFN8tcy5PWYCYfGRWr+WzRu
	 a4SHOVCAhMv+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sifive: fix off-by-one in console port bounds
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zongmin Zhou" <min_halo@163.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827014524.19375-1-min_halo@163.com>
References: <20260827014524.19375-1-min_halo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 01:57:06 +0000
Message-Id: <20260827015707.48C471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Initialization Order / Uninitialized Lock and NULL Pointer Derefer=
ence
- [High] Divide by Zero / Race Condition
--

commit 1fa22c29aea26698105dc98632798b018a6fe1cf
Author: Zongmin Zhou <zhouzongmin@kylinos.cn>

serial: sifive: fix off-by-one in console port bounds check

sifive_serial_console_ports[] is sized SIFIVE_SERIAL_MAX_PORTS (8), so
valid indices are 0..7. The bounds check in sifive_serial_probe() uses
"id > SIFIVE_SERIAL_MAX_PORTS", which lets id =3D=3D 8 pass and causes an
out-of-bounds write in __ssp_add_console_port() through
sifive_serial_console_ports[ssp->port.line].

Fix the check to use >=3D instead, matching the check already used in
sifive_serial_console_setup().

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 110d676131922..5d76f04736260 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -999,7 +999,7 @@ static int sifive_serial_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  #ifdef CONFIG_SERIAL_SIFIVE_CONSOLE
> -	if (id > SIFIVE_SERIAL_MAX_PORTS) {
> +	if (id >=3D SIFIVE_SERIAL_MAX_PORTS) {
>  		dev_err(&pdev->dev, "too many UARTs (%d)\n", id);
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but further down in sifive_serial_probe(),
clk_notifier_register() is called before ssp->baud_rate is initialized:

drivers/tty/serial/sifive.c:sifive_serial_probe() {
    ...
	r =3D clk_notifier_register(ssp->clk, &ssp->clk_notifier);
    ...
	ssp->baud_rate =3D SIFIVE_DEFAULT_BAUD_RATE;
    ...
}

If a clock rate change is concurrently triggered right after registration b=
ut
before ssp->baud_rate is initialized, sifive_serial_clk_notifier() executes
and divides by zero:

drivers/tty/serial/sifive.c:sifive_serial_clk_notifier() {
    ...
		udelay(DIV_ROUND_UP(12 * 1000 * 1000, ssp->baud_rate));
    ...
}

Can this lead to a divide-by-zero panic during driver load?


[Severity: High]
This isn't a bug introduced by this patch, but towards the end of
sifive_serial_probe(), request_irq() is called before uart_add_one_port():

drivers/tty/serial/sifive.c:sifive_serial_probe() {
    ...
	r =3D request_irq(ssp->port.irq, sifive_serial_irq, ssp->port.irqflags,
			dev_name(&pdev->dev), ssp);
    ...
	r =3D uart_add_one_port(&sifive_serial_uart_driver, &ssp->port);
    ...
}

If the hardware has a pending interrupt (e.g., left active by the bootloade=
r)
and interrupts are enabled, request_irq() allows sifive_serial_irq() to fire
immediately before the serial core has initialized the port state.

The interrupt handler would try to acquire the uninitialized port spinlock:

drivers/tty/serial/sifive.c:sifive_serial_irq() {
    ...
	uart_port_lock(&ssp->port);
    ...
}

And subsequently call __ssp_receive_chars(), which dereferences the
uninitialized ssp->port.state:

drivers/tty/serial/sifive.c:__ssp_receive_chars() {
    ...
	tty_flip_buffer_push(&ssp->port.state->port);
    ...
}

Since ssp->port.state is allocated later by uart_add_one_port(), it will be
NULL. Could this result in a lockdep warning and a NULL pointer dereference
kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827014524.1937=
5-1-min_halo@163.com?part=3D1
