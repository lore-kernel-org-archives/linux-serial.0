From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 0/5] serial: imx: add DMA support for imx6
Date: Tue, 2 Jul 2013 14:30:23 +0800
Message-ID: <1372746628-20092-1-git-send-email-b32955@freescale.com>
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
To: gregkh@linuxfoundation.org
Cc: Huang Shijie <b32955@freescale.com>, s.hauer@pengutronix.de, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

(1) This patch set adds the DMA support for the imx serial driver.
    The uart with the dma support is usually used by the Bluetooth.

    For the firmware's limit, i only enable the DMA for imx6.
    If we have proper firmware for imx53 (or other chips), we can also
    enable the DMA for it.

(2) We only enable the DMA support when the following are meet:

    [1] The uart port supports the hardware flow control(CTS/RTS).
      (Some uart port does not support the CTS/RTS.)

    [2] The application enables the CTS/RTS.

    [3] The Soc is imx6.
      For the sdma's firmware limit, we do not support the DMA except
      the imx6 platform.

    [4] The uart is not used as a console.


(3) Tested this patch set by:
	connecting a imx6q-arm2 board(DTE) with a imx53 board(DCE).


Huang Shijie (5):
  serial: imx: distinguish the imx6 uart from the others
  serial: imx: add DMA support for imx6
  ARM: dts: imx6: rename the uart's compatible property
  ARM: dts: imx6: add dte pinctrl for uart2
  ARM: dts: enable the uart2 for imx6q-arm2

 arch/arm/boot/dts/imx6q-arm2.dts |   10 +
 arch/arm/boot/dts/imx6q.dtsi     |    9 +
 arch/arm/boot/dts/imx6qdl.dtsi   |   10 +-
 arch/arm/boot/dts/imx6sl.dtsi    |   10 +-
 drivers/tty/serial/imx.c         |  430 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 452 insertions(+), 17 deletions(-)
