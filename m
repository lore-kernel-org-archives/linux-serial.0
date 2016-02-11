From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2 5/6] serial: 8250/mediatek: fix building with
 SERIAL_8250=m
Date: Thu, 11 Feb 2016 11:04:38 -0500
Message-ID: <20160211160438.GH28452@windriver.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1455205297-1021302-6-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

[[PATCH v2 5/6] serial: 8250/mediatek: fix building with SERIAL_8250=m] On 11/02/2016 (Thu 16:41) Arnd Bergmann wrote:

> The Mediatek 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
> 
> drivers/tty/built-in.o: In function `mtk8250_set_termios':
> :(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
> :(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
> :(.text+0x1c09c): undefined reference to `uart_get_divisor'
> drivers/tty/built-in.o: In function `mtk8250_do_pm':
> :(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
> drivers/tty/built-in.o: In function `mtk8250_probe':
> :(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
> serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
> serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]
> 
> This changes the symbol to a 'tristate', so the dependency on
> SERIAL_8250 also works when that is set to 'm'.
> To actually build the driver, we also need to include <linux/module.h>.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 3 ++-
>  drivers/tty/serial/8250/Kconfig    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 6ecc6e3e82dc..55be90c1d85e 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/module.h>

Something isn't right here ; I can see module.h three lines up in the
context.  Guessing your addition of the revert makes this addition no
longer required...

P.
--

>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
> @@ -303,7 +304,7 @@ static struct platform_driver mtk8250_platform_driver = {
>  };
>  module_platform_driver(mtk8250_platform_driver);
>  
> -#ifdef CONFIG_SERIAL_8250_CONSOLE
> +#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
>  static int __init early_mtk8250_setup(struct earlycon_device *device,
>  					const char *options)
>  {
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 67ad6b0d595b..6ae0fae4f796 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -370,7 +370,7 @@ config SERIAL_8250_LPC18XX
>  	  serial port, say Y to this option. If unsure, say Y.
>  
>  config SERIAL_8250_MT6577
> -	bool "Mediatek serial port support"
> +	tristate "Mediatek serial port support"
>  	depends on SERIAL_8250 && ARCH_MEDIATEK
>  	help
>  	  If you have a Mediatek based board and want to use the
> -- 
> 2.7.0
> 
