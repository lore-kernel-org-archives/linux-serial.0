From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial: Delete dead code for CIR serial ports
Date: Fri, 16 Jun 2017 20:39:46 +0300
Message-ID: <CAHp75Ve_DU4dagb0R7MZXayjx7zdiCy3kLCB1+Rd8fX3zyC59A@mail.gmail.com>
References: <20170616151714.30835-1-mbrugger@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616151714.30835-1-mbrugger@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <mbrugger@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ed Blake <ed.blake@imgtec.com>, Vignesh R <vigneshr@ti.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, David Howells <dhowells@redhat.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 16, 2017 at 6:17 PM, Matthias Brugger <mbrugger@suse.com> wrote:
> Commit e4fda3a04275 ("serial: don't register CIR serial ports") adds a
> check for PORT_8250_CIR to serial8250_register_8250_port(). But the code
> isn't needed as the function never takes the branch when the port is CIR
> serial port.
>
> This patch deletes the dead code.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One comment below.

>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 1aab3010fbfa..b5def356af63 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1043,24 +1043,13 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>                 if (up->dl_write)
>                         uart->dl_write = up->dl_write;
>
> -               if (uart->port.type != PORT_8250_CIR) {
> -                       if (serial8250_isa_config != NULL)
> -                               serial8250_isa_config(0, &uart->port,
> -                                               &uart->capabilities);
> -
> -                       ret = uart_add_one_port(&serial8250_reg,
> -                                               &uart->port);
> -                       if (ret == 0)
> -                               ret = uart->port.line;
> -               } else {
> -                       dev_info(uart->port.dev,
> -                               "skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> -                               uart->port.iobase,
> -                               (unsigned long long)uart->port.mapbase,
> -                               uart->port.irq);
> +               if (serial8250_isa_config != NULL)
> +                       serial8250_isa_config(0, &uart->port,
> +                                       &uart->capabilities);

If it exceeds 80 by ~3 characters it's still okay from my p.o.v.
Nevertheless, it's your choice.

>
> -                       ret = 0;
> -               }
> +               ret = uart_add_one_port(&serial8250_reg, &uart->port);
> +               if (ret == 0)
> +                       ret = uart->port.line;
>         }
>         mutex_unlock(&serial_mutex);
>
> --
> 2.12.3
>



-- 
With Best Regards,
Andy Shevchenko
