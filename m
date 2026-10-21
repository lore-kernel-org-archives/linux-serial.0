Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588958;
	b=LBw9AAlH1zRosIon2YwmJJvGIE1zQqPBndL7lsdbJlT4hAfBz4KRRAhqhsSOJbwFOJKX
	 xWClpcoikRCXMKkAtOFo1NkonqriiAD7wBqcpoORC8ZQF5djnDbusbgXLf0QlljQignnN
	 RDn/zoEtJLVqYmIl9PrlxhzamZqQi3tD/FrcuOAgw148YJyEYoK9e3TIrjpeK9ithHRcu
	 mFqhAapRqWjyNs4iIKZzSNBMgXBLFBJSaCm8gs3f55XsD05eRwNl2L25MD4ZeuELYFP8+
	 uUeh/2EvxeQMa1HWpBw6/fTvHpv3UbsP2rSlrKGcyZV3jDZrUdo+4j4rcn/QutsFQDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1e5vEM5bC0Ni4rbWVmWLeHIbQLKHuQ+qzL2ZykOAEfA=;
	b=AnLcDOnLtVjuiKSVqkWVS5lNS5Skh4Y2rlfnFm5NJsv+FokDofAQOU7mJnpWcCbR2y0h
	 LFgA7F2edPSyfasPVRb07M6TMmbyTtSLwHER7e4FYeinUS9DoJ/JwG3pODuWUBw1kKgGh
	 pyU4Muke4ykGGQGgRejFMonjIUlq6DgQBK+yS3c2dVpGI7R47ZhfEjQsroSoGzNZD963Z
	 rf3Psk/qvyqRZR+dCI20E/0iZ2zZiRv554y/hPx0XPmGBzVYp2WWG7KsSYZU9LjsTLlt1
	 crUhIvLrjeN/59z7KeZ0kfmFZeaPWza682SQxjBSxu+8aODqG0k7hcNVJvSLV57anZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHu9sjEw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EC606A319;
	Wed, 21 Oct 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHu9sjEw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF871F000C4;
	Wed, 21 Oct 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588957;
	bh=1e5vEM5bC0Ni4rbWVmWLeHIbQLKHuQ+qzL2ZykOAEfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHu9sjEwzlW3PBpLtZxSQOIc9JAEurY4I7ohfXwaJSnH4n128xr3+r7OWbAd6gfKE
	 isnlBzO4BLOcxfRYpSOi7jRcBSwI+LvgkszJca4mu6iZZLCma8hhbSLks7sHcXVyZ0
	 1xieyBhmivr4Uq9KLcxhh78obMNKmPMcz59G+v9oXMhWILWZlm8XQxi2ym4VdHsAZL
	 tkjJRrB0ryVe6l2+JrzHynggmJsn1wulW1mHHPfTziZXmlXX8CMR67ygTmy9FMK/tv
	 V4U1HiGtCX0Z/MvVTt2+E/HGU1xeup/QaYDIoOb0OuaU9skjfMb/pLlC4ID39XzhQj
	 WGJ/TUoAdEnDQ==
Message-ID: <sashiko-outbox-180298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261021-g2ul_sci-v2-3-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-3-b4e038220018@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:22:36 +0000
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
- [Medium] serial: sh-sci: missing has_tdxe_auto_clear init in scix_early_c=
onsole_setup()
--

commit 7c4175b5ac1e1b0c0d116921a097acf598dc7be1
Author: Au Dang <au.dang.jx@renesas.com>

serial: sh-sci: Skip TDxE clear when hardware clears it automatically

This commit adds a tdxe_auto_clear flag to struct sci_of_data and propagates
it to struct sci_port as has_tdxe_auto_clear to skip software clearing of
TDxE in sci_transmit_chars() and sci_poll_put_char() on PORT_SCI variants.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 58120b523ca1e..aa179c7874878 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *port,=
 unsigned char c)
>  	} while (!(status & SCxSR_TDxE(port)));
> =20
>  	sci_serial_out(port, SCxTDR, c);
> -	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
> +	if (!s->has_tdxe_auto_clear)
> +		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
>  }
>  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
>  	  CONFIG_SERIAL_SH_SCI_EARLYCON */

[ ... ]

> @@ -3791,6 +3794,7 @@ static struct plat_sci_port *sci_parse_dt(struct pl=
atform_device *pdev,
>  	sp->ops =3D data->ops;
>  	sp->port.ops =3D data->uart_ops;
>  	sp->params =3D data->params;
> +	sp->has_tdxe_auto_clear =3D data->tdxe_auto_clear;

[Severity: Medium]
Should scix_early_console_setup() in drivers/tty/serial/sh-sci.c also copy
data->tdxe_auto_clear to sci_ports[0].has_tdxe_auto_clear?

When earlycon is enabled on a renesas,sci port, sci_early_console_setup() ->
scix_early_console_setup() initializes sci_ports[0] from of_sci_sci, but
leaves has_tdxe_auto_clear unset:

drivers/tty/serial/sh-sci.c:scix_early_console_setup() {
	...
	sci_ports[0].cfg =3D &port_cfg;
	sci_ports[0].params =3D data->params;
	sci_ports[0].ops =3D data->ops;
	sci_ports[0].port.ops =3D data->uart_ops;
	sci_uart_earlycon =3D true;
	...
}

During early console output via serial_console_write() ->
uart_console_write() -> serial_console_putchar() -> sci_poll_put_char(),
s->has_tdxe_auto_clear will still be false on sci_ports[0], causing
s->ops->clear_SCxSR() to be called in software instead of being skipped.

> =20
>  	sp->has_rtscts =3D of_property_read_bool(np, "uart-has-rtscts");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci-v=
2-0-b4e038220018@bp.renesas.com?part=3D3
