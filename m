Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425093;
	b=CWgnQeIO2liFkS7DKs1CFc+SmkBeqGWUkj5QB8SBVZD+m643Mq0/2R9HANA0hHVCVR3c
	 dfsLtKEiNGbRHYbKtCmDiLtYNYuXFS+QYpZfAE3tV9LeR7+qN2x9MB7Pt3hx5S7+/J6Ji
	 IO92bNy9fVO9J/h4rJvGWBdPNgrL1P6t0fPhjHuwRZMbGkWdLSxpctlFzh0XBvieKM4iK
	 2SciA9Q8f2tl51d0JeTGsL6EjFizRDt1V4nKH5tJUkgonXLf/nsXzs18sufcHMLCnGd8p
	 41mpQCJTQKXsxtWFcIo7+b2Qk0HZyRo3oQdrJ3ap8CmMESjs4pbbDmZJrn1CT6Ese6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WEXyBhKBz34CtawRsRyfi8JyW0dBQNi7qRjF2WAAGag=;
	b=WAdWQawzig6RwmujQO8n5ctFXTg/z3DPAXwVHMbum0GPz9DF72XYQCNfmDHmiDCd3mI1
	 4BLkhacJ2Cep1cHy5bfpy6K++y35t388kZAta4IhD8+f05THO/k7xf5WSEsC87EgeIHMg
	 qEwFQs2zeUv4MZ+LrJCLIWsJy+UmKvs9g51Waf+ikQ2G/cvDOxuIL8wE3Q9sRB8pG8XSi
	 K+98fcqIciw5Ew7RUCyqqfyaQzKq2GthigjFLiFtSgojw5fQvLLRJtmYZDld2vJfYt6dw
	 dnv2V8leU7JVQabl+HHUjeL1/XZ/ncG7Sbv6ix9K9Ikcd5c/wVby2nlBo7WzfjKhCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0sjTe2M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C8606C142
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0sjTe2M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931491F000C4;
	Mon, 19 Oct 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425092;
	bh=WEXyBhKBz34CtawRsRyfi8JyW0dBQNi7qRjF2WAAGag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0sjTe2Mw70St2KNnmkQRG6VyQXTgUyQX+NZ30Y+ZL0a5rb5fIa+ypuNRd9Qg7pnz
	 PgoLnlPYsorwRjFT1vjitJ1gXbqAugSpudsON/I1eeczMAUj8z+jSbMuTgi/kbiDJT
	 LVH/WOI90LstXDCmUo5cg2NofEuo6zA/pyh6YOM2DimwZJBkTPYtxqZaTCfqZ6gJ7q
	 OVmZMzCpgXtAb8aqR5qiUfnGZPyugcDdK/Zb7fPXklT9fZNOvm/WpGMumnPqYsMnPK
	 M66IxW8wBPRXNVwegK+34RlPLQZEMqFOyQfrYNrrFWCbzbfzET7DohpvZ7fOYENqXM
	 5VUUnVo/2U5lQ==
Message-ID: <sashiko-outbox-177794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] serial: qcom_geni: Disable
 closing_wait for console to prevent shutdown timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019135441.1420968-515-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-515-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:51:32 +0000
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
- [Medium] serial: qcom_geni: uncancelled console TX in qcom_geni_serial_st=
artup()
--

commit 410ad55ea7c02110e68e77ae15503cb551a22bf5
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

serial: qcom_geni: Disable closing_wait for console to prevent shutdown tim=
eout

This commit sets closing_wait to ASYNC_CLOSING_WAIT_NONE in
qcom_geni_serial_startup() for console ports so that closing the console
TTY bypasses tty_wait_until_sent() during system shutdown.

Link: https://patch.msgid.link/20260706093749.836121-1-aniket.randive@oss.q=
ualcomm.com

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 8058b839b26ce..219ac88b0fab2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1227,6 +1227,7 @@ static int qcom_geni_serial_startup(struct uart_por=
t *uport)
>  {
>  	int ret;
>  	struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +	struct tty_port *tport =3D &uport->state->port;
> =20
>  	if (!port->setup) {
>  		ret =3D qcom_geni_serial_port_setup(uport);
> @@ -1234,6 +1235,13 @@ static int qcom_geni_serial_startup(struct uart_po=
rt *uport)
>  			return ret;
>  	}
> =20
> +	/*
> +	 * Skip the close-time transmit drain for console ports so that
> +	 * shutdown can proceed without waiting for pending TX completion.
> +	 */
> +	if (uart_console(uport))
> +		tport->closing_wait =3D ASYNC_CLOSING_WAIT_NONE;

[Severity: Medium]
Does uart_shutdown() actually get called to cancel pending TX commands when=
 a
console port is closed?

The commit message states that setting closing_wait to ASYNC_CLOSING_WAIT_N=
ONE
bypasses tty_wait_until_sent() on close, allowing uart_shutdown() to cancel=
 TX
commands cleanly.

However, when uart_console(uport) is true, serial_core_add_one_port() sets
port->console:

drivers/tty/serial/serial_core.c:serial_core_add_one_port() {
	...
	port->console =3D uart_console(uport);
	...
}

When userspace closes the final file descriptor on the console TTY via
tty_release() -> uart_close() -> tty_port_close(), tty_port_close_start()
skips tty_wait_until_sent() without calling tty_driver_flush_buffer() (unle=
ss
tty->flow.tco_stopped is set):

drivers/tty/tty_port.c:tty_port_close_start() {
	...
		if (tty->flow.tco_stopped)
			tty_driver_flush_buffer(tty);
		if (port->closing_wait !=3D ASYNC_CLOSING_WAIT_NONE)
			tty_wait_until_sent(tty, port->closing_wait);
	...
}

Then tty_port_close() calls tty_port_shutdown(), which returns early for
console ports without invoking port->ops->shutdown() (uart_tty_port_shutdow=
n()
-> uart_port_shutdown() -> qcom_geni_serial_shutdown()):

drivers/tty/tty_port.c:tty_port_shutdown() {
	struct tty_struct *tty =3D port->tty;

	mutex_lock(&port->mutex);
	if (port->console)
		goto out;
	...
}

After that, tty_port_close_end() clears TTY_PORT_ACTIVE via
tty_port_set_active(port, false), so even a subsequent uart_hangup() (which
checks tty_port_active(port)) will not call uart_flush_buffer() or
uart_shutdown().

Doesn't this leave pending GENI sequencer TX commands (UART_START_TX), TX
interrupts, and unsent bytes in tport->xmit_fifo active after the console T=
TY
is closed, causing subsequent qcom_geni_serial_console_write() calls to poll
until timeout before cancelling the stalled command and re-triggering
qcom_geni_serial_isr() -> qcom_geni_serial_handle_tx_fifo() on the leftover
xmit_fifo data?

> +
>  	uart_port_lock_irq(uport);
>  	qcom_geni_serial_start_rx(uport);
>  	uart_port_unlock_irq(uport);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-515-sashal@kernel.org?part=3D1
