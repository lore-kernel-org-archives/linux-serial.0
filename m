Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5538D41A
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940890; cv=none; b=BDAFVJRc4MAlZrlepfM4XbMC6CmZ5oLbn7u5m9MlEXkHgQEt0aXGl4ohnq/uXtc2D6sw941uMTJux8M2SjDZyD87dIgWVqLxFRkwpGM1x6t6B4eY02nFEp1FJ10ON5+w6qPoWC4DtacOQoSFBQM3C+ete8fo74Cyw29r8L68y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940890; c=relaxed/simple;
	bh=HfhMCnYLVOIidY3fDJl9Az1baiDbNUXzOg3/CCRH074=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvRCxxGL/FzbToujTMmjBLgOq7TqiWmraYgY2YwzeyHKbJfssJEPUjR1XRFn8W1CClf3wYkDbffkZyqKCxF6jf0Q6d2Lm9pDhN9EJ3jwLX+1SVt5OFATqf0wWwIQhWDW6/gpXzWEmyoQKitiZw5HiSaxKZd6LuFkx9+MtcRCI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4w6t3j0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4w6t3j0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD4E1F000E9;
	Fri, 28 Aug 2026 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787940888;
	bh=xTftT9cRGHpooQEBHs05t+4G3pWOqlFje2o4kHF2984=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4w6t3j0DoPM8MA8SN1pufiumP5mye1B6evsb81WES5wopt2z4PTRlwSaN/+rU9q3
	 GN9FsOv8iYKkcf1Z6LtAuF/thG3PsvSXUs5cWFyrWsueFXFkd3WFMWw3VwKPTauMJc
	 oSIjqO95HqrAR1a/Id7QIjw9gzVajY6im9KG1w+Iq4CZ0SONKNyddhSAoKse5/9VOM
	 O+glZh9k4Sl/JFSUShwWMqaqUWDTVkhCCwsQqDZmIEcfw348fy0FQNdiMuwfAOSGv2
	 E3yK1ExRQkFdmpuURAHVtRrk98dGN212fdD1dqBW1NEy9N+3KnLuhyPfZDrT+WAaJm
	 gNLJAUa4pG6FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_mid: wait for LSR tx empty before
 setting termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tate Whiteberg" <whiteberg@arista.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828175733.1650267-3-whiteberg@arista.com>
References: <20260828175733.1650267-1-whiteberg@arista.com>
 <20260828175733.1650267-3-whiteberg@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:14:47 +0000
Message-Id: <20260828181448.3AD4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `serial8250_wait_for_xmitr()` timeout is too short to drain the FI=
FO, failing to prevent data corruption.
- [High] `uart_port_unlock_irq()` unconditionally enables local interrupts,=
 violating caller context expectations.
- [High] Releasing the port lock between Intel-specific register updates an=
d core 8250 register updates introduces a TOCTOU race condition that corrup=
ts transmission.
- [Low] Missing MODULE_IMPORT_NS("SERIAL_8250") causes a modpost namespace =
warning/error.
--

commit f345869677f080c82ebb31b7ea7f98c00bfefd55
Author: Tate Whiteberg <whiteberg@arista.com>

serial: 8250_mid: wait for LSR tx empty before setting termios

If mid8250_set_termios() is called while data is still in transmission,
the corresponding register updates will corrupt the transmission. This patch
locks the port and waits for the transmitter to empty before performing
the register updates.

> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250=
/8250_mid.c
> index 82656645b8a64..ce792888acfee 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c

[ ... ]

> @@ -231,12 +232,18 @@ static void mid8250_set_termios(struct uart_port *p=
, struct ktermios *termios,
>  	}
> =20
>  	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
> +
> +	uart_port_lock_irq(p);

[Severity: High]
Does acquiring the port lock here using uart_port_lock_irq() break caller
context expectations?

Since mid8250_set_termios() serves as the set_termios callback, it is
frequently called from contexts where local interrupts are already disabled
(such as early boot console setup).=20

This will eventually pair with uart_port_unlock_irq() below, which
unconditionally re-enables hardware interrupts via local_irq_enable(),
rather than restoring the previous interrupt state.

Should this use uart_port_lock_irqsave(p, &flags) instead?

> +
>  	p->uartclk =3D fuart * 16 / ps;		/* core uses ps =3D 16 always */
> +	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);

[Severity: High]
Can this wait silently time out and fail to prevent data corruption?

The 8250_mid UART (PORT_16750) has a 64-byte FIFO. However,=20
serial8250_wait_for_xmitr() internally calls wait_for_lsr(), which uses a
timeout of up->port.frame_time * 2 (approximately 2 characters).

If there is a large burst in the FIFO at a low baud rate, won't this wait
time out long before the 64-byte FIFO drains, proceeding to modify the
PS/MUL/DIV registers while data is still actively shifting out?


[Severity: Low]
Does this module need to import the SERIAL_8250 namespace?

The function serial8250_wait_for_xmitr() is exported to the "SERIAL_8250"
namespace in drivers/tty/serial/8250/8250_port.c. Since 8250_mid.c is
compiled as a separate module (8250_mid.ko), failing to include
MODULE_IMPORT_NS("SERIAL_8250") at the module definition level will trigger
a modpost namespace warning or error when building the driver as a module.

> =20
>  	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
>  	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
>  	writel(div, p->membase + INTEL_MID_UART_DIV);
> =20
> +	uart_port_unlock_irq(p);
> +
>  	serial8250_do_set_termios(p, termios, old);

[Severity: High]
Does releasing the port lock here introduce a race condition?

The lock is dropped before calling serial8250_do_set_termios(), which then
re-acquires the lock to update DLL/DLM and LCR.

During this unlocked window, the port is left in an inconsistent hardware
state with new clock multipliers but the old divisor.=20

Because interrupts are enabled, could a TX interrupt or concurrent console
write acquire the lock, fill the hardware FIFO with new data, and transmit
it at a garbled frequency before the core 8250 function completes the updat=
e?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828175733.1650=
267-1-whiteberg@arista.com?part=3D2
