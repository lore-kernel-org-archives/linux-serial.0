From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 06/11] tty: serial: 8250: Move EXPORT_SYMBOL to function
Date: Wed, 16 Dec 2015 09:06:47 -0800
Message-ID: <56719A27.4060102@hurleysoftware.com>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
 <1450280177-4460-7-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-7-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffeck@fau.de>
List-Id: linux-serial@vger.kernel.org

On 12/16/2015 07:36 AM, Anton Wuerfel wrote:
> This patch moves EXPORT_SYMBOL macros directly after the definition o=
f
> the corresponding symbol to remove checkpatch warnings.

Ok.


> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> CC: linux-kernel@i4.cs.fau.de
> ---
>  drivers/tty/serial/8250/8250_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial=
/8250/8250_core.c
> index 89a20c9..67147b2 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -764,6 +764,7 @@ void serial8250_suspend_port(int line)
> =20
>  	uart_suspend_port(&serial8250_reg, port);
>  }
> +EXPORT_SYMBOL(serial8250_suspend_port);
> =20
>  /**
>   *	serial8250_resume_port - resume one serial port
> @@ -789,6 +790,7 @@ void serial8250_resume_port(int line)
>  	}
>  	uart_resume_port(&serial8250_reg, port);
>  }
> +EXPORT_SYMBOL(serial8250_resume_port);
> =20
>  /*
>   * Register a set of serial devices attached to a platform device.  =
The
> @@ -1168,9 +1170,6 @@ static void __exit serial8250_exit(void)
>  module_init(serial8250_init);
>  module_exit(serial8250_exit);
> =20
> -EXPORT_SYMBOL(serial8250_suspend_port);
> -EXPORT_SYMBOL(serial8250_resume_port);
> -
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
> =20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
