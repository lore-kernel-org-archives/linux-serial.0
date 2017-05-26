From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] serial: exar: Preconfigure xr17v35x MPIOs as output
Date: Fri, 26 May 2017 20:38:14 +0200
Message-ID: <20170526183814.GD16490@kroah.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
 <6155891d19531be018d30fd55ffd6d42493af8c1.1494660546.git.jan.kiszka@siemens.com>
 <9bb8d972-6535-1611-8fa7-f5fe89760531@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9bb8d972-6535-1611-8fa7-f5fe89760531@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 03:04:26PM +0200, Jan Kiszka wrote:
> Greg,
> 
> On 2017-05-13 09:28, Jan Kiszka wrote:
> > This is the safe default for GPIOs with unknown external wiring.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 1270ff163f63..b4fa585156c7 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -177,13 +177,13 @@ static void setup_gpio(u8 __iomem *p)
> >  	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> >  	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> >  	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> > -	writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> > +	writeb(0xff, p + UART_EXAR_MPIOSEL_7_0);
> >  	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> >  	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> >  	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> >  	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> >  	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> > -	writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> > +	writeb(0xff, p + UART_EXAR_MPIOSEL_15_8);
> >  	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> >  }
> >  
> > 
> 
> Please drop from this tty-next, it may break Commtech adapters. I have
> an update ready.
> 
> I may also send a fix on top if that is preferred, just let me know.

I need a fixup patch, I can't drop a patch, only revert it.

thanks,

greg k-h
