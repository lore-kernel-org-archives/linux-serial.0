From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: process receive fifo while xmitting in 8250.
Date: Fri, 03 Oct 2014 08:57:11 -0400
Message-ID: <542E9D27.4000909@hurleysoftware.com>
References: <CAGXD9OeZ8n9oMXdTRVLVnz7kB=UEUvuCFjJszg81bRs+9E0fbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:53016 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751554AbaJCM5O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Oct 2014 08:57:14 -0400
In-Reply-To: <CAGXD9OeZ8n9oMXdTRVLVnz7kB=UEUvuCFjJszg81bRs+9E0fbw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prasad Koya <prasad.koya@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

Hi Prasad,

On 09/30/2014 01:30 PM, Prasad Koya wrote:
> Hi Ted
> 
> At 9600 baud, we are seeing buffer overruns on our 16550A UARTs. If a
> command, say 40 chars long, is sent to console and if printk to
> console happens at same time, we running into receive buffer overrun.
> Thats because, at 9600 baud, it takes about a millisecond to xmit 1
> char and with receive FIFO only 16 chars deep, it is very easy to
> cause receive buffer overrun.
> 
> To get around that, I am trying below patch on 3.17 kernel. This is
> tested and working on 3.4 kernel. I wanted to get some comments from
> linux-serial mailing list.
> 
> If UART_IER_RDI is enabled, for every quarter of fifo size bytes sent,
> console_write() checks to see if there is data in receive fifo. If so,
> it lets serial8250_rx_chars() pick those bytes and buffer them in tty
> layer.

The issue here occurs irrespective of whether a UART has a FIFO; it's
even easier to get an overrun without a FIFO.

> --- linux-3.17rc6-orig/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
>       2014-09-21 15:43:02.000000000 -0700
> +++ linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c  2014-09-30
> 10:08:06.401242782 -0700
> @@ -3004,6 +3004,7 @@
>         unsigned long flags;
>         unsigned int ier;
>         int locked = 1;
> +       int to_send, offset, fifo = count;
> 
>         touch_nmi_watchdog();
> 
> @@ -3022,8 +3023,27 @@
>         else
>                 serial_port_out(port, UART_IER, 0);
> 
> -       uart_console_write(port, s, count, serial8250_console_putchar);
> +       offset = 0;
> +       if (uart_config[up->port.type].fcr & UART_FCR_ENABLE_FIFO) {
> +               if (!oops_in_progress && ((ier & UART_IER_RDI) == UART_IER_RDI))
> +                       fifo = port->fifosize >> 2;
> +       }
> +
> +send_rest:
> +       to_send = count > fifo ? fifo : count;
> 
> +       uart_console_write(port, s + offset, to_send,
> serial8250_console_putchar);
> +
> +       count -= to_send;
> +       if (count > 0) {
> +               unsigned int status;
> +               status = serial_in(up, UART_LSR);
> +               if (status & (UART_LSR_DR | UART_LSR_BI))
> +                       serial8250_rx_chars(up, status);

This will potentially take up to 256 chars in a loop, all with interrupts
still off, and then drops the port lock which isn't ok in the context of
a console message (with the way the driver works now).

serial8250_rx_chars() doesn't need to drop the port lock anymore; so that
solves that problem.

Also, serial8250_rx_chars() is where sysrq and SAK handling is done;
this would allow it to be re-entered, which would be bad. So rx cannot/
should not be happening if either oops_in_progress or port->sysrq is true.

I think a better way to do this would be to train wait_for_xmitr() to
receive data to a temp buffer (if bits is set to the requisite LSR bits and
not if oops_in_progress or port->sysrq). serial8250_rx_chars() would
need refactoring to split out the per-char handling so it could work on
the temp buffer once the console message was written.

Regards,
Peter Hurley

