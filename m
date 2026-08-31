Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFA47CC9E
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184714; cv=none; b=I9tFACLny8oatrKDQl4DY0eOXcOjOEqFvuEehHCP6KiMLSFcAbmjI91BoR+ugh1JuXOUnGBJ7BZNMpgLqmkZ0KzrTxcRGH7Sm/LzoekBlDj1tynAOjbFPEP0lys5vppzeFpk/GLfF2jkcjOyBN1/rFjqmrr4GEmpHTe/TNObp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184714; c=relaxed/simple;
	bh=LbzKjP6p4Dt6tX5q09LuEpZ1754cxxjuUsD0zMbJ42M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iB8XWCse0HTVUyFo/dkPBO0oLOsXKQcaV+5pI6yNZkMwET95qJkJHUuxpeOqE4lnHncQkKx2PbY60aLV2sGGgopaKB2DK/hk1G/wBVajOcVI/SEP4IvdM/LSo/KK9pkMJIqyYX8ESfdC7qKtkFzOAqdqyCuSB1uaIo1nbZ8Ay40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOBKMVF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOBKMVF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A931F000E9;
	Mon, 31 Aug 2026 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184713;
	bh=cpLzZtlf3htCL7xDBKNxrQbsb1rg2CHPZ7FqpinTFgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AOBKMVF9yxXBsKwcwDriCWCHI1njiU/gBAZFCPTOvwB0Vy3BN43jpbpCYiQP3qxjc
	 WCZoHYRWHp0zF76jXho181tKu45r5ldvsBl/k3ccwF7d83R3tsU8ciMy+jmwJOZefL
	 v2qm/FYIyY1vs1om7dTEfmGBwl8WAtJkdUWOXUoeZX+WW4bnQ6zJbBdr45sUvsjGzV
	 GhwlQ5tlXJ/URuKGa723us49HUpDs0bgYclVWqU5T9+Egc5ZyjIBujnybg97b3FXQf
	 6FVJ5jFHIn4QyVyrxlkPZvTqQCBZvahTwwObKuDR/xcShbyfo8ReK1jl8ME14mzWBr
	 E0HQjXe0Qlzog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] serial: 8250: fix possible ISR soft
 lockup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831133314.4125787-36-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-36-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:58:32 +0000
Message-Id: <20260831135833.13A931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Silent transmission data loss due to unconditionally clearing the =
TX FIFO in the generic ISR path.
- [Medium] Time-of-check to time-of-use (TOCTOU) race condition when cleari=
ng the RX FIFO leads to dropped incoming characters.
--

commit 0cb544a0f6cdcc5a3f0967c34cc3dc4a541bfc13
Author: Marco Felsch <m.felsch@pengutronix.de>

serial: 8250: fix possible ISR soft lockup

This commit addresses an ISR soft lockup on 8250 UARTs during startup
caused by unhandled FIFO error (FIFOE) interrupts. It prevents the
lockup by clearing the FIFO if a FIFO error is latched but no data is
ready (DR) in the generic IRQ handler.

Link: https://patch.msgid.link/20260519-v7-1-topic-serial-8250-v1-1-56b0429=
3a246@pengutronix.de

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 719faf92aa8ae..108f8fdbebac6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1799,6 +1799,13 @@ int serial8250_handle_irq(struct uart_port *port, =
unsigned int iir)
> =20
>  	status =3D serial_lsr_in(up);
> =20
> +	/*
> +	 * Recover from no-data-ready and FIFO error condition to avoid getting
> +	 * stuck in the ISR.
> +	 */
> +	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
> +		serial8250_clear_and_reinit_fifos(up);

[Severity: High]
Does this code inadvertently cause silent data loss for outgoing
transmissions?

When serial8250_handle_irq() calls serial8250_clear_and_reinit_fifos(),
the helper function resets the hardware FIFOs. Looking at the implementation
of serial8250_clear_fifos(), it explicitly clears the TX FIFO alongside
the RX FIFO:

    serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
                   UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);

Any transient line noise or framing error that triggers this recovery path
on a full-duplex connection will indiscriminately wipe the TX FIFO. Because
the kernel has already advanced the transmit ring buffer assuming these byt=
es
were safely queued in hardware, the flushed bytes are permanently dropped
without error propagation to userspace or the TTY layer. Should the fix
isolate the hardware reset strictly to the RX FIFO by only issuing
UART_FCR_CLEAR_RCVR?

[Severity: Medium]
Can the gap between reading the LSR and resetting the hardware FIFOs create=
 a
time-of-check to time-of-use (TOCTOU) race condition?

The ISR takes a software snapshot of the LSR register via serial_lsr_in()
and evaluates the error condition based on this snapshot. Between reading
the LSR and executing the hardware FIFO reset in
serial8250_clear_and_reinit_fifos(), new valid characters can arrive in
the hardware shift register and enter the RX FIFO.

The unconditional RX FIFO reset will silently flush these newly arrived byt=
es
before the driver can read them, leading to dropped incoming characters. Is
there a way to prevent newly received characters from being discarded during
this window?

> +
>  	/*
>  	 * If port is stopped and there are no error conditions in the
>  	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-36-sashal@kernel.org?part=3D1
