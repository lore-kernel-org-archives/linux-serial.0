From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: earlycon requires console support
Date: Sat, 11 Apr 2015 09:39:43 -0400
Message-ID: <5529241F.2040308@hurleysoftware.com>
References: <5009638.HyplLv73fU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5009638.HyplLv73fU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, tfiga@google.com, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On 04/10/2015 06:01 PM, Arnd Bergmann wrote:
> A configuration that enables earlycon but not the core console
> code causes a link error:
> 
> drivers/built-in.o: In function `setup_earlycon':
> drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'
> 
> That error can be triggered by the newly added samsung earlycon support,
> which is missing a 'select' statement. This patch adds the 'select'
> to make serial-samsung behave like the other drivers.

Since Kconfig has a separate option for enabling console on Samsung,
I'd rather move uart_parse_earlycon() and enclose it in

#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
...
#endif

I'll send a fix for that right now.

Regards,
Peter Hurley

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b94ba0328d3b3 ("serial: samsung: Add support for early console")
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f8120c1bde14..5cd8f38a36de 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -241,6 +241,7 @@ config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
>  	depends on PLAT_SAMSUNG || ARCH_EXYNOS
>  	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
