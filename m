From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with
 non-empty FIFO
Date: Thu, 14 Feb 2019 07:35:46 +0100
Message-ID: <d58d8b99-71ee-d9d4-7217-767cc09989ac@xilinx.com>
References: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Anssi Hannula <anssi.hannula@bitwise.fi>, Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>
List-Id: linux-serial@vger.kernel.org

+ Shubhrajyoti

On 06. 02. 19 15:08, Anssi Hannula wrote:
> If RX is disabled while there are still unprocessed bytes in RX FIFO,
> cdns_uart_handle_rx() called from interrupt handler will get stuck in
> the receive loop as read bytes will not get removed from the RX FIFO
> and CDNS_UART_SR_RXEMPTY bit will never get set.
> 
> Avoid the stuck handler by checking first if RX is disabled. port->lock
> protects against race with RX-disabling functions.
> 
> This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
> xuartps: Fix RX hang, and TX corruption in termios call") which fixed a
> similar issue in cdns_uart_set_termios().
> The behavior can also be easily verified by e.g. setting
> CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
> following loop will then get stuck.
> 
> Resetting the FIFO using RXRST would not set RXEMPTY either so simply
> issuing a reset after RX-disable would not work.
> 
> I observe this frequently on a ZynqMP board during heavy RX load at 1M
> baudrate when the reader process exits and thus RX gets disabled.
> 
> Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/xilinx_uartps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 094f2958cb2b..f0c4f59d9314 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -219,6 +219,13 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
>  
>  	is_rxbs_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
>  
> +	/*
> +	 * RXEMPTY will never be set if RX is disabled as read bytes
> +	 * will not be removed from the FIFO
> +	 */
> +	if (readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS)
> +		return;
> +
>  	while ((readl(port->membase + CDNS_UART_SR) &
>  		CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
>  		if (is_rxbs_support)
> 


Please review.
M
