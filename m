From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
Date: Tue, 6 Aug 2019 09:48:15 +0300
Message-ID: <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
References: <20190805193243.18584-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805193243.18584-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> The vast majority of the serial drivers check for
>
>     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
>
> condition one or more times. Create a dedicated helper function and
> convert drivers to use it.

Sometimes the arguments are swapped. It means that in case of first
being false the second is aslo going to be checked.
So, does ordering have any side effect?

Please, elaborate this in the commit message.

>  drivers/tty/serial/8250/8250_dma.c          |  2 +-
>  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
>  drivers/tty/serial/sc16is7xx.c              |  2 +-

For the drivers I care about (see above) I prefer to see conversion on
per driver basis. Of course, if Greg is okay with the current, I won't
object.

> -               if (uart_tx_stopped(&up->port) ||
> -                   uart_circ_empty(&up->port.state->xmit)) {
> +               if (uart_tx_stopped_or_empty(&up->port)) {

Yes, it becomes one line, but...

> -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> -           uart_circ_empty(&uap->port.state->xmit)) {
> +       if (!(dmacr & UART011_TXDMAE) ||
> +           uart_tx_stopped_or_empty(&uap->port)) {

...wouldn't be the case here as well? And perhaps in other places?

-- 
With Best Regards,
Andy Shevchenko
