Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402985;
	b=kQDEUsioD6sMA6heFfND2QMvYEbBO+svHLsPU4Mt8yeU+8ZACUIws7YLI0P9LXGtYdNV
	 TFtWCdGJL2wpmvISeSOCRvjDHxiehUK51+WulEqTHL3CQpKz/8exheMPL61PJie1vptMG
	 LHdm4rt9rnDqZilMLAQ4zJNrBnqHjk2rWtAEsY0zbAuDeRPwg5Z5CNfC8vgboQ8XW/hsK
	 e3Fwhj8+NfJmHRdYkgzv3BhPZTkGRcx42sRLB/PSIPMOoQEu3mhzLO5Qgs6SMi0jFHzBW
	 5VvMr6Sa58vH4kVHywu8mLpBMRVCXFf+v8x5zz1lozR5tRCCJXpBLVCGPkvVqUDfwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b0UxaG1/FkKkNPrwvDU6OdfngZmWZ4czIDsyvXxNFY0=;
	b=GHLyFadJRhxaeMcx3rC48PhsTif6NAaEkeAOrBWZeGNCvMhpeVvIh9X8TKx9ybbjpriZ
	 9aPYsnuSrhe3X/RUedCLMpVflfirCLAyYeXU7Yd0uuviZ39AXY9z/+KB082kMtVK4EIJ5
	 FyGjGcxWPWZesUBu87x3GMARDzVE0BMPcYanzOHvSDpR0f2MK0LslOHo1bSrsrJmFnV2k
	 R49TkiIMv7uNigiFAFmxlLxqTJOaG4azCJyAVcoyahWc2iV+05ZbckK0j6L72LHSHkEG1
	 0RlrJGUwYl4fGJPcJ0Qf7gnPfT8jE0j9kjIKi4qG8XEFbfhi0yK7e6XcoK4PQ1sCxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSplXX3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131B606A324;
	Wed, 11 Nov 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSplXX3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D91F00A05;
	Wed, 11 Nov 2026 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402985;
	bh=b0UxaG1/FkKkNPrwvDU6OdfngZmWZ4czIDsyvXxNFY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSplXX3yiDha+3kgcyAPiK/WX97psoAKQI4fsfDm/jDCFfG2zYSTn0JzsaNPmMYcq
	 AnorE54dT03XCTTSrHHHU/hazqFypRZXqpnv2CK5HEE3s/KzSK5GS2rau/FxxBJmjZ
	 LiXzSHdfi4U1o6Wkd0p83owpAJBXdp8c96xvdCUQiBlsz30iY8qVS/DPYrg6iB8RKq
	 ihVP9Iyz2IYLAZ8oBy4SoZb75VZJO+d6xzRkohnYSkrK306rVvEmgZ0JY5iNzmy0c2
	 YBOmFHbFBu+8wo7B4sF+iEZmH8nzYAx8CC2soP8F0x6E+eNwK7KgsxFxfYKrn98/TL
	 w5yraN/6nFM8Q==
Message-ID: <sashiko-outbox-209052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] serial: core: Power the line transceiver with the
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-4-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-4-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:16:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] serial: core: use-after-free in uart_line_info() [1]
- [Critical] serial: core: dangling pointer in
  serial_core_add_one_port() [2]
--

commit 54c2531a6ac957209b731d5dba93f7f0ba6a052f
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: core: Power the line transceiver with the port

This commit requests the optional transceiver-enable GPIO and startup delay
for a serial port and toggles the transceiver power alongside the port in
uart_change_pm().

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 6c0a6d9dcb851..d36bffaa100b8 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c

[ ... ]

> @@ -3282,6 +3310,12 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
> =20
>  		if (tty_port_initialized(port))
>  			uart_shutdown(NULL, state);
> +
> +		/* Only a console port is still powered here */
> +		if (uport->transceiver_enable_gpio &&
> +		    state->pm_state =3D=3D UART_PM_STATE_ON)
> +			uart_change_pm(state, UART_PM_STATE_OFF);
> +		uport->transceiver_enable_gpio =3D NULL;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can uart_line_info() race
with serial_core_remove_one_port() and cause a use-after-free [1]?

serial_core_remove_one_port() drops port->mutex at the end of this block and
calls uport->ops->release_port(uport) before setting uport->type to
PORT_UNKNOWN:

CPU0                              CPU1
serial_core_remove_one_port()
  // drops port->mutex
  uport->ops->release_port(uport)
                                  uart_line_info()
                                    guard(mutex)(&port->mutex)
                                    if (uport->type =3D=3D PORT_UNKNOWN)
                                      return;
                                    uport->ops->get_mctrl(uport)  <-- use-a=
fter-free
  uport->type =3D PORT_UNKNOWN

A concurrent read of /proc/tty/driver/serial sees uport->type !=3D PORT_UNK=
NOWN
and invokes get_mctrl() on unmapped IO resources.

[ ... ]

> @@ -3409,6 +3453,14 @@ int serial_core_register_port(struct uart_driver *=
drv, struct uart_port *port)
>  err_unregister_ctrl_dev:
>  	serial_base_ctrl_device_remove(new_ctrl_dev);
> =20
> +err_put_transceiver:
> +	/* The port may be registered again: forget the GPIO */
> +	if (core_transceiver && port->transceiver_enable_gpio) {
> +		devm_gpiod_put(port->dev, port->transceiver_enable_gpio);
> +		port->transceiver_enable_gpio =3D NULL;
> +		port->transceiver_startup_delay_us =3D 0;
> +	}
> +
>  	return ret;
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but does
serial_core_add_one_port() leave a dangling pointer in uport->name when
allocating uport->tty_groups fails [2]?

drivers/tty/serial/serial_core.c:serial_core_add_one_port() {
	...
	uport->tty_groups =3D kzalloc_objs(*uport->tty_groups, 3);
	if (!uport->tty_groups) {
		kfree(uport->name);
		return -ENOMEM;
	}
	...
}

Because the caller owns uport across registration failure, leaving the freed
pointer in uport->name can lead to a use-after-free or double free during
driver cleanup or a subsequent registration retry.

[1] https://sashiko.dev/#/bug/linux-dccfb530-78ab-4c75-b86c-353ac639e159
[2] https://sashiko.dev/#/bug/linux-4946dfed-5de8-46a5-b799-8b71897faf37

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D4
