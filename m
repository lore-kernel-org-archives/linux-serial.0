From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/2] serial: sc16is7xx
Date: Fri, 25 Apr 2014 10:26:40 -0700
Message-ID: <20140425172640.GA27841@kroah.com>
References: <1398387367-4047-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48100 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaDYRXq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 13:23:46 -0400
Content-Disposition: inline
In-Reply-To: <1398387367-4047-1-git-send-email-jon@ringle.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jon@ringle.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, shc_work@mail.ru, Jon Ringle <jringle@gridpoint.com>

On Thu, Apr 24, 2014 at 08:56:06PM -0400, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>=20
> The SC16IS7xx is a slave I2C-bus/SPI interface to a single-channel
> high performance UART. The SC16IS7xx's internal register set is
> backward-compatible with the widely used and widely popular 16C450.
>=20
> The SC16IS7xx also provides additional advanced features such as
> auto hardware and software flow control, automatic RS-485 support, an=
d
> software reset.
>=20
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/tty/serial/Kconfig       |    9 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/sc16is7xx.c   | 1279 ++++++++++++++++++++++++++++=
++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 1292 insertions(+)
>  create mode 100644 drivers/tty/serial/sc16is7xx.c

I get a few build warnings with this patch applied:

drivers/tty/serial/sc16is7xx.c:1059:12: warning: =E2=80=98sc16is7xx_pro=
be=E2=80=99 defined but not used [-Wunused-function]
 static int sc16is7xx_probe(struct device *dev,
            ^
drivers/tty/serial/sc16is7xx.c:1175:12: warning: =E2=80=98sc16is7xx_rem=
ove=E2=80=99 defined but not used [-Wunused-function]
 static int sc16is7xx_remove(struct device *dev)
            ^
drivers/tty/serial/sc16is7xx.c:1214:29: warning: =E2=80=98regcfg=E2=80=99=
 defined but not used [-Wunused-variable]
 static struct regmap_config regcfg =3D {
                             ^

Can you send a follow-on patch to fix them?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
