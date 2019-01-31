From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH] serial: mps2-uart: Add parentheses around conditional in
 mps2_uart_shutdown
Date: Thu, 31 Jan 2019 18:11:40 +0000
Message-ID: <6ae1916a-c18f-d2f2-705a-549c4468f81e@arm.com>
References: <20190131180627.19944-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131180627.19944-1-natechancellor@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-serial@vger.kernel.org

On 1/31/19 6:06 PM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
> applied to the left hand side of this bitwise operator
> [-Wlogical-not-parentheses]
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^                ~
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
> '!' to evaluate the bitwise operator first
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>              (                                       )
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
> hand side expression to silence this warning
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>             (               )
> 1 warning generated.
> 
> As it was intended for this check to be the inverse of the one at the
> bottom of mps2_init_port, add parentheses around the whole conditional.
> 
> Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/serial/mps2-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 4404eb7d118f..587b42f754cb 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
>  
>  	mps2_uart_write8(port, control, UARTn_CTRL);
>  
> -	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
> +	if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
>  		free_irq(mps_port->rx_irq, mps_port);
>  		free_irq(mps_port->tx_irq, mps_port);
>  	}
> 

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
