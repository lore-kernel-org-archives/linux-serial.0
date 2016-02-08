From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m
Date: Mon, 8 Feb 2016 11:45:44 -0500
Message-ID: <20160208164543.GY23093@windriver.com>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
 <1454935947-2743255-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1454935947-2743255-2-git-send-email-arnd@arndb.de>
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
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

[[PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m] On 08/02/2016 (Mon 13:51) Arnd Bergmann wrote:

> The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
> 
> drivers/tty/built-in.o: In function `ingenic_uart_probe':
> 8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'
> 
> This changes the symbol to a 'tristate', plus a dependency on

Note that Greg just queued a patch yesterday (but sent in 2015) that
removed what was the dead modular code.

It could also depend on SERIAL_8250=y to resolve the build issue you
found, if nobody cares about having modular SOC console UART drivers.

Either way, I don't have issue with it being tristate vs bool, but if
you do go with tristate, then my patch will have to be dropped/reverted.

Paul.
--

> SERIAL_8250, which makes it work again. Unlike the other
> soc-specific backends, this one has no dependency on an
> architecture or a platform. I'm adding a dependency on
> MIPS || COMPILE_TEST as well here, to avoid showing the driver
> on architectures that are not interested in it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 6ae0fae4f796..13c63b14179f 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -384,8 +384,8 @@ config SERIAL_8250_UNIPHIER
>  	  serial ports, say Y to this option. If unsure, say N.
>  
>  config SERIAL_8250_INGENIC
> -	bool "Support for Ingenic SoC serial ports"
> -	depends on OF_FLATTREE
> +	tristate "Support for Ingenic SoC serial ports"
> +	depends on SERIAL_8250 && OF_FLATTREE && (MIPS || COMPILE_TEST)
>  	select LIBFDT
>  	help
>  	  If you have a system using an Ingenic SoC and wish to make use of
> -- 
> 2.7.0
> 
