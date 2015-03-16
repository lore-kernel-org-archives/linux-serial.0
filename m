From: cascardo@linux.vnet.ibm.com
Subject: Re: [patch 2/2] serial: jsm: some off by one bugs
Date: Mon, 16 Mar 2015 14:47:43 -0300
Message-ID: <20150316174743.GB6037@oc0812247204.ltc.br.ibm.com>
References: <20150312170823.GB21911@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150312170823.GB21911@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, driverdev-devel@linuxdriverproject.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 12, 2015 at 08:08:24PM +0300, Dan Carpenter wrote:
> "brd->nasync" amd "brd->maxports" are the same.  They hold the number of
> filled out channels in the brd->channels[] array.  These tests should
> be ">=" instead of ">" so that we don't read one element past the end.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> index bfb0681..4eb12a9 100644
> --- a/drivers/tty/serial/jsm/jsm_cls.c
> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> @@ -570,7 +570,7 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
>  	 * verified in the interrupt routine.
>  	 */
> 
> -	if (port > brd->nasync)
> +	if (port >= brd->nasync)
>  		return;
> 
>  	ch = brd->channels[port];
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 7291c21..f413ef0 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c

Hi, Dan.

It looks like you missed the fix for neo_parse_isr.

Would you send a v2 fixing that as well?

Thanks.
Cascardo.

> @@ -840,7 +840,7 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
>  	if (!brd)
>  		return;
> 
> -	if (port > brd->maxports)
> +	if (port >= brd->maxports)
>  		return;
> 
>  	ch = brd->channels[port];
> @@ -1180,7 +1180,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
>  			 */
> 
>  			/* Verify the port is in range. */
> -			if (port > brd->nasync)
> +			if (port >= brd->nasync)
>  				continue;
> 
>  			ch = brd->channels[port];
> 

