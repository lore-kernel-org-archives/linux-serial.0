From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Thu, 28 Apr 2016 23:18:32 +0100
Message-ID: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

[This is an opinionated patch, mainly for discussion.]

I'm trying to reduce the time taken in the kernel in initcalls, with
my aim being to reduce the current ~700ms spent in initcalls before
userspace, down to something like 100ms.  All times on my Broadwell-U
laptop, under virtualization.  The purpose of this is to be able to
launch VMs around containers with minimal overhead, like Intel Clear
Containers, but using standard distro kernels and qemu.

Currently the kernel spends 25ms inspecting the UART that we passed to
it from qemu to find out whether it's an 8250/16550/16550A perhaps
with a non-working FIFO or other quirks.  Well, it isn't -- it's a
working emulated 16550A, with a FIFO and no quirks, and if it isn't,
we should fix qemu.

So the patch detects if we're running virtualized (perhaps it should
only check for qemu/KVM?) and if so, shortcuts the tests.

Rich.
