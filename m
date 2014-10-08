From: Prasad Koya <prasad.koya@gmail.com>
Subject: Re: process receive fifo while xmitting in 8250.
Date: Tue, 7 Oct 2014 23:51:12 -0700
Message-ID: <CAGXD9Od8isNnzLa=-aBeGxU9C7sXbqUqfvTXUfOJsk=R=MMcLg@mail.gmail.com>
References: <CAGXD9OeZ8n9oMXdTRVLVnz7kB=UEUvuCFjJszg81bRs+9E0fbw@mail.gmail.com>
	<542E9D27.4000909@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:60447 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaJHGvN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2014 02:51:13 -0400
Received: by mail-qc0-f181.google.com with SMTP id r5so6991841qcx.40
        for <linux-serial@vger.kernel.org>; Tue, 07 Oct 2014 23:51:12 -0700 (PDT)
In-Reply-To: <542E9D27.4000909@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-serial@vger.kernel.org

Hi

Thanks for reviewing the patch Peter.

I have a new revision. 3.4 version of this is tested. I'm sending 3.17
based patch hoping to get some comments on the approach.

- Added a new variable 'drain_rx_at_tx' to 'struct uart_8250_port'.
This would be set to 1 inside serial8250_console_write() only if
port_sysrq is 0 and oops_in_progress is 0 and "receive interrupts" are
enabled.

- uart_console_write() is called to send out whole printk message as
earlier. As you suggested, I modified wait_for_xmitr() to invoke
serial8250_rx_chars() only if drain_rx_at_tx is set and if UART_LSR_DR
is set. so instead of waiting with usleep(1) it now buffers chars from
receive queue.

- if serial_8250_chars() is called with drain_rx_at_tx=1, I made it
read 8 chars from UART rx buffer. should this be higher or lower
number?

- as long as serial8250_rx_chars() does not see brk i.e., sysrq is not
set, it could buffer. if we split this functionality driver would have
to buffer each char and flags associated with it. with this approach,
serial8250_rx_chars() will buffer "regular" chars but anything after
sysrq is left to be processed after serial8250_console_write()
returns.

Thanks.

diff --git a/orig/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
b/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
index 1d42dba..b290834 100644
--- a/orig/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
+++ b/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
@@ -1349,7 +1349,7 @@ serial8250_rx_chars(struct uart_8250_port *up,
unsigned char lsr)
 {
        struct uart_port *port = &up->port;
        unsigned char ch;
-       int max_count = 256;
+       int max_count = up->drain_rx_at_tx ? 8 : 256;
        char flag;

        do {
@@ -1409,6 +1409,12 @@ serial8250_rx_chars(struct uart_8250_port *up,
unsigned char lsr)
                uart_insert_char(port, lsr, UART_LSR_OE, ch, flag);

 ignore_char:
+               /*
+                * We see BRK while buffering rx bytes. Stop buffering and
+                * let SysRq or SAK handling be done after console_write
+                */
+               if (port->sysrq && up->drain_rx_at_tx)
+                       break;
                lsr = serial_in(up, UART_LSR);
        } while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0));
        spin_unlock(&port->lock);
@@ -1864,7 +1870,13 @@ static void wait_for_xmitr(struct
uart_8250_port *up, int bits)
                        break;
                if (--tmout == 0)
                        break;
-               udelay(1);
+               /*
+                * We are writing to console and data is ready to be picked up
+                */
+               if (up->drain_rx_at_tx && (status & UART_LSR_DR))
+                       serial8250_rx_chars(up, status);
+               else
+                       udelay(1);
        }

        /* Wait up to 1s for flow control if necessary */
@@ -2913,6 +2925,7 @@ static void __init serial8250_isa_init_ports(void)
                init_timer(&up->timer);
                up->timer.function = serial8250_timeout;
                up->cur_iotype = 0xFF;
+               up->drain_rx_at_tx = 0;

                /*
                 * ALPHA_KLUDGE_MCR needs to be killed.
@@ -3022,8 +3035,15 @@ serial8250_console_write(struct console *co,
const char *s, unsigned int count)
        else
                serial_port_out(port, UART_IER, 0);

+       /* Is UART configured to send interrupts for received data */
+       if (((ier & UART_IER_RDI) == UART_IER_RDI) && !oops_in_progress &&
+                       !port->sysrq)
+               up->drain_rx_at_tx = 1;
+
        uart_console_write(port, s, count, serial8250_console_putchar);

