Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C03911C9
	for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046705; cv=none; b=rvMrq/w2iE+NJbYduhL8b3tUY8Tfmi8WGUbB5CABqEK83zd1eelLz3fYiLEZHptXeLiuycCH+uZLSHzWn+MOHqvAJ4PhMtPCp1SwOzVN/AnQhrdxzTwVKqZqqcVsHQNWIW6P0YowxRB+1Rl3U6JqxB8byxI1cCGZXXDUL+epdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046705; c=relaxed/simple;
	bh=6cq02uCFRyEda0OXTXuqzVxWviAtUCj9U+QRX4Hth0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNKZmC1Tp7kodYdcBgirAc3JZk4a0LFZUGUSmFWNVf+4v9bPSJNmIxzGJqmYeDBn700NZCRiudSFF5aox4yhZ6ukrwfYnDESkV/nLCY9UUq2ojGaAEVRMJa2HnTkebb0eimdRU2RsEYV7IxbbCzLfhyzrlQF52GATlmktWpZfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5QrqzJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5QrqzJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9221F000FF;
	Thu, 10 Sep 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046703;
	bh=7+NmZSnPabyvI1i5W4j2g9PAl0UyxbraaPgJvbAz2xM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5QrqzJrEyvl/hGXOPkN57JsIWjJlzewQCd3ICMjWjQVOqosU4l5Pxls4z9Z8rRXG
	 utTCMhwApqpKa38FsZkJLOa+2arVEHYIdAH91Km/PcJFr8XBaPGIJt61O/kNUTpe/k
	 PXMh7P4umX2naCQDjL8KN7Ot2Movk5Lo7xSipOh3VzbcYf9knjLw266uuJXQ9jkHTw
	 ik1+jkOzjeVOrpAQVVt8+KT1Gwp0A5W2ZODux6GlCQGTeVNjDSFR6pd1FENYUumo9V
	 Jyl4S2tBPnSGholvKLHJSdqkq2OXVFe7iVo0uRQzgz6uJhL1sR821s2MyQrtyJ1BVu
	 QI3TIibcrGJnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] serial: fix ioctl hangup race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260910130816.642699-3-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
 <20260910130816.642699-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:25:02 +0000
Message-Id: <20260910132503.3F9221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch misses several tty driver callbacks that access hardware=
 and can race with hangup, including those triggered by the TCXONC ioctl an=
d racing writes.
--

commit b720c07153ba95668df0da514b07008b06834b2e
Author: Johan Hovold <johan@kernel.org>

serial: fix ioctl hangup race

This commit adds tty_io_error checks to several tty ioctls and driver
operations. It aims to ensure the port has not been hung up before accessing
the hardware, avoiding kernel panics.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 1553bc6cbe7ba..139b938762298 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -896,7 +896,7 @@ static int uart_set_info(struct tty_struct *tty, stru=
ct tty_port *port,
>  	upf_t old_flags, new_flags;
>  	int retval;
> =20
> -	if (!uport)
> +	if (!uport || tty_io_error(tty))
>  		return -EIO;
> =20
>  	new_port =3D new_info->port;

[Severity: High]
This isn't a bug introduced by this patch, but does this miss several other
tty driver callbacks that access hardware and can race with hangup, includi=
ng
those triggered by the TCXONC ioctl and racing writes?

Invoking hardware callbacks (start_tx, stop_tx, send_xchar) on a powered-do=
wn
or unclocked UART port causes bus errors and kernel panics.

Can a user call ioctl(TCXONC) on a hung-up terminal and invoke uart_stop(),
uart_start(), or uart_send_xchar()? These do not check tty_io_error(tty) and
unconditionally access the hardware:

drivers/tty/serial/serial_core.c:uart_stop() {
	port =3D uart_port_ref_lock(state, &flags);
	if (port)
		port->ops->stop_tx(port);
	...
}

drivers/tty/serial/serial_core.c:uart_start() {
	port =3D uart_port_ref_lock(state, &flags);
	__uart_start(state);
	...
}

drivers/tty/serial/serial_core.c:uart_send_xchar() {
	if (port->ops->send_xchar)
		port->ops->send_xchar(port, ch);
	...
}

Additionally, can a concurrent write() race with uart_shutdown()? If
uart_write() acquires the port lock after uart_port_shutdown() disables the
hardware but before uart_free_xmit_buf() clears the buffer pointer, it will
pass the !state->port.xmit_buf check and invoke start_tx on the dead hardwa=
re:

drivers/tty/serial/serial_core.c:uart_write() {
	port =3D uart_port_ref_lock(state, &flags);
	if (!state->port.xmit_buf) {
		uart_port_unlock_deref(port, flags);
		return 0;
	}
	...
	__uart_start(state);
	...
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910130816.6426=
99-1-johan@kernel.org?part=3D2
