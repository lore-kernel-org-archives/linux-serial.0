From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST 0/2] Remove pl011 startup glitches and avoid dummy TX
 during startup
Date: Wed,  4 Mar 2015 12:27:32 +0000
Message-ID: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
List-Id: linux-serial@vger.kernel.org

There have been no comments on this series since my previous post, and
I have made no further changes.

Since then, I have confirmed that this also works robustly with TX DMA
enabled on Juno.

Review/comments/testing still welcome.

Cheers
---Dave



Original cover letter:

This is a major rework of a previously-posted patch [1].

This addresses a number of overlapping issues:

 * interaction of the dummy TX in pl011_startup() with hardware that
   doesn't suppress transmission when in loopback mode, causing
   glitches / corruption at the receiver;

 * lack of support for loopback mode in the SBSA Generic UART;

 * issues with the models/simulators that pretend to have an
   unreasonably high baud rate (making it impossible to fill the
   FIFO in some situations).


The general approach in this series is to remove the dummy TX and
start in a timer-based polled IO mode instead.  If and when a TX IRQ
occurs, we switch to interrupt-driven mode for future processing.

If the data written to the UART is a small enough trickle, we may
never using the TX IRQ, but the UART would not stream constantly in
any case unless there is enough data being written to stop the FIFO
ever emptying.


I've kept the second patch separate in case someone can think of a
reason why it might not work...

There is some context overlap with Jorge's probe deferral patch, but
the merge is straightforward.


Tested on ARM Juno and the ARM fast models only for now.

Any review/testing from other folks would be appreciated.

Cheers
Dave


[1] [RFC PATCH] serial: amba-pl011: Kickstart TX by explicit FIFO fill
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315248.html

Dave Martin (2):
  serial/amba-pl011: Activate TX IRQ passively
  serial/amba-pl011: Leave the TX IRQ alone when the UART is not open

 drivers/tty/serial/amba-pl011.c |  164 +++++++++++++++++++++++++++------------
 1 file changed, 113 insertions(+), 51 deletions(-)

-- 
1.7.10.4
