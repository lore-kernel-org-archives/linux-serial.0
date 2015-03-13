From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 0/2] serial/amba-pl011: Activate TX IRQ passively
Date: Fri, 13 Mar 2015 15:56:20 +0000
Message-ID: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
List-Id: linux-serial@vger.kernel.org

Changes since v1:

This is a cleanup of v1 which significantly simplifies some things and
fixes a couple of bugs.

Due to these changes, I've stripped the Tested-bys.  If the guys who
already gave a Tested-by (thanks) have a chance, a re-test would be
much appreciated.

 * Refactored pl011_tx_char() and associated control flow to have
   "try to transmit a char" semantics, instead of "transmit, then
   tell me whether I can transmit another".

   This makes the code clearer, and ensures by construction that TXFF is
   always checked before sending a char, if character transmission was
   not triggered by an interrupt.

   As a side effect, this change exposed and also fixes a bug which can
   cause the last character to be sent twice when the FIFO becomes full
   (thanks to Dom Cobley for reporting this).

 * Removal of some redundant changes, and verbose comments that are no
   longer needed.

[Russell: I didn't do all the restructuring you suggested, because I
wanted to clean up and stabilise the existing series.  The result seems
a fair bit less convoluted, but I'm happy to further restructuring if
you feel it's needed.]


Original cover letter:

The current PL011 driver transmits a dummy character when the UART
is opened, to assert the TX IRQ for the first time
(see pl011_startup()).  The UART is put in loopback mode temporarily,
so the receiver presumably shouldn't see anything.

However...

At least some platforms containing a PL011 send characters down the
wire even when loopback mode is enabled.  This means that a
spurious NUL character may be seen at the receiver when the PL011 is
opened through the TTY layer.

The current code also temporarily sets the baud rate to maximum and
the character width to the minimum, to that the dummy TX completes
as quickly as possible.  If this is seen by the receiver it will
result in a framing error and can knock the receiver out of sync --
turning subsequent output into garbage until synchronisation
is reestablished.  (Particularly problematic during boot with systemd.)

To avoid spurious transmissions, this patch removes assumptions about
whether the TX IRQ will fire until at least one TX IRQ has been seen.

Instead, the UART will unmask the TX IRQ and then slow-start via
polling and timer-based soft IRQs initially.  If the TTY layer writes
enough data to fill the FIFO to the interrupt threshold in one go,
the TX IRQ should assert, at which point the driver changes to
fully interrupt-driven TX.

In this way, the TX IRQ is activated as a side-effect instead of
being done deliberately.

This should also mean that the driver works on the SBSA Generic
UART[1] (a cut-down PL011) without invasive changes.  The Generic
UART lacks some features needed for the dummy TX approach to work
(FIFO disabling and loopback).

[1] Server Base System Architecture (ARM-DEN-0029-v2.3)
    http://infocenter.arm.com/
    (click-thru required :/)

Dave Martin (2):
  serial/amba-pl011: Activate TX IRQ passively
  serial/amba-pl011: Leave the TX IRQ alone when the UART is not open

 drivers/tty/serial/amba-pl011.c |  120 +++++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 44 deletions(-)

-- 
1.7.10.4
