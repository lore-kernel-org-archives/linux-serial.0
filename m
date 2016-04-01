From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Fri, 01 Apr 2016 12:58:03 +0300
Message-ID: <1459504683.5907.151.camel@linux.intel.com>
References: <1459501618-21021-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459501618-21021-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-04-01 at 17:06 +0800, Kefeng Wang wrote:
> Commit cdcea058e510("serial: 8250_dw: Avoid serial_outx code
> duplicate
> with new dw8250_check_lcr()") introduce a wrong logic when write val
> to
> LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used
> unconditionally.
>=20
> But for !PORT_OCTEON, we better to use coincident write func.
>=20
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>=20
> We met following calltrace twice, if the change is not necessary,
> correct me,
> and any advice will be appreciated, thanks.

So, does this fix you issue? If it does than perhaps you need to Cc
stable@ and put Fixes tag as well.

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

You may also get rid of this one, like

if (IS_ENABLED(CONFIG_64BIT) && p->type =3D=3D PORT_OCTEON)
=C2=A0...
else if
=2E..

> =C2=A0		if (p->iotype =3D=3D UPIO_MEM32)
> =C2=A0			writel(value, offset);
> =C2=A0		else if (p->iotype =3D=3D UPIO_MEM32BE)
> =C2=A0			iowrite32be(value, offset);
> =C2=A0		else
> =C2=A0			writeb(value, offset);
> -#endif
> =C2=A0	}
> =C2=A0	/*
> =C2=A0	=C2=A0* FIXME: this deadlocks if port->lock is already held

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
