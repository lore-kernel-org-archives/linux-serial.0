From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 6/8] serial: 8250: Copy mctrl when register port.
Date: Wed, 6 Jun 2018 09:31:02 -0500 (CDT)
Message-ID: <1533624932.66943.1528295462220.JavaMail.zimbra@xes-inc.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com> <20180601124021.102970-7-giulio.benetti@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-7-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

----- Original Message -----
> From: "Giulio Benetti" <giulio.benetti@micronovasrl.com>
> Sent: Friday, June 1, 2018 7:40:19 AM

> RS485 can modify mctrl on startup, especially when RTS_AFTER_SEND is on
> TIOCM_RTS is set, then need to keep it set when registering port.
> 
> Copy mctrl to new port too.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> drivers/tty/serial/8250/8250_core.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c
> b/drivers/tty/serial/8250/8250_core.c
> index c8c2b260c681..c8e62fbd6570 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -993,6 +993,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
> 		uart->port.unthrottle	= up->port.unthrottle;
> 		uart->port.rs485_config	= up->port.rs485_config;
> 		uart->port.rs485	= up->port.rs485;
> +		uart->port.mctrl	= up->port.mctrl;

Hi Guilio,

I ran into this same thing about six months ago, but I was able to
accomplish what I needed by assigning a set_mctrl() function in my
port definition. Perhaps that would be enough for your case, too?

You should see a little lower in this file that set_mctrl is copied
to the new port.

-Aaron

> 		uart->dma		= up->dma;
> 		uart->em485		= up->em485;
> 
> --
> 2.17.0
