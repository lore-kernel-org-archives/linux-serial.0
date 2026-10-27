Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100635;
	b=NFbMKAwwvXih6qkdW6R/8EXfVXcsfHA23dSivMVu12pyVHaH/7RboMuiAcFTZaV7X8ke
	 st6d01t0KBFHExvnHDZUwNCR1BBUL6yZ259rGQ3lKcnelNqgrRiWcSt41EUcpWeNYV6sx
	 X7CLPICLUsuYyxKo7exb0fzOlLMeYR8N+YYCXIuTVYlW2kupM6sZynzePDX+DwqBb58/b
	 TxupWg/7tz9gCRBjsWgWOSf6auBUyYpT57gMCIYEqiZBH2mEjbE9sCBdRqkzEVtDIBaHI
	 7KGDmLMVw1pYYi5XiTz3xCjQ9WbwFId/aJuxtGQgj07HPx6Hpe3RoBqTeKopCpnc7wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1gaSAtd4qtuKoxuNgLZLmq1cz6NpFZsDroytuckmNWM=;
	b=E3DnaQE7OYEU220cSdtmz+ppuHmHcH+Am26Ol5+pKepEuymD2D7eXwgSsbQcK1bh3MJq
	 zv3ue1bQ/kcey0ln1ZKD24T6oUDuJ/vNI25m0R8iMDAMaafQyJ556g60sWs8YHYL2ww0x
	 knr5RrS420JNVS+V5wtmhmVaiiIWc7iVW/1CHRJOX9Hp4ukqWh4SfndKB+CNmBckWMw92
	 MpfiPlfGqQMHI5TkkwGA/6jPlbh++sHR0zQIlv3ZbfYTiK9P2R/WNsy9OzP3TtYbJyebX
	 ofx7PaFap6GN5AKaUyxy7EfHb9dzB5MglirT7ITU4kcXtFxYA6DZzxDSXZiNCQSwLcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ36RZP1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88A606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ36RZP1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B21F01825;
	Tue, 27 Oct 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100634;
	bh=1gaSAtd4qtuKoxuNgLZLmq1cz6NpFZsDroytuckmNWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZ36RZP1mNXKavF4HHJg1HgJ6PJ4gHSRLYVucQbWfVI6kEy0qwOnEiGFYjxx87JOF
	 ODswt9GjKrivia+OqLeCGTmWHBnbmjINJQ+BVGGU/vs9jpKQmAknINZYwmKrV8WTD+
	 HM9ZRRxeCvES9Zu37zLdhXpYYGadtfmijpZo2M/PQ9eMvSCFVqmkK9yvn50S/Y+Z7i
	 J1h9HoK1TQY7o7izTCsyRJmmY76cfqbLi3ZU/XIyg+Jc5Hc0QDnjSCu+nFYItt5mBv
	 Vl0/MJxgx5RWQ1/NLZYbi3bgTB7Ig4sueLOFlaLBhR5K2XhO9EovmG7j/Z/nrZWMKb
	 HDYE7E5AsdQlw==
Message-ID: <sashiko-outbox-186444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/24] serial: 8250: clear subdriver state on port
 unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-5-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-5-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:30:33 +0000
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
- [High] serial: 8250: clear rxtrig, break_ctl, attr_group, rs485 gpios on =
unregister
--

commit 84854ce6768bb6d9f299a8c1baf6b88228a5ea32
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: clear subdriver state on port unregister

This commit clears subdriver-copied callbacks and per-driver fields on
struct uart_8250_port and calls serial8250_set_defaults() in
serial8250_unregister_port() before re-registering the port as a fallback
ISA port.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 0951d3e42e1f3..673fde55828a9 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -956,7 +956,35 @@ void serial8250_unregister_port(struct uart_8250_por=
t *uart)
>  		uart->port.dev =3D &serial8250_isa_devs->dev;
>  		uart->port.port_id =3D uart->port.line;
>  		uart->capabilities =3D 0;
> +
> +		/*
> +		 * Clear subdriver-owned state copied by
> +		 * serial8250_register_8250_port() to prevent dangling
> +		 * pointers after the original driver module is unloaded.
> +		 */
> +		uart->port.private_data =3D NULL;
> +		uart->port.set_termios =3D NULL;
> +		uart->port.set_ldisc =3D NULL;
> +		uart->port.get_mctrl =3D NULL;
> +		uart->port.set_mctrl =3D NULL;
> +		uart->port.get_divisor =3D NULL;
> +		uart->port.set_divisor =3D NULL;
> +		uart->port.startup =3D NULL;
> +		uart->port.shutdown =3D NULL;
> +		uart->port.throttle =3D NULL;
> +		uart->port.unthrottle =3D NULL;
> +		uart->port.handle_break =3D NULL;
> +		uart->port.rs485_config =3D NULL;
> +		memset(&uart->port.rs485, 0, sizeof(uart->port.rs485));
> +		memset(&uart->port.rs485_supported, 0,
> +		       sizeof(uart->port.rs485_supported));
> +		uart->gpios =3D NULL;
> +		uart->dma =3D NULL;
> +		uart->rs485_start_tx =3D NULL;
> +		uart->rs485_stop_tx =3D NULL;

