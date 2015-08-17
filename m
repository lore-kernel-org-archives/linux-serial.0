From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] serial: 8250: Fix autoconfig_irq() to avoid race
 conditions
Date: Mon, 17 Aug 2015 21:22:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508172122250.3873@nanos>
References: <1439779518-31560-1-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439779518-31560-1-git-send-email-t-kageyama@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 17 Aug 2015, Taichi Kageyama wrote:
> diff --git tty-next.org/drivers/tty/serial/8250/8250_port.c tty-next.work/drivers/tty/serial/8250/8250_port.c
> index 54e6c8d..9300b59 100644
> --- tty-next.org/drivers/tty/serial/8250/8250_port.c
> +++ tty-next.work/drivers/tty/serial/8250/8250_port.c
> @@ -1238,6 +1238,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  		inb_p(ICP);
>  	}
>  
> +	if (uart_console(port))
> +		console_lock();
> +
>  	/* forget possible initially masked and pending IRQ */
>  	probe_irq_off(probe_irq_on());
>  	save_mcr = serial_in(up, UART_MCR);
> @@ -1269,6 +1272,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	if (port->flags & UPF_FOURPORT)
>  		outb_p(save_ICP, ICP);
>  
> +	if (uart_console(port))
> +		console_unlock();
> +
>  	port->irq = (irq > 0) ? irq : 0;
>  }

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
