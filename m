Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744566;
	b=o3nUuJ3D8MRCi94nLgWoHK7A64FMadTCEjccY19+DRu66Fqy3wGHNKi8XH/26RCcbzBL
	 ry1qD6NKr4MK9QgG23bsV94d3MwkPf3sGyiGUbvy5l2LMd+q048ZiGTnCm3eZc9UKDirX
	 ptpkteU8wO+cOg49Wo75/oz2voXnUSDHVWNFANoK1QefKQTxGs9RUsRxYCcjtcPiZgOKB
	 9IHKbpz+FwOdzzpx/uVnn3mMuu721etFqNDKWo/vjvpWlKxS/V5hTP40P2edibhkEe8tO
	 wEInJuQjGxF5anWgZCffts3yBjCcEQqFQkC0fNrYjkcZ1/pbglHGcSZ6dINh9TtNwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WLbtZqIB8ghximvC9Aa0kqq6J8gIe5bRxNbyMhmtFlg=;
	b=uyai1LODFU+VCS117fk2ORi8gxXmvruTdmo7WrTGKBJwJzxv7WfmlALxFongBIgZDp7+
	 BwtXta9msEfcTYVu3yigUT2t1vTW95n8EQETeut23V6wb+bF3VABLsALOwqGMOkawfxiN
	 0JVK1SswiLe6sTZdUP2U+hNPdy872B7ujgl0pf7jg+ClJcfFedqapy7OOau00uGWcJshD
	 JVGvRhATSKxOVoQlouYp3rvzIjxmB6S3075+Jj4IGQtW2f7KijhMOtWdMxnPZZSPokhmz
	 nYP38BZkUDWy7c+yygfRpCBAE1iMM8I4o4IWiwklRuBi0gt7y7H9VBv9eMrgNdEvtug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j35CQ0RQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF07606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j35CQ0RQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB091F000C1;
	Tue,  3 Nov 2026 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744565;
	bh=WLbtZqIB8ghximvC9Aa0kqq6J8gIe5bRxNbyMhmtFlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j35CQ0RQ7OYXCSPsVY+6lZRPMrsv3LogwHs90hM4FwaGJvaMkCnG0nLltFVIgGM8B
	 b6EBrfPz0lsrac2Wd+/dUbxPMJN0siLG4a7obGYS+Fl8u0W/ELYrzP+L0dq+2SKE0e
	 KJJeqMlEsGbdJT5jra9jSB+jBH69iJ/26cc9lcn+CBBq5cOZ4AEjT56weRbxcGW1Sp
	 VxPOFjB5uT6PYT8miadclEX9pmV3EFljxHviwXWDGKRRi5IT0ZIXVxkCfz9p50NiSp
	 5HntiUJxLg2+z0vEIKBqyHkZHOoVG8vRxbJadILmR2DyaUXrDBvo3rza4sT9PNVSj9
	 727c0Q/cCw+1g==
Message-ID: <sashiko-outbox-196102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:22:44 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: core: out-of-range hup_speed on B0 in uart_get_baud_rate_s=
ave() returns 0
- [Medium] serial: dz: dz_set_termios() saves unvalidated baud in hup_speed=
 breaking B0
- [Low] serial: docs: stale uart_get_baud_rate kernel-doc identifier in dri=
ver.rst
--

commit 73f85543b84c52391e1ff13d5519c702bc72e894
Author: Maciej W. Rozycki <macro@orcam.me.uk>

serial: core: Don't clobber the baud rate on hangup via B0

