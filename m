From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx
Date: Thu, 20 Mar 2014 14:08:48 +0000
Message-ID: <20140320140848.GB23372@e106331-lin.cambridge.arm.com>
References: <1395324177-15311-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:53961 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755870AbaCTOJ1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Mar 2014 10:09:27 -0400
Content-Disposition: inline
In-Reply-To: <1395324177-15311-1-git-send-email-jon@ringle.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "jon@ringle.org" <jon@ringle.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "shc_work@mail.ru" <shc_work@mail.ru>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Ringle <jringle@gridpoint.com>

On Thu, Mar 20, 2014 at 02:02:57PM +0000, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>=20
> The SC16IS7xx is a slave I2C-bus/SPI interface to a single-channel
> high performance UART. The SC16IS7xx=E2=80=99s internal register set =
is
> backward-compatible with the widely used and widely popular 16C450.
>=20
> The SC16IS7xx also provides additional advanced features such as
> auto hardware and software flow control, automatic RS-485 support, an=
d
> software reset.
>=20
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/tty/serial/Kconfig       |   10 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/sc16is7xx.c   | 1258 ++++++++++++++++++++++++++++=
++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 1272 insertions(+)
>  create mode 100644 drivers/tty/serial/sc16is7xx.c

[...]

> +static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] =3D=
 {
> +       { .compatible =3D "nxp,sc16is740",        .data =3D &sc16is74=
x_devtype, },
> +       { .compatible =3D "nxp,sc16is741",        .data =3D &sc16is74=
x_devtype, },
> +       { .compatible =3D "nxp,sc16is750",        .data =3D &sc16is75=
0_devtype, },
> +       { .compatible =3D "nxp,sc16is752",        .data =3D &sc16is75=
2_devtype, },
> +       { .compatible =3D "nxp,sc16is760",        .data =3D &sc16is76=
0_devtype, },
> +       { .compatible =3D "nxp,sc16is762",        .data =3D &sc16is76=
2_devtype, },
> +       { }
> +};

Please document these strings (even if under a trivial binding
document).

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
