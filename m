From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 0/3] tty: amba-pl011: Decruft and streamline earlycon
 output
Date: Wed, 18 Oct 2017 15:14:45 +0100
Message-ID: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andre Przywara <andre.przywara@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bhupinder Thakur <bhupinder.thakur@linaro.org>
List-Id: linux-serial@vger.kernel.org

This series avoids waiting for the UART transmitter to go idle in
between every earlycon char written, and does some refactoring so that
this change doesn't have to be implemented multiple times.

The initial motiviation for this is a performance issue encountered
during Xen virtual UART development (see [1] and patch 3).

It's debatable whether this is Linux's responsibility or the
responsibility of the virtual UART: this is a situation where the
virtualised behaviour is inevitably so different from hardware that
it's hard to make a ruling on exactly what behaviour is reasonable.
The best course is probably to work around it on _both_ ends, in the
interest of best interoperation.

Currently amba-pl011 has two distinct earlycon implementations: a
generic pl011 implementation and a quirked implementation that works
around the lack of a usable BUSY status bit in QDF2400 SoCs.

I don't like applying the same obscure fix in multiple places if I can
avoid it, so I've had a go at unifying the earlycons here (patches 1-2).


I'd appreciate people's views, particularly on:

 * (pl011) Whether to refactor harder: the caching of vendor->reg_offset
   vendor->access_32b in uart_amba_port is convenient and avoids chasing
   an extra pointer in the common case, but this the refactoring for the
   earlycon case a bit ugly.  Maybe we can do better.

 * (pl011, serial_core) Whether the new use of port->private_data will
   conflict with existing code (no, AFAICT).

 * (earlycon) Whether overriding port->iotype for 32-bit-only
   implementations is the right thing to do.

 * (earlycon) Whether there is some reason to drain the transmitter
   after every char that I've overlooked.


Currently I don't consider this to be a candidate for stable, but it
could be backported.  Due to the steady quirkage churn in amba-pl011,
it would be better to drop the refactoring stuff for backporting
purposes.

Testing:

 * tested rather casually no ARM Juno r0 (real PL011) and the ARM VFP
   Base Model (emulated PL011)

 * *Not tested* on QDF2400, since I don't have access to one.
   Someone probably ought to test that.


[1] Re: [Xen-devel] [PATCH 26/27 v12] arm/xen: vpl011: Fix the slow
early console SBSA UART output
https://lists.xenproject.org/archives/html/xen-devel/2017-10/msg01949.html

Dave Martin (3):
  tty: amba-pl011: earlycon: Switch to relaxed I/O
  tty: amba-pl011: earlycon: Unify earlycon backends
  tty: amba-pl011: earlycon: Don't drain the transmitter after each char

 drivers/tty/serial/amba-pl011.c | 108 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 47 deletions(-)

-- 
2.1.4
