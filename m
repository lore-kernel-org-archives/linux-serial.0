From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] tty: serial: samsung: Increase maximum baudrate
Date: Fri, 21 Dec 2018 10:15:53 +0000
Message-ID: <20181221101553.GI13248@dell>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
 <20181214113410.22848-4-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214113410.22848-4-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 14 Dec 2018, Marek Szyprowski wrote:

> From: Seung-Woo Kim <sw0312.kim@samsung.com>
> 
> This driver can be used to communicate with Bluetooth chip in high-speed
> UART mode, so increase the maximum baudrate to 3Mbps.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> [mszyprow: rephrased commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 2a49b6d876b8..9fc3559f80d9 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  	 * Ask the core to calculate the divisor for us.
>  	 */
>  
> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
> +	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);

Does that mean the low speed devices will stop working?  It looks like
this should be dynamically configurable based on what device is
connected to it, no?

>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>  		quot = port->custom_divisor;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
