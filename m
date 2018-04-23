From: Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Date: Mon, 23 Apr 2018 14:21:53 +0100
Message-ID: <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: stable <stable@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Douglas Anderson <dianders@chromium.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

Hi Michal

On 23/04/18 10:18, Michal Simek wrote:
> device->baud is always non zero value because it is checked already in
> early_serial8250_setup() before init_port is called.

True, currently init_port is only called from the one location and so 
the test is a little redundant, though I don't see the harm in testing 
both inputs to the divisor calculation immediately before use such that 
any future call path avoids setting a bad divisor.

> 
> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid clk & baud")
> Cc: stable <stable@vger.kernel.org>

Even if the test is dropped going forward, I wouldn't consider it's 
presence a "bug" such that a fix needs to be backported.

Thanks,
Matt

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   drivers/tty/serial/8250/8250_early.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index ae6a256524d8..5cd8c36c8fcc 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -122,7 +122,7 @@ static void __init init_port(struct earlycon_device *device)
>   	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
>   	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
>   
> -	if (port->uartclk && device->baud) {
> +	if (port->uartclk) {
>   		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
>   		c = serial8250_early_in(port, UART_LCR);
>   		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
> 
