From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Mon, 23 Apr 2018 14:41:27 +0100
Message-ID: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an update to a previous RFC v2 [1], to fix a problem observed by
the qemu community that causes serial input to hang when booting a
simulated system with data already queued in the UART FIFO [2].

After discussion, I decided that the approach in [1] was over-
engineered: it tries to preserve a guarantee that people shouldn't be
relying on anyway, namely that data sent to the UART prior to kernel
boot will be received by the kernel; or more generally that data
received by the UART while the pl011 driver is not opened will be
received (either intact or at all) by the driver.

If anyone can please test the following and let me know the results,
that would be much appreciated!

 a) Check that you can still reproduce the bug on mainline without this
    patch.

 b) Check whether this patch fixes the problem.

Cheers
---Dave

[1] [RFC PATCH v2] tty: pl011: Avoid spuriously stuck-off interrupts
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/556897.html

[2] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Dave Martin (1):
  tty: pl011: Avoid spuriously stuck-off interrupts

 drivers/tty/serial/amba-pl011.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.1.4
