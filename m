From: Dave Martin <Dave.Martin@arm.com>
Subject: Handling of chars received while a UART is not open
Date: Wed, 31 Jan 2018 12:06:29 +0000
Message-ID: <20180131120628.GL5862@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi all,

Question:

 1) Should a UART definitely discard the RX FIFO on ->startup()?

 2) Should a UART definitely *not* discard the RX FIFO on ->startup()?
    (as in my fix).

 3) Or is there no clear answer here?


Background:

Working on a fix for an RX lockup issue with amba-pl011 [1], I came up
with the idea that the driver's attempt to clear spurious interrupts on
startup is going wrong when the interrupt is not spurious (i.e., the RX
FIFO is initially full to the interrupt trigger threshold).

I have a fix [2] based on this.  It removes the attempt to clear
spurious interrupts so that the RX FIFO will definitely get drained if
need be, in the pl011 interrupt handler.

This should mean that amba-pl011 implements (2) with my patch.

But this may have unwanted side-effects, depending on the answer to
the above question.


Now, Qemu has a facility for stuffing some input to an emulated UART
immediately on boot, and wouldn't work in case (2) above.  OTOH, that
may be a mistaken approach: it's unlikely to work reliably on hardware
due to the problem of knowing when a physical UART is actually ready to
receive input.  So maybe Qemu should be waiting for a prompt to be
transmitted before stuffing input.  In case (1) or (3), qemu probably
needs to do something like that.

(1) is also odd though.  Garbage on the wire while the UART is closed
will then be seen when a process opens the UART.  If there is a
non-trivial amount of data, an overrun error will most likely be
reported too.  User programs intended to be robust (getty, pppd etc.)
should perhaps be doing an explicit flush on startup, but this will
race against the UART driver unless the UART driver flushes the FIFO in
its ->startup().  Wire protocols are inherently realtime and need
another way to negotiate startup (DCD/DSR/DTR signalling for example)
or to recover from a bad state on one or both ends.

So I don't know what the right answer is.


Wei's proposed fix in qemu [1] attempts to detect readiness by waiting
for the emulated system to enable interrupts on the UART, but this
makes assumptions about the driver running inside the emultaion: for
a polled-mode driver, it would most likely not work.

The pl011 hardware provides no way to distinguish spurious from
non-spurious RX FIFO interrupts other than reading the FIFO to see if
there's anything in there.  Moreover, the interrupt state machine in
the hardware can get stuck if the FIFO is not drained sufficiently.


[1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo before enabl
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

[2] [RFC PATCH v2] tty: pl011: Avoid spuriously stuck-off interrupts
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/556897.html
