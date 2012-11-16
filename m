From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
Date: Fri, 16 Nov 2012 23:08:47 +0100
Message-ID: <CAGhQ9VzYc8qqvZxU=AB+NHa4nGKJFxPYR7grc8Ssn-kP1bfq3w@mail.gmail.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
	<E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54952 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab2KPWIt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 17:08:49 -0500
In-Reply-To: <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alan Cox <alan@linux.intel.com>

Hi Russell,

I made a similar patch a while ago. One note below.
(http://marc.info/?l=linux-arm-kernel&m=133372829203680)

On 21 September 2012 11:36, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The definitions provided by serial_at91.h are only used by the
> atmel_serial driver, and the function that uses it is never called
> from anywhere in the kernel.  Therefore, these definitions are unused
> and/or obsolete, and can be removed.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/mach/serial_at91.h   |   33 -----------------------------
>  arch/avr32/include/asm/mach/serial_at91.h |   33 -----------------------------
>  drivers/tty/serial/atmel_serial.c         |   18 ---------------
>  3 files changed, 0 insertions(+), 84 deletions(-)
>  delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
>  delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h

<snip>

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
>         }
>  }
>
> -/*
> - * Register board-specific modem-control line handlers.
> - */
> -void __init atmel_register_uart_fns(struct atmel_port_fns *fns)
> -{
> -       if (fns->enable_ms)
> -               atmel_pops.enable_ms = fns->enable_ms;
> -       if (fns->get_mctrl)
> -               atmel_pops.get_mctrl = fns->get_mctrl;
> -       if (fns->set_mctrl)
> -               atmel_pops.set_mctrl = fns->set_mctrl;
> -       atmel_open_hook         = fns->open;
> -       atmel_close_hook        = fns->close;
> -       atmel_pops.pm           = fns->pm;
> -       atmel_pops.set_wake     = fns->set_wake;
> -}

When the atmel_open_hook/atmel_open_close assignment is dropped, these
global variables will be useless so we should remove them as well.
There are also some other code that uses the variables that can be
dropped. Should shave another 22 lines of code off atmel_serial.c

I can send out a patch on top of yours if you prefer that.

regards
Joachim Eastwood