+       if (up->drain_rx_at_tx)
+               up->drain_rx_at_tx = 0;
        /*
         *      Finally, wait for transmitter to become empty
         *      and restore the IER

diff --git a/orig/linux-3.17-rc6/include/linux/serial_8250.h
b/linux-3.17-rc6/include/linux/serial_8250.h
index f93649e..5d497b6 100644
--- a/orig/linux-3.17-rc6/include/linux/serial_8250.h
+++ b/linux-3.17-rc6/include/linux/serial_8250.h
@@ -95,6 +95,8 @@ struct uart_8250_port {
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
        unsigned char           msr_saved_flags;

+       unsigned char           drain_rx_at_tx;
+
        struct uart_8250_dma    *dma;

        /* 8250 specific callbacks */

On Fri, Oct 3, 2014 at 5:57 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Prasad,
>
> On 09/30/2014 01:30 PM, Prasad Koya wrote:
>> Hi Ted
>>
>> At 9600 baud, we are seeing buffer overruns on our 16550A UARTs. If a
>> command, say 40 chars long, is sent to console and if printk to
>> console happens at same time, we running into receive buffer overrun.
>> Thats because, at 9600 baud, it takes about a millisecond to xmit 1
>> char and with receive FIFO only 16 chars deep, it is very easy to
>> cause receive buffer overrun.
>>
>> To get around that, I am trying below patch on 3.17 kernel. This is
>> tested and working on 3.4 kernel. I wanted to get some comments from
>> linux-serial mailing list.
>>
>> If UART_IER_RDI is enabled, for every quarter of fifo size bytes sent,
>> console_write() checks to see if there is data in receive fifo. If so,
>> it lets serial8250_rx_chars() pick those bytes and buffer them in tty
>> layer.
>
> The issue here occurs irrespective of whether a UART has a FIFO; it's
> even easier to get an overrun without a FIFO.
>
>> --- linux-3.17rc6-orig/linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c
>>       2014-09-21 15:43:02.000000000 -0700
>> +++ linux-3.17-rc6/drivers/tty/serial/8250/8250_core.c  2014-09-30
>> 10:08:06.401242782 -0700
>> @@ -3004,6 +3004,7 @@
>>         unsigned long flags;
>>         unsigned int ier;
>>         int locked = 1;
>> +       int to_send, offset, fifo = count;
>>
>>         touch_nmi_watchdog();
>>
>> @@ -3022,8 +3023,27 @@
>>         else
>>                 serial_port_out(port, UART_IER, 0);
>>
>> -       uart_console_write(port, s, count, serial8250_console_putchar);
>> +       offset = 0;
>> +       if (uart_config[up->port.type].fcr & UART_FCR_ENABLE_FIFO) {
>> +               if (!oops_in_progress && ((ier & UART_IER_RDI) == UART_IER_RDI))
>> +                       fifo = port->fifosize >> 2;
>> +       }
>> +
>> +send_rest:
>> +       to_send = count > fifo ? fifo : count;
>>
>> +       uart_console_write(port, s + offset, to_send,
>> serial8250_console_putchar);
>> +
>> +       count -= to_send;
>> +       if (count > 0) {
>> +               unsigned int status;
>> +               status = serial_in(up, UART_LSR);
>> +               if (status & (UART_LSR_DR | UART_LSR_BI))
>> +                       serial8250_rx_chars(up, status);
>
> This will potentially take up to 256 chars in a loop, all with interrupts
> still off, and then drops the port lock which isn't ok in the context of
> a console message (with the way the driver works now).
>
> serial8250_rx_chars() doesn't need to drop the port lock anymore; so that
> solves that problem.
>
> Also, serial8250_rx_chars() is where sysrq and SAK handling is done;
> this would allow it to be re-entered, which would be bad. So rx cannot/
> should not be happening if either oops_in_progress or port->sysrq is true.
>
> I think a better way to do this would be to train wait_for_xmitr() to
> receive data to a temp buffer (if bits is set to the requisite LSR bits and
> not if oops_in_progress or port->sysrq). serial8250_rx_chars() would
> need refactoring to split out the per-char handling so it could work on
> the temp buffer once the console message was written.
>
> Regards,
> Peter Hurley
>
