Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426153;
	b=BDtW4jBDF+GiuhY+p2iTpGT7+q3T1uTe78F+PW5moinehbVpUDjnXwkLLIyzXBUBrXPY
	 VDM2L8dWEv9Q5VSL8rmtwlfJ5X7XaNq+NTDWezsuH2U8JSYe32T836QBwumZuo6f8Uc/r
	 ZLlRy4WRPxzD9I6PsJJb5gCLJNqh2WCayzBHuu863Ehzmc09qhZK54v3y6z/Aal+1mj97
	 Wt1pBqX5tXPtewAHUUV6ZGIVifoTAqRIkmjVAUUnAO0RACuUFVyp1rGaDkkP0kZKwahUO
	 fL/VTM5YfhgRQeNr4MiyHIpvCYmmZ0u2T+Wb2lhestTgilDTJtXJ9cFR2jMhFHiZjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1CdyX77H1GL0ocK9oLxV3N329K482U80FC46gsp+KB8=;
	b=oAFP6ZM9ieWK3cNTJjR6QiLdCeG7YHZphwLH4lnMQHMd50HC7YMS42BF74y7yAL77xBx
	 Xr+JjL5+aSF8PJBIqAsTv6a3qyYs3kO4qq4ysGvP0mkVdQ8gxV88WhbBsZ571by194hXt
	 FdpAgZaFBt8F9o11hm6MbDR2pyUkszNUC34EoigSKGCeWsnrhj51rNMwrsb6BTYiD3wQM
	 W7QxAXYLulG5bg6wySLP8rbeX0HmTZEfJ/0yVVY+MTC2/KQKsgnVBRDWAP0X9M3iwlUux
	 4GhvA1VA9XJ1rETEDVmEVSJE9Gnfiz8tv7pW+pnqaClV8pKInMTVXsPjfgch6GsW5xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSO4QLQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CB606A31C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSO4QLQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7C41F00A05;
	Wed, 11 Nov 2026 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426153;
	bh=1CdyX77H1GL0ocK9oLxV3N329K482U80FC46gsp+KB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSO4QLQAjTKqi/xxi+0LHhCz4fZTiwN6z7/lGW3kdaVSB0s7FerHRLf9pKE0W/sSm
	 AY3qVgCewtJ2sadDuc173ksxRLYhG9osBdG2TzNszMit7cZ8r39vpEbX2QOtlmpBIU
	 2pSaxdikgR8LTMN7FQK/fr33/63rZQ6CTC+A0V/VoMEHqmfmVw/kOUbfd7Bch/1pLY
	 niIUKbcUQ8WGK1jgJClDLdE1fOivD9ZkPu1J/IgLpADgiSC2Ae82hPWvW8TLD3g/0g
	 Foag3kRkyS/mMh8/fFkcoUTnWqGy6qZGBy2V7J6gQ5f3wyqXSJE2JHekBZnpJrejVe
	 hFig+mQMQKMuw==
Message-ID: <sashiko-outbox-209587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] serial: vt8500: Find console ports in the serial
 core state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-1-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
 <20261111-vt8500-serial-cleanup-v1-1-b33594a25f87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:42:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] serial: vt8500: direct access to private uart_driver.state field
--

commit 97ad19d6dd8fe51bf33a0dd201b9aa1860b0702f
Author: Alexey Charkov <alchark@gmail.com>

serial: vt8500: Find console ports in the serial core state

This commit removes the driver's vt8500_uart_ports[] array and looks up
the console port via vt8500_uart_driver.state[co->index].uart_port in
vt8500_console_write() and vt8500_console_setup().

> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt85=
00_serial.c
> index a7f167a734160..6c53e108756a8 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -444,7 +444,6 @@ static int vt8500_verify_port(struct uart_port *port,
>  	return 0;
>  }
> =20
> -static struct vt8500_port *vt8500_uart_ports[VT8500_MAX_PORTS];
>  static struct uart_driver vt8500_uart_driver;
> =20
>  #ifdef CONFIG_SERIAL_VT8500_CONSOLE
> @@ -472,28 +471,27 @@ static void vt8500_console_putchar(struct uart_port=
 *port, unsigned char c)
>  static void vt8500_console_write(struct console *co, const char *s,
>  			      unsigned int count)
>  {
> -	struct vt8500_port *vt8500_port =3D vt8500_uart_ports[co->index];
> +	struct uart_port *port =3D vt8500_uart_driver.state[co->index].uart_por=
t;
>  	unsigned long ier;
> =20
>  	BUG_ON(co->index < 0 || co->index >=3D vt8500_uart_driver.nr);
> =20
> -	ier =3D vt8500_read(&vt8500_port->uart, VT8500_URIER);
> -	vt8500_write(&vt8500_port->uart, VT8500_URIER, 0);
> +	ier =3D vt8500_read(port, VT8500_URIER);
> +	vt8500_write(port, VT8500_URIER, 0);
> =20
> -	uart_console_write(&vt8500_port->uart, s, count,
> -			   vt8500_console_putchar);
> +	uart_console_write(port, s, count, vt8500_console_putchar);
> =20
>  	/*
>  	 *	Finally, wait for transmitter to become empty
>  	 *	and switch back to FIFO
>  	 */
> -	wait_for_xmitr(&vt8500_port->uart);
> -	vt8500_write(&vt8500_port->uart, VT8500_URIER, ier);
> +	wait_for_xmitr(port);
> +	vt8500_write(port, VT8500_URIER, ier);
>  }
> =20
>  static int __init vt8500_console_setup(struct console *co, char *options)
>  {
> -	struct vt8500_port *vt8500_port;
> +	struct uart_port *port;
>  	int baud =3D 9600;
>  	int bits =3D 8;
>  	int parity =3D 'n';
> @@ -502,16 +500,15 @@ static int __init vt8500_console_setup(struct conso=
le *co, char *options)
>  	if (unlikely(co->index >=3D vt8500_uart_driver.nr || co->index < 0))
>  		return -ENXIO;
> =20
> -	vt8500_port =3D vt8500_uart_ports[co->index];
> +	port =3D vt8500_uart_driver.state[co->index].uart_port;

[Severity: Low]
Should vt8500_console_write() and vt8500_console_setup() reach into
vt8500_uart_driver.state directly?

include/linux/serial_core.h:struct uart_driver {
    ...
	/*
	 * these are private; the low level driver should not
	 * touch these; they should be initialised to NULL
	 */
	struct uart_state	*state;
	struct tty_driver	*tty_driver;
};

struct uart_driver::state is marked private to the serial core and not
meant to be accessed directly by low-level UART drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vt8500-ser=
ial-cleanup-v1-0-b33594a25f87@gmail.com?part=3D1
