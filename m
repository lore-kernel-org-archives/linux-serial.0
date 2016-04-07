From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v1 08/12] serial: 8250: enable AFE on ports where FIFO is
 16 bytes
Date: Thu, 7 Apr 2016 16:43:40 -0700
Message-ID: <5706F0AC.2070901@hurleysoftware.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460061433-63750-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
> Intel Quark has 16550A compatible UART with autoflow feature enabled. It has
> only 16 bytes of FIFO. Currently serial8250_do_set_termios() prevents to enable
> autoflow since the minimum requirement of 32 bytes of FIFO size.
> 
> Decrease a FIFO size limitation to 16 bytes to allow autoflow control be
> enabled on such UARTs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e213da0..3f8121e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2522,9 +2522,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 * the trigger, or the MCR RTS bit is cleared.  In the case where
>  	 * the remote UART is not using CTS auto flow control, we must
>  	 * have sufficient FIFO entries for the latency of the remote
> -	 * UART to respond.  IOW, at least 32 bytes of FIFO.
> +	 * UART to respond.  IOW, at least 16 bytes of FIFO.
>  	 */
> -	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
> +	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 16) {

Let's just remove the fifosize test and rely on UART_CAP_AFE to enable
AFE.  Please remove comment from "In the case where ..."

Also, I think the PORT_A7 port type should have UART_CAP_AFE commented out,
especially since/if the trigger level is 1 byte.

Regards,
Peter Hurley

>  		up->mcr &= ~UART_MCR_AFE;
>  		if (termios->c_cflag & CRTSCTS)
>  			up->mcr |= UART_MCR_AFE;
> 
