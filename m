From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: pl010 is no longer broken
Date: Wed, 25 Feb 2015 08:02:16 -0800
Message-ID: <20150225160216.GB29781@kroah.com>
References: <3118156.gAoOHDhYSV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3118156.gAoOHDhYSV@wuerfel>
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 04:06:09PM +0100, Arnd Bergmann wrote:
> As more ARM platforms are moving into ARCH_MULTIPLATFORM, we can now
> have integrator and versatile in the same kernel, and first one selects
> this driver, causing a Kconfig warning:
> 
> warning: (ARCH_INTEGRATOR_AP) selects SERIAL_AMBA_PL010 which has unmet direct dependencies (TTY && HAS_IOMEM && ARM_AMBA && (BROKEN || !ARCH_VERSATILE))
> 
> It turns out that it has not been broken on versatile for a long time,
> so we can remove the statement here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index d2501f01cd03..bbb12794cc8c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -20,7 +20,7 @@ comment "Non-8250 serial port support"
>  
>  config SERIAL_AMBA_PL010
>  	tristate "ARM AMBA PL010 serial port support"
> -	depends on ARM_AMBA && (BROKEN || !ARCH_VERSATILE)
> +	depends on ARM_AMBA
>  	select SERIAL_CORE
>  	help
>  	  This selects the ARM(R) AMBA(R) PrimeCell PL010 UART.  If you have
> 

Is it ok if we wait for 4.1-rc1 for this, or do you think it's really ok
for 4.0-final?

thanks,

greg k-h
