From: Johan Hovold <johan@kernel.org>
Subject: Re: [BACKPORT 4.14.y v2 6/6] serial: sprd: Modify the baud rate
 calculation formula
Date: Thu, 5 Sep 2019 11:01:30 +0200
Message-ID: <20190905090130.GF1701@localhost>
References: <cover.1567649728.git.baolin.wang@linaro.org>
 <4fe6ec82960301126b9f4be52dd6083c30e17420.1567649729.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4fe6ec82960301126b9f4be52dd6083c30e17420.1567649729.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, arnd@arndb.de, orsonzhai@gmail.com, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 05, 2019 at 11:11:26AM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> [Upstream commit 5b9cea15a3de5d65000d49f626b71b00d42a0577]
> 
> When the source clock is not divisible by the expected baud rate and
> the remainder is not less than half of the expected baud rate, the old
> formular will round up the frequency division coefficient. This will
> make the actual baud rate less than the expected value and can not meet
> the external transmission requirements.
> 
> Thus this patch modifies the baud rate calculation formula to support
> the serial controller output the maximum baud rate.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/tty/serial/sprd_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index e902494..72e96ab8 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -380,7 +380,7 @@ static void sprd_set_termios(struct uart_port *port,
>  	/* ask the core to calculate the divisor for us */
>  	baud = uart_get_baud_rate(port, termios, old, 0, SPRD_BAUD_IO_LIMIT);
>  
> -	quot = (unsigned int)((port->uartclk + baud / 2) / baud);
> +	quot = port->uartclk / baud;

Are you sure the original patch is even correct?

By replacing the divisor rounding with truncation you are introducing
larger errors for some baud rates, something which could possibly even
break working systems.

Perhaps the original patch should even be reverted, but in any case
backporting this to stable looks questionable.

>  
>  	/* set data length */
>  	switch (termios->c_cflag & CSIZE) {

Johan
