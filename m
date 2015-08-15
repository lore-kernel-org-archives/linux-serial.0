From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial: 8250: Fix autoconfig_irq() to avoid race
 conditions
Date: Fri, 14 Aug 2015 17:10:39 -0700
Message-ID: <20150815001039.GA4885@kroah.com>
References: <1439165707-2082-1-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439165707-2082-1-git-send-email-t-kageyama@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 10, 2015 at 12:15:40AM +0000, Taichi Kageyama wrote:
> The following race conditions can happen when a serial port is used
> as console.
> 
> Case1: CPU_B is used to detect an interrupt from a serial port,
>        but it can have interrupts disabled during the waiting time.
> Case2: CPU_B clears UART_IER just after CPU_A sets UART_IER and then
>        a serial port may not make an interrupt.
> Case3: CPU_A sets UART_IER just after CPU_B clears UART_IER.
>        This is an unexpected behavior for serial8250_console_write().
> 
> CPU_A [autoconfig_irq]      |  CPU_B [serial8250_console_write]
> ----------------------------|---------------------------------------
>                             |
> probe_irq_on()              |  spin_lock_irqsave(&port->lock,)
> serial_outp(,UART_IER,0x0f) |  serial_out(,UART_IER,0)
> udelay(20);                 |  uart_console_write()
> probe_irq_off()             |
>                             |  spin_unlock_irqrestore(&port->lock,)
> 
> Case1 and 2 can make autoconfig_irq() failed.
> In these cases, the console doesn't work in interrupt mode and
> "input overrun" (which can make operation mistakes) can happen
> on some systems. Especially in the Case1, It is known that the
> problem happens with high rate every boot once it occurs
> because the boot sequence is always almost same.
> 
> port mutex makes sure that the autoconfig operation is exclusive of
> any other concurrent HW access except by the console operation.
> console lock is required in autoconfig_irq().
> 
> Signed-off-by: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git v4.2-rc4.org/drivers/tty/serial/8250/8250_core.c v4.2-rc4.work/drivers/tty/serial/8250/8250_core.c
> index 37fff12..ed1e23e 100644
> --- v4.2-rc4.org/drivers/tty/serial/8250/8250_core.c
> +++ v4.2-rc4.work/drivers/tty/serial/8250/8250_core.c
> @@ -1303,6 +1303,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  		inb_p(ICP);
>  	}
>  
> +	if (uart_console(port))
> +		console_lock();
> +
>  	/* forget possible initially masked and pending IRQ */
>  	probe_irq_off(probe_irq_on());
>  	save_mcr = serial_in(up, UART_MCR);
> @@ -1334,6 +1337,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	if (port->flags & UPF_FOURPORT)
>  		outb_p(save_ICP, ICP);
>  
> +	if (uart_console(port))
> +		console_unlock();
> +
>  	port->irq = (irq > 0) ? irq : 0;
>  }

This doesn't apply to my tty-next tree at all.  Can you please rebase it
and resend?

thanks,

greg k-h
