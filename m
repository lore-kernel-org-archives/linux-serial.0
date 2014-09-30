From: Prasad Koya <prasad.koya@gmail.com>
Subject: process receive fifo while xmitting in 8250.
Date: Tue, 30 Sep 2014 10:30:20 -0700
Message-ID: <CAGXD9OeZ8n9oMXdTRVLVnz7kB=UEUvuCFjJszg81bRs+9E0fbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:57209 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaI3RaV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Sep 2014 13:30:21 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so1594230qac.40
        for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2014 10:30:20 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

Hi Ted

At 9600 baud, we are seeing buffer overruns on our 16550A UARTs. If a
command, say 40 chars long, is sent to console and if printk to
console happens at same time, we running into receive buffer overrun.
Thats because, at 9600 baud, it takes about a millisecond to xmit 1
char and with receive FIFO only 16 chars deep, it is very easy to
cause receive buffer overrun.

To get around that, I am trying below patch on 3.17 kernel. This is
tested and working on 3.4 kernel. I wanted to get some comments from
linux-serial mailing list.

If UART_IER_RDI is enabled, for every quarter of fifo size bytes sent,
console_write() checks to see if there is data in receive fifo. If so,
it lets serial8250_rx_chars() pick those bytes and buffer them in tty
layer.

Thank you.

--- linux-3.17rc6-orig/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
      2014-09-21 15:43:02.000000000 -0700
+++ linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c  2014-09-30
10:08:06.401242782 -0700
@@ -3004,6 +3004,7 @@
        unsigned long flags;
        unsigned int ier;
        int locked = 1;
+       int to_send, offset, fifo = count;

        touch_nmi_watchdog();

@@ -3022,8 +3023,27 @@
        else
                serial_port_out(port, UART_IER, 0);

-       uart_console_write(port, s, count, serial8250_console_putchar);
+       offset = 0;
+       if (uart_config[up->port.type].fcr & UART_FCR_ENABLE_FIFO) {
+               if (!oops_in_progress && ((ier & UART_IER_RDI) == UART_IER_RDI))
+                       fifo = port->fifosize >> 2;
+       }
+
+send_rest:
+       to_send = count > fifo ? fifo : count;

+       uart_console_write(port, s + offset, to_send,
serial8250_console_putchar);
+
+       count -= to_send;
+       if (count > 0) {
+               unsigned int status;
+               status = serial_in(up, UART_LSR);
+               if (status & (UART_LSR_DR | UART_LSR_BI))
+                       serial8250_rx_chars(up, status);
+                offset += to_send;
+               goto send_rest;
+       }
+
        /*
         *      Finally, wait for transmitter to become empty
         *      and restore the IER

On Wed, May 28, 2014 at 11:18 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, May 27, 2014 at 10:47:05PM -0700, Prasad Koya wrote:
>>
>> if char received is garbage then as you hinted it must be that
>> transmit ready interrupt that is not getting set.
>
> This was typo on my part.  What I meant to say was that it is the
> "receive ready interrupt" (not transmit) getting set when it shouldn't
> be.
>
> That is, the fact that DR bit was clear was indeed correct --- the
> receive FIFO really was empty, but for some reason some other part of
> the UART was convinced that it should be trying to trigger a receive
> interrupt, hence the value in IIR.
>
> In that case, if you force the DR bit to be set, then you'll be
> looping forever loading garbage into the tty flip buffer until it
> overflows.  This is why I said you should put in a counter that only
> does this workaround a limited number of times, and which point you
> send a printk of the saying "Buggy Intel UART, abandon all hope", and
> then submit a patch to the kernel cc'ing someone from Intel, in the
> hopes that they will fix the bug....
>
> Cheers,
>
>                                                 - Ted
