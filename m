From: Christian Jann <christian.jann@ymail.com>
Subject: Re: Need some help with auart on imx23
Date: Tue, 10 Sep 2013 19:58:01 +0200
Message-ID: <1485573.VUJ6COcddm@thinkpad>
References: <3205717.NO7EKVN077@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm23-vm3.bullet.mail.ird.yahoo.com ([212.82.109.232]:38278 "EHLO
	nm23-vm3.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752971Ab3IJSE4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Sep 2013 14:04:56 -0400
In-Reply-To: <3205717.NO7EKVN077@thinkpad>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tuesday 10 September 2013 12:26:32 you wrote:
> Hi, I could really need some help to get the second application uart working
> on my imx23 based board.
> 
> I can use GDB to debug the kernel but I don't really know where to start,
> maybe something is broken in drivers/tty/serial/mxs-auart.c. Hopefully
> somebody could give me a hint what to do.
> 

OK, receiving works, below you can see that I've received "Hello" one char at 
a time.

> [chris@thinkpad linux-stable]$ arm-none-eabi-gdb vmlinux
> GNU gdb (GNU Tools for ARM Embedded Processors) 7.4.1.20130312-cvs
> Copyright (C) 2012 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "--host=i686-linux-gnu --target=arm-none-eabi".
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>...
> Reading symbols from
> /home/chris/local/OLinuXino/imx23-olinuxino/kernel/linux-stable/vmlinux...d
> one. (gdb) c
> The program is not being run.
> (gdb) target remote :3333
> Remote debugging using :3333
> ?? () at arch/arm/kernel/entry-armv.S:1132
> 1132            W(b)    vector_rst
> (gdb) c
> Continuing.
> WARNING! The target is already running. All changes GDB did to registers
> will be discarded! Waiting for target to halt. ^C
> Program received signal SIGINT, Interrupt.
> 0xc0814728 in start_kernel () at init/main.c:480
> 480       while(wait_for_debugger);
> (gdb) break mxs_auart_rx_char
> Function "mxs_auart_rx_char" not defined.
> Make breakpoint pending on future shared library load? (y or [n]) n
> (gdb) break drivers/tty/serial/mxs-auart.c:mxs_auart_rx_char
> Function "mxs_auart_rx_char" not defined in
> "drivers/tty/serial/mxs-auart.c".
> Make breakpoint pending on future shared library load? (y or [n]) n
> (gdb) break drivers/tty/serial/mxs-auart.c:703
> Breakpoint 1 at 0xc02d7be0: file drivers/tty/serial/mxs-auart.c, line 703.
> (gdb) set var wait_for_debugger=0
> (gdb) c
> Continuing.
> 
> Breakpoint 1, mxs_auart_irq_handle (irq=<optimized out>, context=0xc3a27a00)
> at drivers/tty/serial/mxs-auart.c:704 704                     istat &=
> ~(AUART_INTR_RTIS | AUART_INTR_RXIS); (gdb) s
> 707             if (istat & AUART_INTR_TXIS) {
> (gdb) s
> 708                     mxs_auart_tx_chars(s);
> (gdb) s
> mxs_auart_tx_chars (s=s@entry=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:249 249             if
> (auart_dma_enabled(s)) {
> (gdb) s
> auart_dma_enabled (s=<optimized out>) at drivers/tty/serial/mxs-auart.c:184
> 184             return s->flags & MXS_AUART_DMA_ENABLED;
> (gdb) s
> mxs_auart_tx_chars (s=s@entry=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:246 246     {
> (gdb) delete breakpoints 1
> (gdb) break drivers/tty/serial/mxs-auart.c:320
> Breakpoint 2 at 0xc02d7c4c: file drivers/tty/serial/mxs-auart.c, line 320.
> (gdb) c
> Continuing.
> 
> Breakpoint 2, mxs_auart_rx_chars (s=<optimized out>) at
> drivers/tty/serial/mxs-auart.c:367 367                    
> mxs_auart_rx_char(s);
> (gdb) delete breakpoints
> Delete all breakpoints? (y or n) y
> (gdb) break drivers/tty/serial/mxs-auart.c:321
> Breakpoint 3 at 0xc02d7c54: file drivers/tty/serial/mxs-auart.c, line 321.
> (gdb) c
> Continuing.
> 
> Breakpoint 3, mxs_auart_rx_char (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:321 321             stat =
> readl(s->port.membase + AUART_STAT);
> (gdb) list
> 316             int flag;
> 317             u32 stat;
> 318             u8 c;
> 319
> 320             c = readl(s->port.membase + AUART_DATA);
> 321             stat = readl(s->port.membase + AUART_STAT);
> 322
> 323             flag = TTY_NORMAL;
> 324             s->port.icount.rx++;
> 325
> (gdb) p c
> $3 = 72 'H'
> (gdb) c
> Continuing.
> 
> Breakpoint 3, mxs_auart_rx_char (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:321 321             stat =
> readl(s->port.membase + AUART_STAT);
> (gdb) p c
> $4 = 101 'e'
> (gdb) c
> Continuing.
> 
> Breakpoint 3, mxs_auart_rx_char (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:321 321             stat =
> readl(s->port.membase + AUART_STAT);
> (gdb) p c
> $5 = 108 'l'
> (gdb) c
> Continuing.
> 
> Breakpoint 3, mxs_auart_rx_char (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:321 321             stat =
> readl(s->port.membase + AUART_STAT);
> (gdb) p c
> $6 = 108 'l'
> (gdb) c
> Continuing.
> 
> Breakpoint 3, mxs_auart_rx_char (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:321 321             stat =
> readl(s->port.membase + AUART_STAT);
> (gdb) p c
> $7 = 111 'o'
> (gdb)

All my sent characters and the login prompt (\r\r\nArch Linux 3.11.0-
next-20130910-dirty (ttyAPP1)\r\n\r\nolinuxino login: ddHHe[AHelloWW) are in 
the tx buffer:

> (gdb) delete breakpoints
> Delete all breakpoints? (y or n) y
> (gdb) break drivers/tty/serial/mxs-auart.c:285
> Breakpoint 5 at 0xc02d7308: file drivers/tty/serial/mxs-auart.c, line 285.
> (gdb) c
> Continuing.
> 
> Breakpoint 5, mxs_auart_tx_chars (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:285 285                     if
> (s->port.x_char) {
> (gdb) p s->port.x_char
> $8 = 0 '\000'
> (gdb) list
> 280             }
> 281
> 282
> 283             while (!(readl(s->port.membase + AUART_STAT) &
> 284                      AUART_STAT_TXFF)) {
> 285                     if (s->port.x_char) {
> 286                             s->port.icount.tx++;
> 287                             writel(s->port.x_char,
> 288                                          s->port.membase + AUART_DATA);
> 289                             s->port.x_char = 0;
> (gdb) break drivers/tty/serial/mxs-auart.c:294
> Breakpoint 6 at 0xc02d72c8: file drivers/tty/serial/mxs-auart.c, line 294.
> (gdb) n
> 292                     if (!uart_circ_empty(xmit) &&
> !uart_tx_stopped(&s->port)) { (gdb) n
> 293                             s->port.icount.tx++;
> (gdb) n
> 
> Breakpoint 6, mxs_auart_tx_chars (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:294 294                            
> writel(xmit->buf[xmit->tail],
> (gdb) p xmit->buf[xmit->tail]
> $10 = 87 'W'
> (gdb) p xmit->buf
> $9 = 0xc29cb000 "\r\r\nArch Linux 3.11.0-next-20130910-dirty
> (ttyAPP1)\r\n\r\nolinuxino login: ddHHe[AHelloWW" 
> (gdb)

But I don't receive them:

> (gdb) list
> 289                             s->port.x_char = 0;
> 290                             continue;
> 291                     }
> 292                     if (!uart_circ_empty(xmit) &&
> !uart_tx_stopped(&s->port)) { 293                            
> s->port.icount.tx++;
> 294                             writel(xmit->buf[xmit->tail],
> 295                                          s->port.membase + AUART_DATA);
> 296                             xmit->tail = (xmit->tail + 1) &
> (UART_XMIT_SIZE - 1); 297                     } else
> 298                             break;
> (gdb) n
> 293                             s->port.icount.tx++;
> (gdb) n
> 294                             writel(xmit->buf[xmit->tail],
> (gdb) n
> 296                             xmit->tail = (xmit->tail + 1) &
> (UART_XMIT_SIZE - 1); (gdb) n
> 283             while (!(readl(s->port.membase + AUART_STAT) &
> (gdb) n
> 
> Breakpoint 5, mxs_auart_tx_chars (s=0xc3a27a00) at
> drivers/tty/serial/mxs-auart.c:285 285                     if
> (s->port.x_char) {
> (gdb) n
> 292                     if (!uart_circ_empty(xmit) &&
> !uart_tx_stopped(&s->port)) { (gdb) n
> 301                     uart_write_wakeup(&s->port);
> (gdb) n
> 303             if (uart_circ_empty(&(s->port.state->xmit)))
> (gdb) n
> 304                     writel(AUART_INTR_TXIEN,
> (gdb) n
> 303             if (uart_circ_empty(&(s->port.state->xmit)))
> (gdb) n
> 304                     writel(AUART_INTR_TXIEN,
> (gdb) n
> 310             if (uart_tx_stopped(&s->port))
> (gdb) n
> 312     }
> (gdb) n
> uart_start (tty=tty@entry=0xc3b90000) at
> drivers/tty/serial/serial_core.c:105
> 105             spin_unlock_irqrestore(&port->lock, flags);
> (gdb) c
> Continuing.

The line numbers are from next-20130910. Does somebody has an idea what could 
be broken?

--
chris


