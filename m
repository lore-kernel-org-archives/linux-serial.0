Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561310;
	b=R9uTSqrhySjREHcIuYtADS85Jiyf2PesK3YmdUL4oPLH2G+C645KTz1IecuD+tjFFNFE
	 iDnEqWek/pCroI7RWJQ/4t02WAAFz0aeHFDxcf+qnN/h++ChCJ01twoAYOk7n4EMtLl7i
	 5hcMmI56cZ0Sb30ToIDMYyHZ/MDn8duGJLdEzVECt6K8iMv0NKdRJNEex8x+4qs4wp8ZI
	 KQZiCCBco6m5kIFIqVItJK0p/t+NEHK1vKj2r8lD79RBz5+xQTY88kuePBDUtF4LsDjL8
	 G7XfP1U1IOiQcVnmwlisMEWTp+SxhhX85/oAK1kC+O3guUaw+HGfDZq0x9cJkyarXBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MN4MangAJwgDVHM/i/uw0B1SMsAPspQRo3yBcgSD3XQ=;
	b=MR6Gx/9kvrh2g7MRLbzBIaYhRWKOHaZEtF+CcS5DrCGAbOH5tPYfN72vq/0mhbQRvmhx
	 Ud2zWU4255AiHmtWuut5VQjdOheMlOYa8LwKKnh8GZtd8s7vYHr/pmbHe3xD38JNfmzpM
	 U494dhXrau0q7QVAcMOPgTxcOUeCLCkHWQpK6k8HbDa4zmV+udKUb4lMS9gvB3VVA2HWg
	 tvL1jDdN+tBZNkocEZLSL55+/SkNyUOyIoYoHZGDlEgvF4qmACe7C0Y0SZIsULJg66zPR
	 +/YfDF3WqugqBDRSH5Vd+R65lPZ5OTLXHNlOekiA04cjFf/SuBL8JKN6dA/jDS0KsLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dh7V/QJ3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D796606A31C;
	Wed, 21 Oct 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dh7V/QJ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203D1F000C9;
	Wed, 21 Oct 2026 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792561310;
	bh=MN4MangAJwgDVHM/i/uw0B1SMsAPspQRo3yBcgSD3XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dh7V/QJ37d49BqsjEsAcOD1yf3mGFf0tobtekR5N16e/Vf3l0S4N78CNYIICvYzfE
	 Fz69r0CtkHkOgbrQfYtqzdE27ADK5P0WzjCPWAFU0LmHOGZxNQIkWKH3v0aAv9+Q9s
	 Fb5lUJw6wK7NLv7KWT/CrRvvxh9U3UueZ6yW8omfySVqXF7g0FIweXB5ARKlbVYYfO
	 DsMtJGWMMMqWt05uCLB3oXDd0aZqTcxzAG+Q6rNL75gS2bF2cBg2p5+kv+oZABFacW
	 eV904D6O6PY0zhMmlnmyo4dcpewCiH5R2vl1q1KSOJ4EhRu9nO23dYxnsM5NzDIw3P
	 5YW3Ek7cOJwvw==
Message-ID: <sashiko-outbox-179812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: core: Drive the transceiver interface
 select GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261021-serial-rs485-mode-gpio-v1-2-80d7b0903d93@vaisala.com>
References: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
 <20261021-serial-rs485-mode-gpio-v1-2-80d7b0903d93@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:41:49 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: core: stale rs485_select_gpio access in uart_rs485_config()
- [Medium] serial: core: rs485-select asserted before RTS parked in uart_ge=
t_rs485_mode()
--

commit 49736223bf33ff5e8eb201ccbef821265b8748f6
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: core: Drive the transceiver interface select GPIO

This commit adds support for an optional rs485-select-gpios property in
uart_get_rs485_mode() to switch multiprotocol transceivers between RS485
and alternative interfaces such as RS232. The GPIO state is updated during
boot/resume configuration in uart_rs485_config() and during ioctl handling
in uart_set_rs485_config().

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index c0deec0e6af41..57b022d0cf01b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1435,13 +1435,22 @@ static void uart_set_rs485_rx_during_tx(struct ua=
rt_port *port,
>  				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>  }
> =20
> +static void uart_set_rs485_select_gpio(struct uart_port *port,
> +				       const struct serial_rs485 *rs485)
> +{
> +	gpiod_set_value_cansleep(port->rs485_select_gpio,
> +				 !!(rs485->flags & SER_RS485_ENABLED));
> +}
> +
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 =3D &port->rs485;
>  	int ret;
> =20
> -	if (!(rs485->flags & SER_RS485_ENABLED))
> +	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +		uart_set_rs485_select_gpio(port, rs485);
>  		return 0;
> +	}

