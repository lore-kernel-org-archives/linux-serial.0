From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v4.13 REGRESSION] Revert "serial: Delete dead code for CIR
 serial ports"
Date: Tue, 1 Aug 2017 17:55:57 +0200
Message-ID: <c599065a-60f5-070e-c1e3-12b3ab2cbf0a@suse.com>
References: <20170801112417.fljtelqzfzusgkzm@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801112417.fljtelqzfzusgkzm@gofer.mess.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 08/01/2017 01:24 PM, Sean Young wrote:
> This reverts commit 1104321a7b3bb670dc614ffa7958c553e7b3b836.
> 
> The code is not dead at all and breaks winbond-cir.
> 
> Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a CIR port
> lirc lirc0: lirc_dev: driver ir-lirc-codec (winbond-cir) registered at minor = 0
> winbond-cir 00:03: Region 0x2f8-0x2ff already in use!
> winbond-cir: probe of 00:03 failed with error -16
> 

You are right, uart->port.type gets overwritten, so it is definitely not dead 
code. That was an oversight from me, sorry for the inconvenience.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/tty/serial/8250/8250_core.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index b5def356af63..1aab3010fbfa 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1043,13 +1043,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>   		if (up->dl_write)
>   			uart->dl_write = up->dl_write;
>   
> -		if (serial8250_isa_config != NULL)
> -			serial8250_isa_config(0, &uart->port,
> -					&uart->capabilities);
> +		if (uart->port.type != PORT_8250_CIR) {
> +			if (serial8250_isa_config != NULL)
> +				serial8250_isa_config(0, &uart->port,
> +						&uart->capabilities);
> +
> +			ret = uart_add_one_port(&serial8250_reg,
> +						&uart->port);
> +			if (ret == 0)
> +				ret = uart->port.line;
> +		} else {
> +			dev_info(uart->port.dev,
> +				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> +				uart->port.iobase,
> +				(unsigned long long)uart->port.mapbase,
> +				uart->port.irq);
>   
> -		ret = uart_add_one_port(&serial8250_reg, &uart->port);
> -		if (ret == 0)
> -			ret = uart->port.line;
> +			ret = 0;
> +		}
>   	}
>   	mutex_unlock(&serial_mutex);
>   
> 