[Severity: High]
Should serial8250_unregister_port() also clear get_rxtrig, set_rxtrig,
break_ctl, attr_group, rs485_term_gpio, and rs485_rx_during_tx_gpio on
uart->port?

During registration, __serial8250_register_8250_port() in
drivers/tty/serial/8250/8250_core.c conditionally copies get_rxtrig,
set_rxtrig, and break_ctl from the subdriver template:

	if (up->port.get_rxtrig)
		uart->port.get_rxtrig =3D up->port.get_rxtrig;
	if (up->port.set_rxtrig)
		uart->port.set_rxtrig =3D up->port.set_rxtrig;
	if (up->port.startup)
		uart->port.startup =3D up->port.startup;
	if (up->port.shutdown)
		uart->port.shutdown =3D up->port.shutdown;
	if (up->port.break_ctl)
		uart->port.break_ctl =3D up->port.break_ctl;

When a modular subdriver such as mxpcie8250_probe() in
drivers/tty/serial/8250/8250_mxpcie.c registers a port with a type that sets
uart->port.attr_group =3D &serial8250_dev_attr_group via
serial8250_config_port() -> register_dev_spec_attr_grp(), unbinding the
subdriver leaves attr_group, get_rxtrig, and set_rxtrig set on the fallback
ISA port. When uart_add_one_port() -> serial_core_add_one_port() re-adds the
fallback port, it re-attaches uport->attr_group (exposing rx_trig_bytes in
sysfs), and reading or writing rx_trig_bytes calls rx_trig_bytes_show() or
rx_trig_bytes_store() in drivers/tty/serial/8250/8250_port.c:

	if (uport->get_rxtrig)
		rxtrig_bytes =3D uport->get_rxtrig(uport);
	else
		rxtrig_bytes =3D do_serial8250_get_rxtrig(port);

If 8250_mxpcie was unloaded, this calls into freed module text; if the
device was only unbound, mxpcie8250_set_rxtrig() dereferences NULL from
dev_get_drvdata(port->dev) on &serial8250_isa_devs->dev and accesses
unmapped port->membase.

Similarly, if the fallback port is later configured or its serial8250_ports
slot is reused by another subdriver that does not set break_ctl (or if the
previous subdriver used UPIO_AU, where set_io_from_upio() does not reset
serial_in and serial_out), serial8250_break_ctl() will invoke the previous
subdriver's dangling break_ctl callback.

In addition, __serial8250_register_8250_port() calls uart_get_rs485_mode()
in drivers/tty/serial/serial_core.c, which allocates devm-managed GPIO
descriptors on the subdriver's device:

	desc =3D devm_gpiod_get_optional(dev, "rs485-term", GPIOD_OUT_LOW);
	if (IS_ERR(desc))
		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-term-gpios\n");
	port->rs485_term_gpio =3D desc;
	...
	desc =3D devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
	if (IS_ERR(desc))
		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-g=
pios\n");
	port->rs485_rx_during_tx_gpio =3D desc;

When the subdriver unbinds, devres frees these descriptors, but
rs485_term_gpio and rs485_rx_during_tx_gpio remain non-NULL. If a subsequent
RS485-capable subdriver without a firmware node (!dev_fwnode(dev)) reuses
the slot, uart_get_rs485_mode() returns early without overwriting those
fields, and uart_set_rs485_termination() or uart_set_rs485_rx_during_tx()
will pass the freed gpio_desc pointers to gpiod_set_value_cansleep().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D5
