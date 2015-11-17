From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/6] serial: fsl-lpuart: move SERIAL_EARLYCON dependency
 to console
Date: Mon, 16 Nov 2015 16:29:06 -0800
Message-ID: <8865948bb89ad128dae91aca9437c581@agner.ch>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
 <1447688894-2936779-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447688894-2936779-3-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

FWIW,

Acked-by: Stefan Agner <stefan@agner.ch>

On 2015-11-16 07:48, Arnd Bergmann wrote:
> The newly added earlycon support for lpuart adds a
> 'select SERIAL_EARLYCON' statement for the tty driver, but that
> only uses earlycon when console support is present, and otherwise
> results in a pointless build error:
> 
> drivers/built-in.o: In function `setup_earlycon':
> :(.init.text+0x2c4c): undefined reference to `uart_parse_earlycon'
> 
> This changes the Kconfig statement to only select the earlycon
> code if the console is also enabled, like all the other drivers
> do already.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1d59b382f1c4 ("serial: fsl_lpuart: add earlycon support")
> Cc: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 1aec4404062d..dbb8ac6afd40 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1539,13 +1539,13 @@ config SERIAL_FSL_LPUART
>  	tristate "Freescale lpuart serial port support"
>  	depends on HAS_DMA
>  	select SERIAL_CORE
> -	select SERIAL_EARLYCON
>  	help
>  	  Support for the on-chip lpuart on some Freescale SOCs.
>  
>  config SERIAL_FSL_LPUART_CONSOLE
>  	bool "Console on Freescale lpuart serial port"
>  	depends on SERIAL_FSL_LPUART=y
> +	select SERIAL_EARLYCON
>  	select SERIAL_CORE_CONSOLE
>  	help
>  	  If you have enabled the lpuart serial port on the Freescale SoCs,
