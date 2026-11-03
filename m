Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722046;
	b=ze7GShOuooMzy30j9ZBcElHeTcG84ruCG/zTRmBk9aI5vHqL2xnpxaf6MC1basv/hgyJ
	 4sk+DrKsFMEm/EaBOYl9oI7MEjAVHMJsXomyIs1kHwg04ESNzgnTU/Gx/NWgerj7QwSlS
	 OTMtflYmNeXTNwzI81Duit/y8+acJc0eKtRg9kTltzFsAbhpPd6+9x/QwT1q+XeEOjP5y
	 aykvl9RxFIInadkeoCUunWV8NxiOcJouETKpc8EMSViVqKtaLG5DuUbG76X5nKiryBngh
	 Hvx3eKw8is+1tNDdodCwxJxBF3kddWg3dOFgCDU/YZliTL4jhWC54vDxjDarKI8NxkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V6gL72yOF/PFakknFjYD7NM7BNGsE1QwRUGWLZHDTEA=;
	b=tub8INHf29Hou5j0yv2bNBvmI5AVAOWVJjJkjOIOJEt1XffW8wUn2Iv2Rb1A5Sla5irG
	 jPNSrTOLb+MmlNCpzhacyWLZaBKxwfF3UYVmlED0MqKxkTVfgtRNDWNUNQKdkJ0SzOZTg
	 oh5aOjhbmvxLRI05VPlXEsE1+yxCIkmPm0I/NtX0bZnATeMWy7U6whkds9DQfcJuSZ8JQ
	 idUreTsxPN4ooRjrpqw8Tq4OpHee/dGmcU6XZMLMmEW4cONUxb7M5vophphMmmN0vXbNe
	 7fOQ7GymNF2c7PENuxRlGgi6/E0FC8e1ijRHXVO2rAC0BmejLfcrAQ6EOjKAY+T0+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V87Y3FHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A9606A324;
	Tue,  3 Nov 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V87Y3FHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BCB1F000C1;
	Tue,  3 Nov 2026 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722046;
	bh=V6gL72yOF/PFakknFjYD7NM7BNGsE1QwRUGWLZHDTEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V87Y3FHwvKytw/G9+DczOI9dJrAZjNURtrUgkgvswFAj6o7Q7YpEMGT9qikEI3VWd
	 1r+lswXC+BscikAwlpasQO+pXDqwRx8FRN1uc0gxpKTG1khkqm/3WI84rquSJ/o54R
	 kM6VY2S4Ym0LtZD2ib5U9U7a62pyXLTct3Alq2CMsWAnhae4pPvsSppUKMwpmXuqpv
	 7R+X8EJLhvgcrIei0NQUT41Yc0itfSeGVQeb9+U5B9/1ooYWeP3eQhxmgrE59a6lhk
	 5/euBZYIJxboXVEd5jQl9S5rbb1w5yIuf2Bpu8Io0axJBsysb8o33/u+uNPqy9C4mi
	 +CvifmUXiIpfw==
Message-ID: <sashiko-outbox-195698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] serial: fsl_lpuart: Enable TTY wakeup for
 wakeup-source ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefano Radaelli" <stefano.radaelli21@gmail.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <58d65b44ca054ea83eb835bf5decebd688cad04d.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <58d65b44ca054ea83eb835bf5decebd688cad04d.1793719239.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:07:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: fsl_lpuart: suspend state mismatch in lpuart_uport_is_acti=
ve()
--

commit 5f417acc28861452465313313b5ef22d373f3ae3
Author: Stefano Radaelli <stefano.r@variscite.com>

serial: fsl_lpuart: Enable TTY wakeup for wakeup-source ports

This commit sets tty_wakeup_default in lpuart_probe() from the wakeup-source
device tree property so the serial core enables TTY wakeup at registration
time.

> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index c8575c9652035..35397152a39b3 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2905,6 +2905,7 @@ static int lpuart_probe(struct platform_device *pde=
v)
>  		sport->port.ops =3D &lpuart_pops;
>  	sport->port.has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_FSL_LPUART_CONSOLE);
>  	sport->port.flags =3D UPF_BOOT_AUTOCONF;
> +	sport->port.tty_wakeup_default =3D of_property_read_bool(np, "wakeup-so=
urce");

[Severity: High]
Does enabling tty_wakeup_default at registration time cause a suspend and
resume state mismatch between the serial core and lpuart_uport_is_active()
when the TTY device is not open in userspace?

With tty_wakeup_default set, serial_core_add_one_port() enables wakeup on
tty_dev during probe before any process opens the port (when port->tty is
NULL and tty_port_initialized(port) is false).

If the system suspends while the port is closed, lpuart_suspend() calls
uart_suspend_port(), which checks device_may_wakeup(tty_dev) without checki=
ng
tty_port_initialized(port):

drivers/tty/serial/serial_core.c:uart_suspend_port() {
	...
	tty_dev =3D tty_port_find_device(port);
	if (tty_dev && device_may_wakeup(tty_dev)) {
		enable_irq_wake(uport->irq);
		put_device(tty_dev);
		return 0;
	}
	put_device(tty_dev);
	...
}

Because uart_suspend_port() returns early here, it leaves uport->suspended =
as
0 and skips console_suspend(uport->cons) as well as uart_change_pm(state,
UART_PM_STATE_OFF).

However, lpuart_suspend() then checks lpuart_uport_is_active(sport), which
requires both a non-NULL port->tty and tty_port_initialized(port):

drivers/tty/serial/fsl_lpuart.c:lpuart_uport_is_active() {
	...
	tty =3D tty_port_tty_get(port);
	if (tty) {
		tty_dev =3D tty->dev;
		may_wake =3D tty_dev && device_may_wakeup(tty_dev);
		tty_kref_put(tty);
	}

	if ((tty_port_initialized(port) && may_wake) ||
	    (!console_suspend_enabled && uart_console(&sport->port)))
		return true;

	return false;
}

When the port is not open in userspace and console_suspend_enabled is true,
lpuart_uport_is_active(sport) returns false, causing lpuart_suspend() to ta=
ke
the else-if branch and disable ipg_clk and baud_clk while the console is
still active and unsuspended:

drivers/tty/serial/fsl_lpuart.c:lpuart_suspend() {
	...
	} else if (pm_runtime_active(sport->port.dev)) {
		lpuart_disable_clks(sport);
		pm_runtime_disable(sport->port.dev);
		pm_runtime_set_suspended(sport->port.dev);
	}
}

Wouldn't any printk() during suspend or early resume then call
lpuart32_console_write() or lpuart_console_write() while the LPUART clocks
are disabled, triggering an unclocked MMIO access (bus hang or synchronous
external abort)?

Similarly, on resume, lpuart_resume() skips lpuart32_hw_setup(),
lpuart_hw_setup(), and lpuart_console_fixup() because
lpuart_uport_is_active(sport) is false, while uart_resume_port() also retur=
ns
early without restoring console termios or calling console_resume() because
!uport->suspended && device_may_wakeup(tty_dev) is true:

drivers/tty/serial/serial_core.c:uart_resume_port() {
	...
	if (!uport->suspended && device_may_wakeup(tty_dev)) {
		if (irqd_is_wakeup_set(irq_get_irq_data((uport->irq))))
			disable_irq_wake(uport->irq);
		put_device(tty_dev);
		return 0;
	}
	...
}

If the LPUART loses power during deep sleep while the console TTY is closed,
doesn't this leave the console hardware uninitialized after resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793719239.gi=
t.stefano.r@variscite.com?part=3D3
