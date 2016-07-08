From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/3] Complete ZTE PL011 device support
Date: Fri,  8 Jul 2016 17:00:38 +0800
Message-ID: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is a pick-up of Jun's v2 patch which tries to complete ZTE PL011
support.

Commit 7ec758718920 ("tty: amba-pl011: add support for ZTE UART
(EXPERIMENTAL)") from Russell had already done part of the work that is
needed for ZTE PL011 support.  The series adds the missing pieces which
includes handling Flag Register bit position oddness and getting ZTE
PL011 device probed by amba-pl011 driver.

Thanks to Russell for the "official" pseudo-ID idea.

Changes since v2:
 - Split changes into 3 separate patches
 - Take Russell's suggestion using helper macro to create pseudo-ID
 - Rebase to v4.7-rc6

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/417192.html

Shawn Guo (3):
  tty: amba-pl011: define flag register bits for ZTE device
  tty: amba-pl011: add .get_fifosize for ZTE device
  tty: amba-pl011: probe ZTE device from AMBA bus with a pseudo-ID

 drivers/tty/serial/amba-pl011.c | 59 ++++++++++++++++++++++++++++++++---------
 include/linux/amba/bus.h        |  6 +++++
 include/linux/amba/serial.h     |  9 +++++++
 3 files changed, 62 insertions(+), 12 deletions(-)

-- 
1.9.1
