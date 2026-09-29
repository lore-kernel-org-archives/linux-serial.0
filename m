Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C6376A02
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676064; cv=none; b=UlEqyEpeoKjd70+qcKwJeXuS65kYgkOQzMp04qxkSKxjLfiLlK62zqP6xxnaxZCBRo+m5xogki8y0nXaHHTv4kTTQMoKhJnigFhX3V69CvXcFmFNxl4eyYpGm0usBEZn3InJi2arZA08sSeYACPF3DaGQQKL48c4ML8FLt7Lj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676064; c=relaxed/simple;
	bh=2gBYMlKMnv1sW/ieIxPiITijgtefp/fJDX4WAgDtKbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKw2TF2hkVpG+Z0WVcX2FualS5mnwZn80PAmnZ/kt/9DnTRZtDz5AdHQwPMbtLARgL5SXM3nee+otDl62mi4b/5VvbX2dZhbxvVlS18oAuBeBXJrw7m/Z4ahv7skHOthbPCqykvZiGHz9MP55xOT4U+SMgCl5Klj/icPMp6rSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs1sDIjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs1sDIjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA401F000FF;
	Tue, 29 Sep 2026 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676060;
	bh=7s0kcfdZzQxY1PzQbgpIWLP3FZAkYtTUh++anISUYSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hs1sDIjW4hJ/uuCweoR61/OX5zOk76hI7MW+jWbtLUo0wLNQfD9npvqcl+QRnney3
	 jvOaO0cv2Dv1Dy9P6P+EU/QnfRXHDY3kc62IRvxTWQxb7AL3Td7DLk+fiLreJDSPm7
	 +WUSwT997syGseDj0cSTM9NKnkDjLaHXdsrSUGDR0bQ+2ve3F3RJ5h64wYQe5SBkMn
	 8TWGs8h2gK1yC+TVgJtf3jUMbM7TvNgZcXTdliyiLagEpMT6Y/si/PDZTrSQ5FFJ4b
	 5o3HliJ7ndMcXaRBmt3OJgaGStrVz+c5XfCdJW8bnWbUShbfgk1Tcn4aqcYW1iaOMB
	 MdytsHX5/qrCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:01:00 +0000
Message-Id: <20260929100100.8BA401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: max310x: NULL ptr deref in max310x_rs_proc() on probe
--

commit 2044bfaeeb59d6861a67dec32fd0381512b925dd
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date:   Tue Sep 29 09:37:57 2026 +0000

    serial: max310x: convert RS485 delays from milliseconds to bit-times
   =20
    The HDPIXDELAY register counts the RTS setup and hold delays in
    bit-times, four bits per direction, but the driver has been writing the
    struct serial_rs485 delay_rts_before_send/delay_rts_after_send values
    into it unconverted - and the uapi expresses those in milliseconds. A
    requested 9 ms setup delay is programmed as 9 bit-times, which at 9600
    baud is 0.94 ms, roughly a tenth of what userspace asked for; the error
    grows with the baud rate.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 693decd04de10..f8dad37d017af 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -953,10 +1000,20 @@ static void max310x_break_ctl(struct uart_port *po=
rt, int break_state)
>  	 * break duration and drive RTS manually so the break reaches the wire;
>  	 * restore auto-RTS when the break ends.
>  	 */
> -	max310x_port_update(port, MAX310X_MODE1_REG,
> -			    MAX310X_MODE1_TRNSCVCTRL_BIT,
> -			    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
> -	max310x_rts_ctl(port, break_state);
> +	if (break_state) {
> +		max310x_port_update(port, MAX310X_MODE1_REG,
> +				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
> +		max310x_rts_ctl(port, 1);
> +	} else {

[Severity: Medium]
This is a pre-existing issue, but if RS485 is disabled mid-break, does this
leave the RTS pin stuck active for the remainder of the session?

Earlier in max310x_break_ctl():

    if (!(port->rs485.flags & SER_RS485_ENABLED))
        return;

If RS485 was enabled when the break started (break_state =3D 1) but gets di=
sabled
before the break ends (break_state =3D 0), that early return prevents this =
branch
from clearing the LCR_RTS bit.

Could this break RS232 communication until the port is closed or RS485 is
re-enabled?

> +		/*
> +		 * Reapply the current configuration: a reconfigure that
> +		 * arrived during the break was deferred by the tx_break
> +		 * guard. Then release the manual RTS - auto-RTS owns the
> +		 * pin again.
> +		 */
> +		max310x_set_rts_ctl_params(one);
> +		max310x_rts_ctl(port, 0);
> +	}
>  }
[ ... ]
> @@ -1073,41 +1130,35 @@ static void max310x_set_termios(struct uart_port =
*port,
[ ... ]
>  static void max310x_rs_proc(struct work_struct *ws)
>  {
>  	struct max310x_one *one =3D container_of(ws, struct max310x_one, rs_wor=
k);
> -	unsigned int delay, mode1 =3D 0, mode2 =3D 0;
> +	unsigned int mode2 =3D 0;
> =20
>  	/*
>  	 * Serialize against break_ctl() and set_termios(), which run under
> -	 * port->mutex: the tx_break test below and the MODE1 write must not
> +	 * port->mutex: the tx_break-guarded register writes must not
>  	 * straddle a break starting or ending.
>  	 */
>  	guard(mutex)(&one->port.state->port.mutex);

[Severity: High]
Can this trigger a NULL pointer dereference during device probe?

During max310x_probe(), uart_get_rs485_mode() calls max310x_rs485_config() =
which
queues this rs_work on the system workqueue. Because this happens before
uart_add_one_port() assigns the port.state pointer, won't this newly added =
guard
evaluate &one->port.state->port.mutex with a NULL port.state?

Additionally, if the probe fails after uart_get_rs485_mode(), it jumps to t=
he
out_uart error path:

drivers/tty/serial/max310x.c:max310x_probe() {
    ...
    ret =3D uart_get_rs485_mode(&s->p[i].port);
    if (ret)
        goto out_uart;

    /* Register port */
    ret =3D uart_add_one_port(&max310x_uart, &s->p[i].port);
    if (ret)
        goto out_uart;
    ...
out_uart:
    for (i =3D 0; i < devtype->nr; i++) {
        if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
            uart_remove_one_port(&max310x_uart, &s->p[i].port);
    }
}

Since this error path fails to call cancel_work_sync(&one->rs_work), will it
leak the work structure and trigger a use-after-free when the system workqu=
eue
processes it?

> =20
> -	delay =3D (one->port.rs485.delay_rts_before_send << 4) |
> -		one->port.rs485.delay_rts_after_send;
> -	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
> +	max310x_set_rts_ctl_params(one);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D3