[Severity: High]
Could calling uart_set_rs485_select_gpio() unconditionally here when
SER_RS485_ENABLED is not set access a released port->rs485_select_gpio
descriptor when a static uart_port slot is reused?

In drivers/tty/serial/8250/8250_core.c, __serial8250_register_8250_port()
reuses static entries from serial8250_ports[] and populates port->rs485_sel=
ect_gpio
via uart_get_rs485_mode():

drivers/tty/serial/8250/8250_core.c:__serial8250_register_8250_port() {
	...
	uart->port.rs485_config	=3D up->port.rs485_config;
	uart->port.rs485_supported =3D up->port.rs485_supported;
	uart->port.rs485	=3D up->port.rs485;
	...
	if (up->port.dev) {
		uart->port.dev =3D up->port.dev;
		ret =3D uart_get_rs485_mode(&uart->port);
		if (ret)
			return ret;
	}

Because port->rs485_select_gpio is acquired with devm_gpiod_get_optional(),
its lifetime is bound to port->dev. If registration subsequently fails in
__serial8250_register_8250_port() (for example in mctrl_gpio_init() or
uart_add_one_port()) or the device is later unbound and unregistered via
serial8250_unregister_port(), devres releases the descriptor while leaving
the pointer set in the static serial8250_ports[] entry.

When a subsequent 8250 device claims the same slot without RS485 support or
without a firmware node, uart_get_rs485_mode() returns early without
resetting port->rs485_select_gpio:

drivers/tty/serial/serial_core.c:uart_get_rs485_mode() {
	...
	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
		return 0;

	if (!dev_fwnode(dev))
		return 0;

Previously, uart_rs485_config() returned 0 immediately when
SER_RS485_ENABLED was clear. With this change, uart_configure_port() ->
uart_rs485_config() and uart_resume_port() -> uart_rs485_config() call
gpiod_set_value_cansleep(port->rs485_select_gpio, 0) using the dangling
pointer.

Should uart_get_rs485_mode() clear the RS485 GPIO pointers before its early
returns (or when a port is unregistered), and should uart_rs485_config()
also check port->rs485_supported.flags?

[ ... ]

> @@ -3643,6 +3663,13 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	if (port->rs485_rx_during_tx_gpio)
>  		port->rs485_supported.flags |=3D SER_RS485_RX_DURING_TX;
> =20
> +	dflags =3D (rs485conf->flags & SER_RS485_ENABLED) ?
> +		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	desc =3D devm_gpiod_get_optional(dev, "rs485-select", dflags);
> +	if (IS_ERR(desc))
> +		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-select-gpio=
s\n");
> +	port->rs485_select_gpio =3D desc;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(uart_get_rs485_mode);

[Severity: Medium]
When linux,rs485-enabled-at-boot-time is set, doesn't requesting
rs485-select with GPIOD_OUT_HIGH in uart_get_rs485_mode() switch the
transceiver into RS485 mode before the UART driver has parked the RTS line
at its RS485 idle level?

During probe (for example in __serial8250_register_8250_port(),
imx_uart_probe(), serial_omap_probe_rs485(), and ar933x_uart_probe()),
uart_get_rs485_mode() runs before uart_add_one_port() ->
uart_configure_port() -> uart_rs485_config() invokes port->rs485_config()
to configure RTS and validate the boot-time settings.

In drivers/tty/serial/8250/8250_core.c, uart_get_rs485_mode() also runs
before mctrl_gpio_init() requests the RTS GPIO (which initializes it to
GPIOD_OUT_LOW regardless of rs485-rts-active-low) and before 8250
autoconfig manipulates UART_MCR_RTS:

drivers/tty/serial/8250/8250_core.c:__serial8250_register_8250_port() {
	...
	if (up->port.dev) {
		uart->port.dev =3D up->port.dev;
		ret =3D uart_get_rs485_mode(&uart->port);
		if (ret)
			return ret;
	}
	...
	if (uart->port.dev && !has_acpi_companion(uart->port.dev)) {
		struct mctrl_gpios *gpios =3D mctrl_gpio_init(&uart->port, 0);

Since RTS acts as the transceiver driver enable in RS485 mode, could
asserting rs485-select-gpios here in uart_get_rs485_mode() cause transient
bus contention on probe before uart_rs485_config() runs?

Should uart_get_rs485_mode() instead request rs485-select with
GPIOD_OUT_LOW and leave asserting it to uart_rs485_config() after
port->rs485_config() has parked RTS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-serial-rs4=
85-mode-gpio-v1-0-80d7b0903d93@vaisala.com?part=3D2
