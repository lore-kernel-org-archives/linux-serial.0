From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: xuartps: add __init to earlycon write method
Date: Thu, 07 May 2015 11:08:31 +0200
Message-ID: <5630573.8B6nn9XCXJ@wuerfel>
References: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 07 May 2015 18:02:39 Masahiro Yamada wrote:
> @@ -1075,7 +1075,8 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
>         writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
>  }
>  
> -static void cdns_early_write(struct console *con, const char *s, unsigned n)
> +static void __init cdns_early_write(struct console *con, const char *s,
> +                                   unsigned n)
>  {
>         struct earlycon_device *dev = con->data;
>  
> 

Why?

	Arnd
