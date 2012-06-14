From: Haojian Zhuang <hzhuang1@marvell.com>
Subject: RE: [PATCH V2] serial: pxa: add spin lock for console write
Date: Wed, 13 Jun 2012 20:14:20 -0700
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C060E55D5AF@SC-VEXCH1.marvell.com>
References: <1337661780-26446-1-git-send-email-chao.xie@marvell.com>,<20120612223515.GA14008@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:45324 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755058Ab2FNDVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Jun 2012 23:21:46 -0400
In-Reply-To: <20120612223515.GA14008@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Chao Xie <cxie4@marvell.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

V2 moves local_irq_save() after clk_prepare_enable().

The extra empty line is unnecessary.

Greg,

Would you apply this patch?

Regards
Haojian
________________________________________
From: Greg KH [gregkh@linuxfoundation.org]
Sent: Wednesday, June 13, 2012 6:35 AM
To: Chao Xie
Cc: linux-serial@vger.kernel.org; Haojian Zhuang
Subject: Re: [PATCH V2] serial: pxa: add spin lock for console write

On Tue, May 22, 2012 at 12:43:00PM +0800, Chao Xie wrote:
> at UP mode, when cpu want to print message in kernel, it will invoke
> peempt_disable and disable irq. So it is safe for UP mode.
> For SMP mode, it is not safe to protect the HW reigsters.
> one CPU will run a program which will invoke printf.
> another CPU will run a program in kernel that invoke printk.
> So when second CPU is trying to printk, it will do
> 1. save ier register
> 2. enable uue bit of ier register
> 3. push buffer to uart fifo
> 4 .restore ier register
> when first CPU want to printf, and it happens between 1 and 4, it will
> enable thre bit of ier, and waiting for transmit intterupt. while step 4
> will make the ier lost thre bit.
> add spin lock here to protect the ier register for console write.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

What is different from patch v1?

> ---
>  drivers/tty/serial/pxa.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 5847a4b..aca62f6 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -670,9 +670,19 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
>  {
>       struct uart_pxa_port *up = serial_pxa_ports[co->index];
>       unsigned int ier;
> +     unsigned long flags;
> +     int locked = 1;
>
>       clk_prepare_enable(up->clk);
>
> +     local_irq_save(flags);
> +     if (up->port.sysrq)
> +             locked = 0;
> +     else if (oops_in_progress)
> +             locked = spin_trylock(&up->port.lock);
> +     else
> +             spin_lock(&up->port.lock);
> +
>       /*
>        *      First save the IER then disable the interrupts
>        */
> @@ -688,7 +698,12 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
>       wait_for_xmitr(up);
>       serial_out(up, UART_IER, ier);
>
> +     if (locked)
> +             spin_unlock(&up->port.lock);
> +     local_irq_restore(flags);
> +
>       clk_disable_unprepare(up->clk);
> +
>  }

Why the extra line at the end of the function?

thanks,

greg k-h
