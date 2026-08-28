Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78145A2AD
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929355; cv=none; b=i6rdeToPsKiMf7bqqqkBE2BOB4PpnPuqtcpOEp5SQkTJUUelJ0RLLDf+KZMNB9/dNEprXOnUW3CiWJLXQH6/eM1C5QfC/xwUxiw+LM+xm6GPhcS5qBpYzRS2zzjXU3ynWZSeTvmCf9sXlDOKkKOwnCHMPQOJ8amImalXs2Kevcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929355; c=relaxed/simple;
	bh=8MYulxpkoiArYTqfaKS+4oVTjx5q8eiyuVtTXqxltos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jn7iEFyikqrtvKaeehBDPfl71iZ0ab6BT0y7ij2BsN8TkxN+moi1nFUJ9vS5BJvjtKBAbbEcjK/ToCUCO0bliU3ZrDsNLc2wNA4t+DeJeiXC5rmk3p30KTffIe5xViCmEVmKyYw0ZhNcEct+YQ2QRxUCKQ11GnykMLeRV+wCR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZiRceux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZiRceux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1A1F00A3D;
	Fri, 28 Aug 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787929354;
	bh=bzR78IQBZVckVQ5pfROX4UdsSyZ3bcjz+k5IG6PqztA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZiRceux32rwWv7sCw3Tvckl3MJHWVzd8lTRO2vxRx4n4E0nR4YEBmqiDEHehb96D
	 NAbCy3A1hx5qC0f2XH/aJN3rKNhV/+op49PWIp5ao0xByvM/MhyiSen9i5dTbUoPU2
	 bkQ7JThLUCl28YmpXRo7kRaIjn2gnkFeubkQenkOcBCJrJkyvtpEZwg9YHW+PSBnij
	 bbYpE8LfqvttrD1iFZQUiA45MOfFQhzZhr5jXeHbaG2S7dg5g4QZMHkaHEQM6e/9PI
	 MY61UitxevNrc2cKwq/O7P/KCH3SMVX34ve0UFBguwgf+CSz0/FVzP0hg1Jp1BJ0cp
	 uF9H/3nMmlI0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting
 termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tate Whiteberg" <whiteberg@arista.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828144617.1210599-2-whiteberg@arista.com>
References: <20260828144617.1210599-2-whiteberg@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 15:02:33 +0000
Message-Id: <20260828150234.10D1A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] `serial8250_wait_for_xmitr` will timeout prematurely if the TX FIF=
O contains more than two characters, defeating the patch's attempt to preve=
nt data corruption.
- [High] Locking gap between updating MID registers and 8250 core registers=
 creates a deterministic race condition that corrupts transmission.
- [High] `uart_port_unlock_irq` unconditionally enables local interrupts, v=
iolating locking constraints for contexts that require interrupts to be dis=
abled.
- [High] Busy-waiting with interrupts disabled for the UART transmitter to =
drain causes severe latency spikes and potential soft lockups.
- [Medium] Missing MODULE_IMPORT_NS("SERIAL_8250") in 8250_mid.c breaks mod=
ule namespace dependencies and causes modpost failures.
--

commit 77c9d48edc835f42331c18bc6abbd15412b526d2
Author: Tate Whiteberg <whiteberg@arista.com>

    serial: 8250_mid: wait for LSR tx empty before setting termios
   =20
    If mid8250_set_termios is called while data is still in transmission,
    the corresponding register updates will corrupt the transmission.
   =20
    Fix this by locking the port and and waiting for the transmitter to
    empty before performing updates. It is necessary to wait for both
    UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250=
/8250_mid.c
> index 82656645b8a64..c77e117b7822c 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c
[ ... ]
> @@ -218,6 +219,7 @@ static void mid8250_set_termios(struct uart_port *p, =
struct ktermios *termios,
>  	/* Gracefully handle the B0 case: fall back to B9600 */
>  	fuart =3D fuart ? fuart : 9600 * 16;
> =20
> +	uart_port_lock_irq(p);
>  	if (mid->board->freq < fuart) {
>  		/* Find prescaler value that satisfies Fuart < Fref */
>  		if (mid->board->freq > baud)
> @@ -231,11 +233,14 @@ static void mid8250_set_termios(struct uart_port *p=
, struct ktermios *termios,
>  	}
> =20
>  	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
> +
> +	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);

[Severity: High]
Will this wait function timeout prematurely?

Because wait_for_lsr() caps its internal timeout at 2 frame times, it seems
it will inevitably time out before a full FIFO (up to 64 bytes) can drain.

If serial8250_wait_for_xmitr() returns silently on timeout when hardware fl=
ow
control is inactive, won't mid8250_set_termios() proceed to update the clock
registers while the FIFO is still actively transmitting data?

[Severity: High]
Is it safe to invoke this wait function while interrupts are disabled?

Since uart_port_lock_irq() was just called, local interrupts are disabled. =
If
hardware flow control is active and CTS is deasserted, the innermost loop in
serial8250_wait_for_xmitr() can spin in a udelay(1) loop up to 1,000,000
times:

drivers/tty/serial/8250/8250_port.c:serial8250_wait_for_xmitr() {
    ...
    for (tmout =3D 1000000; tmout; tmout--) {
        ...
        udelay(1);
        touch_nmi_watchdog();
    }
}

Could spinning for 1 second with local CPU interrupts disabled cause severe
latency spikes or soft lockups?

>  	p->uartclk =3D fuart * 16 / ps;		/* core uses ps =3D 16 always */
> =20
>  	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
>  	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
>  	writel(div, p->membase + INTEL_MID_UART_DIV);
> +	uart_port_unlock_irq(p);

[Severity: High]
Since set_termios() callbacks can be executed from contexts where interrupts
are strictly disabled (such as early console initialization), is it safe to
use uart_port_unlock_irq() here?

uart_port_unlock_irq() expands to spin_unlock_irq(), which unconditionally
enables local CPU interrupts. Shouldn't this save and restore the IRQ state
using uart_port_lock_irqsave() and uart_port_unlock_irqrestore() instead?

> =20
>  	serial8250_do_set_termios(p, termios, old);

[Severity: High]
Does releasing the lock before calling serial8250_do_set_termios() create a
race condition?

If the hardware FIFO was just explicitly emptied, could the UART_IIR_THRI
(TX empty) interrupt fire the exact moment local interrupts are re-enabled =
by
uart_port_unlock_irq()?

If the interrupt handler executes and pushes new characters into the FIFO
before serial8250_do_set_termios() updates the 8250 divisors, might those
characters be transmitted with a mismatched clock configuration?

>  }
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 38fa45e74a37a..4eaf417f1fd79 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
[ ... ]
> @@ -2052,6 +2052,7 @@ static void wait_for_xmitr(struct uart_8250_port *u=
p, int bits)
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(serial8250_wait_for_xmitr, "SERIAL_8250");

[Severity: Medium]
Will this cause a module load failure under strict namespace policies?

Because this exports the symbol into the "SERIAL_8250" namespace, but
8250_mid.c (compiled into the separate 8250_mid.ko module) consumes it with=
out
a corresponding MODULE_IMPORT_NS("SERIAL_8250") statement, won't this trigg=
er
modpost warnings and break module dependencies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828144617.1210=
599-2-whiteberg@arista.com?part=3D1
