From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty/serial: remove AVR32 specific access wrappers
Date: Wed, 14 Jun 2017 12:43:40 +0300
Message-ID: <CAHp75VcMrhG0K-=dtkF1T5siAAmmLYdmCxcLdo_vvH8dLjLh=A@mail.gmail.com>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 13, 2017 at 11:25 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Now that AVR32 is gone, the specific wrappers for that architecture are
> unnecessary and will not be compiled anymore.
>

Can you rebase this on top of tty-next?

I'm pretty sure this patch will gone.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 937d67f22fba..8bfc566df2da 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -228,21 +228,6 @@ static inline void atmel_uart_writel(struct uart_port *port, u32 reg, u32 value)
>         __raw_writel(value, port->membase + reg);
>  }
>
> -#ifdef CONFIG_AVR32
> -
> -/* AVR32 cannot handle 8 or 16bit I/O accesses but only 32bit I/O accesses */
> -static inline u8 atmel_uart_read_char(struct uart_port *port)
> -{
> -       return __raw_readl(port->membase + ATMEL_US_RHR);
> -}
> -
> -static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
> -{
> -       __raw_writel(value, port->membase + ATMEL_US_THR);
> -}
> -
> -#else
> -
>  static inline u8 atmel_uart_read_char(struct uart_port *port)
>  {
>         return __raw_readb(port->membase + ATMEL_US_RHR);
> @@ -253,8 +238,6 @@ static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
>         __raw_writeb(value, port->membase + ATMEL_US_THR);
>  }
>
> -#endif
> -
>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>  static bool atmel_use_pdc_rx(struct uart_port *port)
>  {
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
