From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tty:tty-next 25/55] arch/mn10300/kernel/mn10300-serial.c:527:19: error: 'port' redeclared as different kind of symbol
Date: Wed, 16 Jan 2013 15:45:54 +0800
Message-ID: <50f65ab2.siZ9YAVjkofVwftt%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54572 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758182Ab3APHrX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:47:23 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   852e4a8152b427c3f318bb0e1b5e938d64dcdc32
commit: 227434f8986c3827a1faedd1feb437acd6285315 [25/55] TTY: switch tty_buffer_request_room to tty_port
config: make ARCH=mn10300 asb2364_defconfig

All error/warnings:

   arch/mn10300/kernel/mn10300-serial.c: In function 'mn10300_serial_receive_interrupt':
>> arch/mn10300/kernel/mn10300-serial.c:527:19: error: 'port' redeclared as different kind of symbol
   arch/mn10300/kernel/mn10300-serial.c:524:74: note: previous definition of 'port' was here
>> arch/mn10300/kernel/mn10300-serial.c:527:31: error: 'struct tty_port' has no member named 'uart'
>> arch/mn10300/kernel/mn10300-serial.c:533:2: error: 'struct tty_port' has no member named 'name'
>> arch/mn10300/kernel/mn10300-serial.c:537:10: error: 'struct tty_port' has no member named 'rx_inp'
>> arch/mn10300/kernel/mn10300-serial.c:537:10: error: 'struct tty_port' has no member named 'rx_outp'
   arch/mn10300/kernel/mn10300-serial.c:547:7: error: 'struct tty_port' has no member named 'rx_outp'
   arch/mn10300/kernel/mn10300-serial.c:547:7: error: 'struct tty_port' has no member named 'rx_outp'
   arch/mn10300/kernel/mn10300-serial.c:548:6: error: 'struct tty_port' has no member named 'rx_inp'
>> arch/mn10300/kernel/mn10300-serial.c:555:11: error: 'struct tty_port' has no member named 'rx_buffer'
   arch/mn10300/kernel/mn10300-serial.c:556:11: error: 'struct tty_port' has no member named 'rx_buffer'
   arch/mn10300/kernel/mn10300-serial.c:558:6: error: 'struct tty_port' has no member named 'rx_outp'
   arch/mn10300/kernel/mn10300-serial.c:559:6: error: 'struct tty_port' has no member named 'uart'
>> arch/mn10300/kernel/mn10300-serial.c:571:14: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:578:8: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:585:8: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:588:31: error: 'struct tty_port' has no member named 'uart'
   arch/mn10300/kernel/mn10300-serial.c:599:7: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:622:8: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:640:35: error: 'struct tty_port' has no member named 'uart'
   arch/mn10300/kernel/mn10300-serial.c:647:11: error: 'struct tty_port' has no member named 'rx_brk'
   arch/mn10300/kernel/mn10300-serial.c:656:16: error: 'struct tty_port' has no member named 'uart'
   arch/mn10300/kernel/mn10300-serial.c:658:33: error: 'struct tty_port' has no member named 'uart'
   arch/mn10300/kernel/mn10300-serial.c:691:6: error: 'struct tty_port' has no member named 'rx_brk'

vim +/port +527 arch/mn10300/kernel/mn10300-serial.c

   518	}
   519	
   520	/*
   521	 * receive chars from the ring buffer for this serial port
   522	 * - must do break detection here (not done in the UART)
   523	 */
   524	static void mn10300_serial_receive_interrupt(struct mn10300_serial_port *port)
   525	{
   526		struct uart_icount *icount = &port->uart.icount;
 > 527		struct tty_port *port = &port->uart.state->port;
   528		struct tty_struct *tty = port->tty;
   529		unsigned ix;
   530		int count;
   531		u8 st, ch, push, status, overrun;
   532	
   533		_enter("%s", port->name);
   534	
   535		push = 0;
   536	
   537		count = CIRC_CNT(port->rx_inp, port->rx_outp, MNSC_BUFFER_SIZE);
   538		count = tty_buffer_request_room(port, count);
   539		if (count == 0) {
   540			if (!tty->low_latency)
   541				tty_flip_buffer_push(tty);
   542			return;
   543		}
   544	
   545	try_again:
   546		/* pull chars out of the hat */
   547		ix = ACCESS_ONCE(port->rx_outp);
   548		if (CIRC_CNT(port->rx_inp, ix, MNSC_BUFFER_SIZE) == 0) {
   549			if (push && !tty->low_latency)
   550				tty_flip_buffer_push(tty);
   551			return;
   552		}
   553	
   554		smp_read_barrier_depends();
   555		ch = port->rx_buffer[ix++];
   556		st = port->rx_buffer[ix++];
   557		smp_mb();
   558		port->rx_outp = ix & (MNSC_BUFFER_SIZE - 1);
   559		port->uart.icount.rx++;
   560	
   561		st &= SC01STR_FEF | SC01STR_PEF | SC01STR_OEF;
   562		status = 0;
   563		overrun = 0;
   564	
   565		/* the UART doesn't detect BREAK, so we have to do that ourselves
   566		 * - it starts as a framing error on a NUL character
   567		 * - then we count another two NUL characters before issuing TTY_BREAK
   568		 * - then we end on a normal char or one that has all the bottom bits
   569		 *   zero and the top bits set
   570		 */
   571		switch (port->rx_brk) {
   572		case 0:
   573			/* not breaking at the moment */
   574			break;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
