From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Don't shutdown mpc5200 serial port if it is a console
Date: Thu, 19 Apr 2007 20:43:26 +0200
Message-ID: <4627B84E.10904@246tNt.com>
References: <11770061133776-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:49902 "EHLO
	outmx023.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbXDSSoO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Apr 2007 14:44:14 -0400
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
        by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id l3JIi9hA027316
        for <linux-serial@vger.kernel.org>; Thu, 19 Apr 2007 20:44:10 +0200
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <11770061133776-git-send-email-grant.likely@secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, Wolfgang Denk <wd@denx.de>, Bartlomiej Sieka <tur@semihalf.com>

The idea is OK,

but only TX should be left active and the interrupts should still be
disabled (imr set to 0), so we don't generate unhandled interrupts ...


        Sylvain


Grant Likely wrote:
> If the serial port gets shut down, then console output stalls.  9 out
> of 10 kernel hackers agree, this is a bad thing.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>
> ---
>
> This is a simple bug fix, but it's not a critical one.  It would be really
> nice to get this merged for 2.6.21
>  drivers/serial/mpc52xx_uart.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index f8c1761..35669f8 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -257,14 +257,16 @@ mpc52xx_uart_shutdown(struct uart_port *port)
>  {
>  	struct mpc52xx_psc __iomem *psc = PSC(port);
>  
> -	/* Shut down the port, interrupt and all */
> -	out_8(&psc->command,MPC52xx_PSC_RST_RX);
> -	out_8(&psc->command,MPC52xx_PSC_RST_TX);
> +	/* We don't want to shut down a port that is used as a console */
> +	if (!uart_console(port)) {
> +		out_8(&psc->command,MPC52xx_PSC_RST_RX);
> +		out_8(&psc->command,MPC52xx_PSC_RST_TX);
>  
> -	port->read_status_mask = 0;
> -	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
> +		port->read_status_mask = 0;
> +		out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
> +	}
>  
> -	/* Release interrupt */
> +	/* Release interrupt (OK for console port b/c console uses polling) */
>  	free_irq(port->irq, port);
>  }
>  
>   

