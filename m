From: "George Spelvin" <linux@horizon.com>
Subject: serial8250_interrupt idea
Date: Thu, 13 Nov 2008 10:03:08 -0500
Message-ID: <20081113150308.3590.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:10862 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751129AbYKMPJu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2008 10:09:50 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, linux@horizon.com

When ISA-style edge-sensitive interrupts are shared (as is commonly done
on multi-serial cards), it's essential that all interrupt sources are
quieted before returning from the interrupt handler, so there will be
an inactive-to-active edge to trigger on next time.

This requires repeatedly polling all of the ports sharing one IRQ until
you've done a full pass during which nobody had an interrupt pending.
That ensures that there was an interval (between emptying the last
busy port and checking the status of the first empty port in the final
all-empty pass) during which the interrupt line was not asserted.

The current code keeps all the ports in a linked list and polls them
in a loop, remembering the position of the last busy port, until that
position has been reached again without seeing a non-empty port.

However, it seems to me that it's possible to improve on this.
Which would be valuable, given that ISA I/O port reads (usually on a
super-IO chip via an LPC bus these days) are quite time-consuming.

If you could predict which ports were going to be busy, you could check
them first on the first pass, allowing you to start the final verification
pass as early as possible.

This could be done very easily via a self-organizing list.  When a
port is polled busy, move it up to the front of the list so it will be
checked earlier next time.  The inactive ports would migrate to the end
of the list.  The struct uart_8250_port list is already locked for the
duration of the interrupt, so there is no need for additional locking.


I was thinking about preparing a patch to do this, but I have one style
question: it would be easier to do the list rearrangement if the
list were singly-linked.  Removing a port would require walking the
whole list, but we already do that each interrupt so it's hardly
a frightening cost.

Is there any reason to preserve the "struct list" configuration?
