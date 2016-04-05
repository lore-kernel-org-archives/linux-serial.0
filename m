From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] serial: 8250_dw: fix wrong logic in
 dw8250_check_lcr()
Date: Tue, 05 Apr 2016 13:50:07 +0300
Message-ID: <1459853407.12843.7.camel@linux.intel.com>
References: <1459827166-13861-1-git-send-email-wangkefeng.wang@huawei.com>
	 <1459835585-25751-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459835585-25751-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-04-05 at 13:53 +0800, Kefeng Wang wrote:
> Commit cdcea058e510 ("serial: 8250_dw: Avoid serial_outx code
> duplicate
> with new dw8250_check_lcr()") introduce a wrong logic when write val
> to
> LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used
> unconditionally.
>=20
> The __raw_readq/__raw_writeq is introduced by commit bca2092d7897
> ("serial:
> 8250_dw: Use 64-bit access for OCTEON.") for OCTEON, so for
> !PORT_OCTEON,
> we better to use coincident write func.
>=20
> Fixes: cdcea058e510("serial: 8250_dw: Avoid serial_outx code
> duplicate with new dw8250_check_lcr()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>=20
> Changes since v3:
> - Add patch change log, suggested by Greg Kroah-Hartman.
> Changes since v2:
> - Add #ifdef CONFIG_64BIT back, ensure it can be built under=20

Oh, true. Since it's a native IO we can't use writeq() helper from io-
64-nonatomic-*.=C2=A0

> configuration lacking readq/writeq.
> Changes since v1:
> - Repace '#ifdef CONFIG_64BIT' with IS_ENABLED(CONFIG_64BIT).
> - Enrich patch log, and add Fixes tag.
> =C2=A0=C2=A0
>=20
> =C2=A0drivers/tty/serial/8250/8250_dw.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index a3fb95d..47d1f3e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -104,15 +104,16 @@ static void dw8250_check_lcr(struct uart_port
> *p, int value)
> =C2=A0		dw8250_force_idle(p);
> =C2=A0
> =C2=A0#ifdef CONFIG_64BIT
> -		__raw_writeq(value & 0xff, offset);
> -#else
> +		if (p->type =3D=3D PORT_OCTEON)
> +			__raw_writeq(value & 0xff, offset);
> +		else
> +#endif
> =C2=A0		if (p->iotype =3D=3D UPIO_MEM32)
> =C2=A0			writel(value, offset);
> =C2=A0		else if (p->iotype =3D=3D UPIO_MEM32BE)
> =C2=A0			iowrite32be(value, offset);
> =C2=A0		else
> =C2=A0			writeb(value, offset);
> -#endif

So, this changes logic to write the value on any 64 platform, using
different (non-64-bit) accessors, so, the case to fix is
actually "64BIT && !PORT_OCTEON". Perhaps commit message should be
amended to point that clearly.

> =C2=A0	}
> =C2=A0	/*
> =C2=A0	=C2=A0* FIXME: this deadlocks if port->lock is already held

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
