Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E98331207
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771051; cv=none; b=QADP9DA4vWtuzqdnQ8Fqwdpqy2a87r+LJNvwzI4wsP3/eUCj7BDg4yomZaH8ByS3CaQRTvMDIx7us7Tpv0ya5x6YO9HqWyr6KhUAnS/2aKrCI0UcHB1/cKswQCNGOeTLlg7aw8pacKqLXXBIqmR5Hn9rbNgQPwNc6P3yJaL4zVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771051; c=relaxed/simple;
	bh=jHSd8RRQaMsiV+mhGFWewU9Ixg0xJha+quY/4+AAnvM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uOIXcylHMaMKbYblXoJ+ilJXhXFzNHkl3kmgAenTKp4aRZClHRZifuw0Y4oLnedMYHJjByk8ajID4Q3/9SLvq4oyVOG1VQB1qaKRn4Os7nj1uRJhNTMi1orWb6p4UVSiS6EHi+/qKxg5F0e/tSTSfpqR4EdDmrYN+ZcvoRhJlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsmbPVam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsmbPVam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FCE1F0089B;
	Mon, 12 Oct 2026 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791771050;
	bh=wAHWANcuWaRCaOwVrrgs7qrqHQSZ+nR1pD2CpoanKM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsmbPVamgvlun6/7Gq3/zKVHqMIW9AxFGhY+9jv3l2cBRkuqtsjHeRroRDzQuUf1P
	 Mlc2YgMq9SLA3OEH3Znm/VFy7VCK7zBeXkNUuC43gTOeUf6NI884PQD+uvRn4EwQma
	 yuscw4iEmjGjfmR0cbxfwwseP4k4U75cew9kqlLi41tiHVwtzOlM9mFATUy6v/Ny6T
	 sZkjciT/J3Q9lgYEAHHJli1EPJrSt+udWxTKmheKFaJJJHh9xHwSmqKIvV627mY37F
	 BPcCnzCfEhYhAgtnrMr6MAE+sA0BIjO9Tfl5cHW5Tz8Z6EfE4SmXNi3RuwZnbSnaqo
	 buhP6B5jQmx4A==
Message-ID: <sashiko-outbox-167551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Don't clobber the baud rate on
 hangup via B0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk>
 <alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 02:10:49 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: division by zero in uart_get_divisor() on uninitialized port-=
>hup_speed
- [Medium] tty: serial: data race on port->hup_speed in uart_get_baud_rate()
--

commit 3c831138bb5fb81f1a02fc66246315af11bf6bbc
Author: Maciej W. Rozycki <macro@orcam.me.uk>

serial: core: Don't clobber the baud rate on hangup via B0

Requesting hangup via the B0 baud rate clobbers the previously set rate
unless it is 9600bps or the port minimum. This commit tracks the most
recently set baud rate in port->hup_speed and uses it whenever the B0
rate is requested.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 319a4b427f3a3..3390e4d142127 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
[ ... ]
> @@ -514,10 +514,12 @@ uart_get_baud_rate(struct uart_port *port, struct k=
termios *termios,
>  		 * Special case: B0 rate.
>  		 */
>  		if (baud =3D=3D 0)
> -			return max(min, 9600);
> +			return port->hup_speed;

[Severity: High]
Does this risk a division by zero panic?

If a new struct uart_port is initialized, port->hup_speed defaults to 0.
If a B0 rate is requested before any valid rate is set (such as via
console=3DttyS0,0 or an early tcsetattr with B0), this returns 0.

This 0 is then passed down to helpers like uart_get_divisor(), which
calculates the divisor as:

	quot =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);

It can also reach uart_update_timeout(), which calculates the frame time:

	port->frame_time =3D (unsigned int)DIV64_U64_ROUND_UP(temp, baud);

In both cases, passing a 0 baud rate will result in a divide-by-zero
hardware exception.

> =20
> -		if (baud >=3D min && baud <=3D max)
> +		if (baud >=3D min && baud <=3D max) {
> +			port->hup_speed =3D baud;

[Severity: Medium]
Could this result in a data race on port->hup_speed?

In the standard uart_set_termios() path, uart_get_baud_rate() is called
holding only port->mutex and termios_rwsem, not port->lock.

At the same time, atomic console write paths execute asynchronously from
hardirq or NMI holding only the nbcon lock. For example:

drivers/tty/serial/8250/8250_port.c:serial8250_console_restore() {
	...
	baud =3D serial8250_get_baud_rate(port, &termios, NULL);
	...
}

This calls into uart_get_baud_rate() without holding port->mutex. A
concurrent tcsetattr() and atomic console write can trigger an unprotected
data race on port->hup_speed. A torn read or write on this variable could
yield a garbage baud rate and lead to hardware misconfiguration.

>  			return baud;
> +		}
> =20
>  		/*
>  		 * If the range cannot be met then try again with

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alpine.DEB.2.21.261=
0120150230.55767@angie.orcam.me.uk?part=3D1
