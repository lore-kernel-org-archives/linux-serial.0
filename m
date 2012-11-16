From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
Date: Fri, 16 Nov 2012 10:53:52 +0100
Message-ID: <20121116095352.GF4398@game.jcrosoft.org>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Victor <avictor.za@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 10:36 Fri 21 Sep     , Russell King wrote:
> The definitions provided by serial_at91.h are only used by the
> atmel_serial driver, and the function that uses it is never called
> from anywhere in the kernel.  Therefore, these definitions are unused
> and/or obsolete, and can be removed.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
personnaly I'm ok with it too
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

but Andrew seems use it so let him reply

Best Regards,
J.
> ---
>  arch/arm/include/asm/mach/serial_at91.h   |   33 -----------------------------
>  arch/avr32/include/asm/mach/serial_at91.h |   33 -----------------------------
>  drivers/tty/serial/atmel_serial.c         |   18 ---------------
>  3 files changed, 0 insertions(+), 84 deletions(-)
>  delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
>  delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h
> 
> diff --git a/arch/arm/include/asm/mach/serial_at91.h b/arch/arm/include/asm/mach/serial_at91.h
> deleted file mode 100644
> index ea6d063..0000000
> --- a/arch/arm/include/asm/mach/serial_at91.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - *  arch/arm/include/asm/mach/serial_at91.h
> - *
> - *  Based on serial_sa1100.h  by Nicolas Pitre
> - *
> - *  Copyright (C) 2002 ATMEL Rousset
> - *
> - *  Low level machine dependent UART functions.
> - */
> -
> -struct uart_port;
> -
> -/*
> - * This is a temporary structure for registering these
> - * functions; it is intended to be discarded after boot.
> - */
> -struct atmel_port_fns {
> -	void	(*set_mctrl)(struct uart_port *, u_int);
> -	u_int	(*get_mctrl)(struct uart_port *);
> -	void	(*enable_ms)(struct uart_port *);
> -	void	(*pm)(struct uart_port *, u_int, u_int);
> -	int	(*set_wake)(struct uart_port *, u_int);
> -	int	(*open)(struct uart_port *);
> -	void	(*close)(struct uart_port *);
> -};
> -
> -#if defined(CONFIG_SERIAL_ATMEL)
> -void atmel_register_uart_fns(struct atmel_port_fns *fns);
> -#else
> -#define atmel_register_uart_fns(fns) do { } while (0)
> -#endif
> -
> -
> diff --git a/arch/avr32/include/asm/mach/serial_at91.h b/arch/avr32/include/asm/mach/serial_at91.h
> deleted file mode 100644
> index 55b317a..0000000
> --- a/arch/avr32/include/asm/mach/serial_at91.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - *  linux/include/asm-arm/mach/serial_at91.h
> - *
> - *  Based on serial_sa1100.h  by Nicolas Pitre
> - *
> - *  Copyright (C) 2002 ATMEL Rousset
> - *
> - *  Low level machine dependent UART functions.
> - */
> -
> -struct uart_port;
> -
> -/*
> - * This is a temporary structure for registering these
> - * functions; it is intended to be discarded after boot.
> - */
> -struct atmel_port_fns {
> -	void	(*set_mctrl)(struct uart_port *, u_int);
> -	u_int	(*get_mctrl)(struct uart_port *);
> -	void	(*enable_ms)(struct uart_port *);
> -	void	(*pm)(struct uart_port *, u_int, u_int);
> -	int	(*set_wake)(struct uart_port *, u_int);
> -	int	(*open)(struct uart_port *);
> -	void	(*close)(struct uart_port *);
> -};
> -
> -#if defined(CONFIG_SERIAL_ATMEL)
> -void atmel_register_uart_fns(struct atmel_port_fns *fns);
> -#else
> -#define atmel_register_uart_fns(fns) do { } while (0)
> -#endif
> -
> -
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 3d7e1ee..a6134c9 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -43,7 +43,6 @@
>  #include <asm/io.h>
>  #include <asm/ioctls.h>
>  
> -#include <asm/mach/serial_at91.h>
>  #include <mach/board.h>
>  
>  #ifdef CONFIG_ARM
> @@ -1513,23 +1512,6 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
>  	}
>  }
>  
> -/*
> - * Register board-specific modem-control line handlers.
> - */
> -void __init atmel_register_uart_fns(struct atmel_port_fns *fns)
> -{
> -	if (fns->enable_ms)
> -		atmel_pops.enable_ms = fns->enable_ms;
> -	if (fns->get_mctrl)
> -		atmel_pops.get_mctrl = fns->get_mctrl;
> -	if (fns->set_mctrl)
> -		atmel_pops.set_mctrl = fns->set_mctrl;
> -	atmel_open_hook		= fns->open;
> -	atmel_close_hook	= fns->close;
> -	atmel_pops.pm		= fns->pm;
> -	atmel_pops.set_wake	= fns->set_wake;
> -}
> -
>  struct platform_device *atmel_default_console_device;	/* the serial console device */
>  
>  #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
