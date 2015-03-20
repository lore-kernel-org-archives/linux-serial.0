From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] serial: samsung: Clear operation mode on UART shutdown
Date: Fri, 20 Mar 2015 13:19:44 +0100
Message-ID: <550C1060.1040900@collabora.co.uk>
References: <1426246731-13751-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426246731-13751-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Robert Baldyga <r.baldyga@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On 03/13/2015 12:38 PM, Javier Martinez Canillas wrote:
> Exynos serial ports operate either in a DMA-based or interrupt-based
> modes. In DMA-based mode, the UART generates a transfer data request
> and a Transmission (Tx) interrupt in interrupt-based mode.
> 
> The Tx IRQ is only unmasked in interrupt-based mode and it was done
> in s3c24xx_serial_start_tx(). Commit ba019a3e2ad5 ("serial: samsung:
> remove redundant interrupt enabling") removed the IRQ enable on that
> function since it is enabled when the mode is set in enable_tx_pio().
> 
> The problem is that enable_tx_pio() is only called if the port mode
> has not been set before but the mode was not cleared on .shutdown().
> 
> So if the UART was shutdown and then started up again, the mode set
> will remain and the Tx IRQ won't be unmasked.
> 
> This caused a hang on at least Exynos5250, Exynos5420 and Exynos5800
> when the system is rebooted or powered off.
> 
> Fixes: ba019a3e2ad5 ("serial: samsung: remove redundant interrupt enabling")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> I noticed this issue on an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos
> 5800 Peach Pi Chromebooks. This patch fixes the issue on all of them.
> 
> The offending commit landed in v4.0-rc1 so this fix is -rc material.
> 
>  drivers/tty/serial/samsung.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index af821a908720..cf08876922f1 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -963,6 +963,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>  			free_irq(ourport->tx_irq, ourport);
>  		tx_enabled(port) = 0;
>  		ourport->tx_claimed = 0;
> +		ourport->tx_mode = 0;
>  	}
>  
>  	if (ourport->rx_claimed) {
> 

Any comments about this patch? 3.14-rc5 will most likely be released this weekend
so we are running out of time to fix this issue before 3.14 is released.

Best regards,
Javier
