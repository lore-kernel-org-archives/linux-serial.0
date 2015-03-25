From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 0/1] serial/amba-pl011: Activate TX IRQ passively
Date: Wed, 25 Mar 2015 18:25:56 +0000
Message-ID: <1427307957-2904-1-git-send-email-Dave.Martin@arm.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
List-Id: linux-serial@vger.kernel.org

(Rework based on v4.0-rc5)

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
whether the TX IRQ will fire until the FIFO has been filled.

This should also mean that the driver works on the SBSA Generic
UART[1] (a cut-down PL011) without invasive changes.  The Generic
UART lacks some features needed for the dummy TX approach to work
(FIFO disabling and loopback).

[1] Server Base System Architecture (ARM-DEN-0029-v2.3)
    http://infocenter.arm.com/
    (click-thru required :/)

Dave Martin (1):
  serial/amba-pl011: Activate TX IRQ passively

 drivers/tty/serial/amba-pl011.c |   88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

-- 
1.7.10.4
