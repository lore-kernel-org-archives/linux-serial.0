From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 0/9] ARM: sun8i: Support A23 PRCM clock and
 reset controllers
Date: Thu,  3 Jul 2014 22:55:40 +0800
Message-ID: <1404399349-20237-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBA662WOQKGQEYELLW6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi everyone,

This is the PRCM subset of v3 of the sun8i A23 bring-up series. This
subset includes clock and reset controller support for the PRCM (power,
reset and clock module) on the A23 SoC. It is based on my previous
series for basic sun8i A23 clocks [1].

The first 3 patches add or fix the prcm clock drivers to support the
A23's PRCM variant.

The fourth patch adds support for A23's PRCM to the sun6i-prcm driver.
The difference between the A23 and the A31 regarding the PRCM block
is 2 clock muxes were removed, a divider clock has slightly difference
dividers, and some clock gates are gone. The resources used are
unchanged. Drivers for the 2 clock muxes are replaced with fixed-factor
clocks in the DT. So the A23 variant is supported with the sun6i-prcm
driver with a slightly different sub-device list.

Patch 5 adds optional reset control support to the 8250_dw, which
is used by sun6i and sun8i platforms. Till now, this wasn't needed
from a working standpoint, as the bootloader de-asserts the reset
control on the console UART for us. However, during the development
of the sun8i patches, I noticed other UARTs wouldn't work. Also the
new sun6i A31 Hummingbird has multiple UARTs available, which would
require this patch.

Patch 6 adds deferred probing to 8250_dw. In my case, even though
the clocks and reset controller "devices" were registered before
the UART, the 8250_dw driver binded with the UART devices before
the clocks and resets were available. This resulted in the 8250_dw
driver failing. I only tested the R_UART device.

Strictly speaking it won't be needed once pinctrl support is added,
as the driver core handles deferred probing for pinctrl phandles,
and the pinctrl device for the R_UART is probed after it. However
it may be required for the A31 Hummingbird development board.
Suggestions welcome.

Patch 7 selects the sun6i-prcm driver when we're building for
sun8i, so we don't end up with essential drivers missing.

Patch 8 adds the PRCM nodes, and the associated clock/reset phandles,
to the sun8i DTSI.

Patch 9 adds the reset controller nodes to the sun8i DTSI, using
drivers from sun6i, as an extra. I thought I'd do all the reset
controllers in the same series.

These patches can go through their separate trees. There are no
compile time dependencies between them.


Related changes since v2:

  - Add separate driver for sun8i-a23-apb0-clk
  - Use sun6i-a31-clock-reset for ahb1_rst

Related changes since v1:

  - Add sun8i-a23-apb0-gates-clk compatible to sun6i-a31-apb0-gates-clk


Cheers
ChenYu


  [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266990.html

Chen-Yu Tsai (9):
  clk: sunxi: Add A23 APB0 divider clock support
  clk: sunxi: Fix gate indexing for sun6i-a31-apb0-gates
  clk: sunxi: Add A23 specific compatible to sun6i-a31-apb0-gates-clk
  mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
  serial: 8250_dw: Add optional reset control support
  serial: 8250_dw: Add support for deferred probing
  ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch support is enabled
  ARM: sun8i: Add PRCM clock and reset controller nodes to the DTSI
  ARM: sun8i: Add reset controller nodes to the DTSI

 Documentation/devicetree/bindings/clock/sunxi.txt  |  2 +
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
 .../bindings/serial/snps-dw-apb-uart.txt           |  1 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   | 71 +++++++++++++++++++++-
 arch/arm/mach-sunxi/Kconfig                        |  3 +
 drivers/clk/sunxi/Makefile                         |  4 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |  7 ++-
 drivers/clk/sunxi/clk-sun8i-apb0.c                 | 68 +++++++++++++++++++++
 drivers/mfd/sun6i-prcm.c                           | 30 +++++++++
 drivers/tty/serial/8250/8250_dw.c                  | 13 ++++
 10 files changed, 197 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-apb0.c

-- 
2.0.1
