From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: core: prevent softlockups on slow consoles
Date: Thu, 3 Sep 2015 21:20:39 -0700
Message-ID: <20150904042039.GA3719@kroah.com>
References: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 31, 2015 at 04:34:16PM +0200, Vitaly Kuznetsov wrote:
> Hyper-V serial port is very slow on multi-vCPU guest, this causes
> soflockups on intensive console writes. Touch nmi watchdog after putting
> every char on port to avoid the issue for all serial drivers, the overhead
> should be small.
> 
> This is just a part of the fix: serial8250_console_write() disables irqs
> for all its execution time (which on such slow consoles can be dozens of
> seconds), it should be possible to observe devices being stuck on this
> CPU. We need to find a better way, e.g. do output in batches enabling irqs
> in between.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/tty/serial/serial_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f368520..cc05785 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -33,7 +33,7 @@
>  #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
>  #include <linux/serial_core.h>
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
> +#include <linux/nmi.h>
>  
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> @@ -1792,6 +1792,7 @@ void uart_console_write(struct uart_port *port, const char *s,
>  		if (*s == '\n')
>  			putchar(port, '\r');
>  		putchar(port, *s);
> +		touch_nmi_watchdog();

I don't like this, please narrow this down to the real problem that your
hardware has here, the putchar function should not be this slow.  If it
is, something is wrong.

greg k-h
