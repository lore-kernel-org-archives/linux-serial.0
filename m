From: Helmut Klein <hgkr.klein@gmail.com>
Subject: [PATCH v2,
 0/3] tty/serial: meson_uart: add support for core clock handling
Date: Tue, 28 Mar 2017 11:25:42 +0200
Message-ID: <20170328092545.4644-1-hgkr.klein@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

To be able to use the three none AO uarts of the s905 SoCs (uart_A, uart_B
& uart_C), the core clock has to be enabled. (see chapter 22.3 of the
public s905 data sheet) At least the u-boot of my s905 based media player
(netxeon minimx) doesn't do this. so the driver must do it.

This patch set does:
- exposes the clock ids to the dtb
- adds documentation for the dt-bindings of meson_uart
- adds the core clock handling to the driver

The patchset is based on the branch master of the repository in [1]

Changes since v1
- use git to produce the patch set
- added the clock ids for uart_B and uart_C

None of the available s905 dts use uart_A actively. So there is no patch
for any of the existing dts files.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git

Helmut Klein (3):
  tty/serial: meson_uart: expose CLKID_UARTx
  tty/serial: meson_uart: add documentation for the dt-bindings
  tty/serial: meson_uart: add the core clock handling to the driver

 .../bindings/serial/amlogic,meson_uart.txt         | 25 ++++++++++++++++++++++
 drivers/clk/meson/gxbb.h                           |  6 +++---
 drivers/tty/serial/meson_uart.c                    | 10 +++++++++
 include/dt-bindings/clock/gxbb-clkc.h              |  3 +++
 4 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson_uart.txt

--
2.11.0
