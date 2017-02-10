From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] atmel_serial: Use the fractional divider when possible
Date: Fri, 10 Feb 2017 16:49:21 +0100
Message-ID: <20170210154921.5gnlbhrjhk7yeke7@rfolt0960.corp.atmel.com>
References: <20170210152446.12674-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170210152446.12674-1-romain.izard.pro@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 10, 2017 at 04:24:46PM +0100, Romain Izard wrote:
> The fractional baud rate generator is available when using the
> asynchronous mode of Atmel USART controllers. It makes it possible to
> use higher baudrates, in exchange for a less precise clock with a
> variable duty cycle.
> 
> The existing code restricts its use to the normal mode of the USART
> controller, following the recommendation from the datasheet for the
> first chip embedding this type of controller. This recommendation has
> been removed from the documentation for the newer chips. After
> verification, all revisions of this controller should be able to use the
> fractional baud rate generator with the different asynchronous modes.
> 
> Removing the condition on ATMEL_US_USMODE makes it possible to get
> correct baudrates at high speed in more cases.
> 
> This was tested with a board using an Atmel SAMA5D2 chip and a TI
> WL1831 WiFi/Bluetooth combo chip at 3 Mbauds, with hardware flow control
> enabled.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/tty/serial/atmel_serial.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index fabbe76203bb..6684456dca9e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1758,7 +1758,9 @@ static void atmel_get_ip_name(struct uart_port *port)
>  
>  	/*
>  	 * Only USART devices from at91sam9260 SOC implement fractional
> -	 * baudrate.
> +	 * baudrate. It is available for all asynchronous modes, with the
> +	 * following restriction: the sampling clock's duty cycle is not
> +	 * constant.
>  	 */
>  	atmel_port->has_frac_baudrate = false;
>  	atmel_port->has_hw_timer = false;
> @@ -2202,8 +2204,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 * then
>  	 * 8 CD + FP = selected clock / (2 * baudrate)
>  	 */
> -	if (atmel_port->has_frac_baudrate &&
> -	    (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
> +	if (atmel_port->has_frac_baudrate) {
>  		div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
>  		cd = div >> 3;
>  		fp = div & ATMEL_US_FP_MASK;
> -- 
> 2.9.3
> 
