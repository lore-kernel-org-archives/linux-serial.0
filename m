From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [v4 2/2] serial: 8250_dw: dw8250_setup_port() use endianness
 aware read.
Date: Fri, 21 Aug 2015 10:41:07 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075CFB84B69@IN01WEMBXB.internal.synopsys.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1440153223-25712-1-git-send-email-noamc@ezchip.com>
 <1440153223-25712-2-git-send-email-noamc@ezchip.com>
 <1440153223-25712-3-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

Hi Noam,

On Friday 21 August 2015 04:05 PM, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
>
> readl() for UCV and CPR will not work for port type UPIO_MEM32BE.
> Instead we use the serial_in32() accessor which is initialized
> properly according to endianness.
>
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f479433..62f766a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -310,7 +310,8 @@ static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
>  static void dw8250_setup_port(struct uart_8250_port *up)
>  {
>  	struct uart_port	*p = &up->port;
> -	u32			reg = readl(p->membase + DW_UART_UCV);
> +	struct dw8250_data	*d = p->private_data;
> +	u32			reg = d->serial_in(p->membase + DW_UART_UCV);
>  
>  	/*
>  	 * If the Component Version Register returns zero, we know that
> @@ -322,7 +323,7 @@ static void dw8250_setup_port(struct uart_8250_port *up)
>  	dev_dbg_ratelimited(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> -	reg = readl(p->membase + DW_UART_CPR);
> +	reg = d->serial_in(p->membase + DW_UART_CPR);
>  	if (!reg)
>  		return;
>  

I think this can be folded into the previous patch - I don't see how this
logically seperates anything from patch 1/2

-Vineet
