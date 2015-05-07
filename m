From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: xuartps: add __init to earlycon write method
Date: Thu, 07 May 2015 11:27:39 +0200
Message-ID: <2877098.2SVXFizf2K@wuerfel>
References: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com> <5630573.8B6nn9XCXJ@wuerfel> <CAK7LNATxom6m-sP_hx19qVy8waTZ=-ypGSz64pZ0QHRw9=mDjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATxom6m-sP_hx19qVy8waTZ=-ypGSz64pZ0QHRw9=mDjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 07 May 2015 18:14:43 you wrote:
> 2015-05-07 18:08 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 07 May 2015 18:02:39 Masahiro Yamada wrote:
> >> @@ -1075,7 +1075,8 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
> >>         writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
> >>  }
> >>
> >> -static void cdns_early_write(struct console *con, const char *s, unsigned n)
> >> +static void __init cdns_early_write(struct console *con, const char *s,
> >> +                                   unsigned n)
> >>  {
> >>         struct earlycon_device *dev = con->data;
> >>
> >>
> >
> > Why?
> >
> 
> I thought this function is used during the early boot stage.
> 
> I am seeing drivers/tty/serial/8250/8250_early.c
> for reference.
> 
> All the functions in this file are marked as __init.
> 
> Perhaps, am I misunderstanding?
> 

Makes sense, please explain that in the commit message and send the
patch again.

	Arnd
