From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty/8250_early: Prevent rounding error in uartclk to
 baud ratio
Date: Fri, 28 Sep 2012 15:01:28 +0200
Message-ID: <50659FA8.7020200@suse.cz>
References: <1348833784-31385-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348833784-31385-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: gregkh@suse.de, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com
List-Id: linux-serial@vger.kernel.org

On 09/28/2012 02:03 PM, Alexey Brodkin wrote:
> Modify divisor to select the nearest baud rate divider rather than the
> lowest. It minimizes baud rate errors especially on low UART clock
> frequencies.
> 
> For example, if uartclk is 33000000 and baud is 115200 the ratio is
> about 17.9 The current code selects 17 (5% error) but should select 18
> (0.5% error).
> 
> On the same lines as following:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/serial-pick-nearest-baud-rate-divider.patch
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>  drivers/tty/serial/8250_early.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250_early.c b/drivers/tty/serial/8250_early.c
> index eaafb98..cfc46b7 100644
> --- a/drivers/tty/serial/8250_early.c
> +++ b/drivers/tty/serial/8250_early.c
> @@ -140,7 +140,7 @@ static void __init init_port(struct early_serial8250_device *device)
>  	serial_out(port, UART_FCR, 0);		/* no fifo */
>  	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
>  
> -	divisor = port->uartclk / (16 * device->baud);
> +	divisor = (port->uartclk + (8 * device->baud)) / (16 *	device->baud);

So this should be in fact DIV_ROUND_CLOSEST(), right?

But anyway I'm missing any explanation of *why* this is needed? This
should be part of the commit log. Is there any bug you are fixing here?

thanks,
-- 
js
suse labs
