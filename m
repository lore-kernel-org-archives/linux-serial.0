From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 11/15] serial: mxs-auart: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 11 Jun 2012 10:36:02 +0800
Message-ID: <20120611023601.GA14180@S2100-06.ap.freescale.net>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
 <1337987696-31728-11-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:57852
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab2FKCPg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Jun 2012 22:15:36 -0400
Content-Disposition: inline
In-Reply-To: <1337987696-31728-11-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, Fabio Estevam <fabio.estevam@freescale.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Fri, May 25, 2012 at 08:14:52PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prepare the clock before enabling it.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/tty/serial/mxs-auart.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ec56d83..c109642 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -552,7 +552,7 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
>  	s = auart_port[co->index];
>  	port = &s->port;
>  
> -	clk_enable(s->clk);
> +	clk_prepare_enable(s->clk);
>  
>  	/* First save the CR then disable the interrupts */
>  	old_ctrl2 = readl(port->membase + AUART_CTRL2);
> @@ -578,7 +578,7 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
>  	writel(old_ctrl0, port->membase + AUART_CTRL0);
>  	writel(old_ctrl2, port->membase + AUART_CTRL2);
>  
> -	clk_disable(s->clk);
> +	clk_disable_unprepare(s->clk);
>  }
>  
>  static void __init
> -- 
> 1.7.1
> 
No, clk_prepare() should not be called in auart_console_write() which
is an atomic context.  However it reminds me that auart_console_setup()
needs a fix as below.

Regards,
Shawn

--8<---

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..a3bb06b 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -638,18 +638,16 @@ auart_console_setup(struct console *co, char *options)
        if (!s)
                return -ENODEV;

-       clk_prepare_enable(s->clk);
+       clk_prepare(s->clk);
+       if (ret)
+               return ret;

        if (options)
                uart_parse_options(options, &baud, &parity, &bits, &flow);
        else
                auart_console_get_options(&s->port, &baud, &parity, &bits);

-       ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
-
-       clk_disable_unprepare(s->clk);
-
-       return ret;
+       return uart_set_options(&s->port, co, baud, parity, bits, flow);
 }

 static struct console auart_console = {


