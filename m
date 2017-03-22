From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
Date: Wed, 22 Mar 2017 20:48:23 +0200
Message-ID: <CAHp75VeJioLbr54fK7xF6HOLdSaKJ3ArWazXHVfhT7qi4=7mUQ@mail.gmail.com>
References: <20170321133636.8814-1-vigneshr@ti.com> <20170321133636.8814-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321133636.8814-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
> Using dev_name() as irq name during request_irq() might be misleading in
> case of serial over PCI. Therefore identify serial port irqs using
> uart_port's name field. This will help mapping irqs to appropriate
> ttySN(where N is the serial port index) instances.
>

Based on the information in name member of uart_port it looks best
approach to me.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index f83b69f30987..48a07e2f617f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -218,7 +218,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>                 spin_unlock_irq(&i->lock);
>                 irq_flags |= up->port.irqflags;
>                 ret = request_irq(up->port.irq, serial8250_interrupt,
> -                                 irq_flags, dev_name(up->port.dev), i);
> +                                 irq_flags, up->port.name, i);
>                 if (ret < 0)
>                         serial_do_unlink(i, up);
>         }
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
