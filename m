From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date: Thu, 8 Aug 2013 15:47:31 +0100
Message-ID: <5203AF83.30101@imgtec.com>
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:50109 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934262Ab3HHOsR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 10:48:17 -0400
In-Reply-To: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

On 08/08/13 14:31, John Crispin wrote:
> From: Thomas Langer <thomas.langer@lantiq.com>
> 
> Enable the clock if one is present when setting up the console.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/tty/serial/lantiq.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 15733da..ce1ea35 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
>  
>  	port = &ltq_port->port;
>  
> +	if (ltq_port->clk)

I think that should be !IS_ERR(ltq_port->clk)? The same problem appears
to be elsewhere in that file too.

Cheers
James

