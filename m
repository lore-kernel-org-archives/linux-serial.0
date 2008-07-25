From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix oops in the 8250 serial driver when accessing a removed device
Date: Fri, 25 Jul 2008 12:57:18 +0100
Message-ID: <20080725115718.GD21452@flint.arm.linux.org.uk>
References: <200807221737.06224.laurentp@cse-semaphore.com> <200807221831.54473.laurentp@cse-semaphore.com> <20080725095128.GC21452@flint.arm.linux.org.uk> <200807251340.16716.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYGYMC2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2008 08:02:28 -0400
Content-Disposition: inline
In-Reply-To: <200807251340.16716.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Fri, Jul 25, 2008 at 01:40:13PM +0200, Laurent Pinchart wrote:
> I'm afraid not. I had no copy of the oops so I tried to regenerate it.
> It turned out the bug has been fixed in the meantime.

Great, maybe someone else fixed it?

> On the other hand, I ran into another issue caused by the WARN_ON in
> uart_flush_buffer@drivers/serial/serial_core.c.

Hardly surprising.  I think you're not the first to report this either,
and I seem to remember logging a complaint with the HCI folk over it.
If it still exists... well...

> NIP [c0141288] uart_flush_buffer+0x2c/0xbc
> LR [c013e1f0] tty_driver_flush_buffer+0x34/0x44
> Call Trace:
> [c39f3d70] [c01370e8] tty_ldisc_flush+0x18/0x5c (unreliable)
> [c39f3d80] [c013e1f0] tty_driver_flush_buffer+0x34/0x44
> [c39f3d90] [c0183480] hci_uart_flush+0x34/0xb0
> [c39f3da0] [c018354c] hci_uart_close+0x50/0x70
> [c39f3db0] [c0183704] hci_uart_tty_close+0x38/0xa4
> [c39f3dc0] [c0138cdc] release_dev+0x640/0x680
> [c39f3e70] [c0138d3c] tty_release+0x20/0x3c
> [c39f3e90] [c00724f4] __fput+0x190/0x1b0
> [c39f3eb0] [c0070358] filp_close+0x54/0xac
> [c39f3ed0] [c001efa8] put_files_struct+0xa0/0xec
> [c39f3ef0] [c001f860] do_exit+0x164/0x688
> [c39f3f30] [c001fe60] do_group_exit+0xa0/0xdc
> [c39f3f40] [c00103d0] ret_from_syscall+0x0/0x38

Basically, what's happened here is that release_dev() has closed down
the serial port, and the serial driver has shut down the hardware and
freed its state.

The next thing that release_dev() then does is shut down the line
discipline, in this case that being HCI.  HCI decides that because
it was running, it wants to flush data.  So it then goes on to call
tty_driver_flush_buffer() on a tty which has already been closed.

This calls into the serial core driver, which quite rightfully complains
that its been called to flush data on an already closed tty.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
