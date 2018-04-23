From: Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk
 initialization in of_setup_earlycon
Date: Mon, 23 Apr 2018 14:16:50 +0100
Message-ID: <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
References: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org



On 23/04/18 10:27, Michal Simek wrote:
> There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
> systems.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> It looks like from history that portclk = BASE_BAUD * 16 was setup to
> get on calculation on x86 (divisor = 1) but it shouldn't be needed on DT based
> system. That's why I think that there is no DT based system which really
> requires this line.

Hi Michal,

This is fine for the MIPS generic platform (tested on Boston board) 
which was broken by some earlycon changes a few versions ago. Also 
tested on a MIPS pistachio board. As long as the bootloader has 
configured the uart divisor, earlycon should work as long as my patch 
"serial: 8250_early: Only set divisor if valid clk & baud" is applied to 
avoid a bad divisor getting calculated.

Tested-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> ---
>   drivers/tty/serial/earlycon.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a24278380fec..c12b1edcdd8e 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -244,7 +244,6 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
>   		return -ENXIO;
>   	}
>   	port->mapbase = addr;
> -	port->uartclk = BASE_BAUD * 16;
>   
>   	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
>   	if (val)
> 
