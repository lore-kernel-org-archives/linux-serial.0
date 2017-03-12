From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250: 8250_core: Use dev_name() during request_irq()
Date: Sun, 12 Mar 2017 22:05:38 +0200
Message-ID: <CAHp75VeFKSbk9hvoJXdK6uOz+JYATD8D057iNv0JDuEnBFS=yw@mail.gmail.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308121943.29340-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 8, 2017 at 2:19 PM, Vignesh R <vigneshr@ti.com> wrote:
> Passing "serial" as name during request_irq() results in all serial port
> irqs have same name. This does not help much to easily identify which
> irq belongs to which serial port instance. Therefore pass dev_name()
> during request_irq() so that better identifiable name is listed for
> serial ports in cat /proc/interrupts output.
>
> Output of cat /proc/interrupts
> Before this patch:
>  26:        689          0     GICv2 309 Edge      serial
> After this patch:
>  26:        696          0     GICv2 309 Edge      2530c00.serial

I don't know if it worth to mention that some (testing) tools may
depend on this name.
Besides that imagine what would be the name of PCI device here. I
would suggest adding ID if you need one in a form like
"serial%d", where ID may or may not be supplied by the actual 8250 drivers.

>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 76e03a7de9cc..f83b69f30987 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -218,7 +218,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>                 spin_unlock_irq(&i->lock);
>                 irq_flags |= up->port.irqflags;
>                 ret = request_irq(up->port.irq, serial8250_interrupt,
> -                                 irq_flags, "serial", i);
> +                                 irq_flags, dev_name(up->port.dev), i);
>                 if (ret < 0)
>                         serial_do_unlink(i, up);
>         }
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