This commit saves the most recently selected baud rate in port->hup_speed
and uses it instead of max(min, 9600) when hangup is requested via B0. It
also renames uart_get_baud_rate() to uart_get_baud_rate_save() with a save
parameter so serial8250_console_restore() can avoid modifying
port->hup_speed without holding port->mutex.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 012f22cf3a60e..18d42491e86d2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -458,29 +458,32 @@ uart_update_timeout(struct uart_port *port, unsigne=
d int cflag,
>  EXPORT_SYMBOL(uart_update_timeout);
> =20
>  /**
> - * uart_get_baud_rate - return baud rate for a particular port
> + * uart_get_baud_rate_save - return baud rate for a particular port

[Severity: Low]
Does Documentation/driver-api/serial/driver.rst also need to be updated for
this rename? It still lists uart_get_baud_rate under the kernel-doc
identifiers for drivers/tty/serial/serial_core.c:

Documentation/driver-api/serial/driver.rst:
.. kernel-doc:: drivers/tty/serial/serial_core.c
   :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor

which causes a kernel-doc warning when building the documentation and omits
both uart_get_baud_rate_save() and the new static inline
uart_get_baud_rate() in include/linux/serial_core.h.

[ ... ]

> @@ -519,10 +522,14 @@ uart_get_baud_rate(struct uart_port *port, struct k=
termios *termios,
>  		 * Special case: B0 rate.
>  		 */
>  		if (baud =3D=3D 0)
> -			baud =3D max(min, 9600);
> +			baud =3D (port->hup_speed ?
> +				port->hup_speed : max(min, 9600));
> =20
> -		if (baud >=3D min && baud <=3D max)
> +		if (baud >=3D min && baud <=3D max) {
> +			if (save)
> +				port->hup_speed =3D baud;
>  			return baud;
> +		}

[Severity: High]
What happens in uart_get_baud_rate_save() when B0 is requested and
port->hup_speed is outside the [min, max] range passed by the caller?

Several 8250 drivers dynamically adjust port->uartclk from
tty_termios_baud_rate(termios) before calling serial8250_do_set_termios() or
dw8250_do_set_termios(). For example, in drivers/tty/serial/8250/8250_mid.c:

mid8250_set_termios()
    unsigned int baud =3D tty_termios_baud_rate(termios);
    ...
    fuart =3D baud * 16;
    ...
    /* Gracefully handle the B0 case: fall back to B9600 */
    fuart =3D fuart ? fuart : 9600 * 16;
    ...
    p->uartclk =3D fuart;
    serial8250_do_set_termios(p, termios, old);

Similar logic exists in byt_set_termios() in
drivers/tty/serial/8250/8250_lpss.c and dw8250_set_termios() in
drivers/tty/serial/8250/8250_dw.c. In addition, port->uartclk or
UPF_MAGIC_MULTIPLIER can be changed via uart_set_info() or
serial8250_update_uartclk().

If a high baud rate (such as 3000000 on Tangier/Penwell in
mid8250_set_termios() or 5000000 on BayTrail in byt_set_termios()) is set f=
irst,
that speed is saved in port->hup_speed. When B0 is subsequently requested v=
ia
uart_set_termios(), port->uartclk is lowered for the B0 call, reducing max =
in
serial8250_get_baud_rate() below both port->hup_speed and the speed recorded
in old:

1. On try =3D=3D 0, baud =3D=3D 0 is replaced with port->hup_speed, which e=
xceeds max.
   Execution falls through, clears CBAUD in termios, encodes old's high baud
   rate into termios (overwriting B0), sets old =3D NULL, and continues.
2. On try =3D=3D 1, baud from old still exceeds max. Because old is now NUL=
L, it
   clips baud to max - 1, encodes that into termios, exits the loop, trigge=
rs
   WARN_ON(1), and returns 0.

Returning 0 from uart_get_baud_rate_save() leads to a divide-by-zero in
callers such as serial8250_get_divisor(), dw8250_get_divisor(), and
uart_update_timeout(). Furthermore, because B0 in termios->c_cflag was
overwritten with a non-zero speed, uart_set_termios() in
drivers/tty/serial/serial_core.c no longer sees (cflag & CBAUD) =3D=3D B0:

uart_set_termios()
    /* Handle transition to B0 status */
    if (((old_termios->c_cflag & CBAUD) !=3D B0) && ((cflag & CBAUD) =3D=3D=
 B0))
        uart_clear_mctrl(uport, TIOCM_RTS | TIOCM_DTR);

so RTS and DTR are not dropped on hangup.

A related issue occurs in mtk8250_set_termios() in
drivers/tty/serial/8250/8250_mtk.c, which calls serial8250_do_set_termios()
with old =3D=3D NULL (where max is (port->uartclk + tolerance) / 16) before
calling uart_get_baud_rate() with max =3D port->uartclk:

mtk8250_set_termios()
    baud =3D tty_termios_baud_rate(termios);
    serial8250_do_set_termios(port, termios, NULL);
    tty_termios_encode_baud_rate(termios, baud, baud);
    baud =3D uart_get_baud_rate(port, termios, old,
                              port->uartclk / 16 / UART_DIV_MAX,
                              port->uartclk);

When a high-speed rate above (port->uartclk + tolerance) / 16 is saved in
port->hup_speed and B0 is later requested, the first call inside
serial8250_do_set_termios() sees port->hup_speed > max with old =3D=3D NULL=
 and
overwrites port->hup_speed with the clipped rate (port->uartclk + tolerance=
) /
16 - 1 before mtk8250_set_termios() reaches its second uart_get_baud_rate()
call.

Should the B0 fallback clamp port->hup_speed to [min, max] (and avoid saving
back a clamped rate over port->hup_speed when baud =3D=3D 0)?

[Severity: Medium]
Can saving port->hup_speed inside uart_get_baud_rate_save() also break B0
hangup in drivers/tty/serial/dz.c when an unsupported baud rate within
[50, 9600] is requested?

In dz_set_termios():

drivers/tty/serial/dz.c:dz_set_termios() {
    ...
    baud =3D uart_get_baud_rate(uport, termios, old_termios, 50, 9600);
    bflag =3D dz_encode_baud_rate(baud);
    if (bflag < 0) {
        if (old_termios) {
            /* Keep unchanged. */
            baud =3D tty_termios_baud_rate(old_termios);
            bflag =3D dz_encode_baud_rate(baud);
        }
        if (bflag < 0) {        /* Resort to 9600.  */
            baud =3D 9600;
            bflag =3D DZ_B9600;
        }
        tty_termios_encode_baud_rate(termios, baud, baud);
    }
    ...
}

If userspace requests a baud rate in [50, 9600] that dz_encode_baud_rate()
rejects (such as B200), uart_get_baud_rate() saves 200 into uport->hup_speed
before dz_encode_baud_rate() returns -1 and falls back to old_termios or 96=
00.

When B0 is later requested to hang up, uart_get_baud_rate() returns
uport->hup_speed (200), dz_encode_baud_rate(200) fails again, and the fallb=
ack
block calls tty_termios_encode_baud_rate(termios, baud, baud) with the
non-zero fallback rate. That overwrites B0 in termios->c_cflag, preventing
uart_set_termios() from clearing TIOCM_RTS | TIOCM_DTR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alpine.DEB.2.21.261=
1030057510.15685@angie.orcam.me.uk?part=3D2
