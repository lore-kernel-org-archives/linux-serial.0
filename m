From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/14] ARM: move lpc32xx and dove to multiplatform
Date: Wed, 31 Jul 2019 21:56:42 +0200
Message-ID: <20190731195713.3150463-1-arnd@arndb.de>
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
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

I revisited some older patches here, getting two of the remaining
ARM platforms to build with ARCH_MULTIPLATFORM like most others do.

In case of lpc32xx, I created a new set of patches, which seemed
easier than digging out what I did for an older release many
years ago.

For dove, the patches are basically what I had proposed back in
2015 when all other ARMv6/ARMv7 machines became part of a single
kernel build. I don't know what the state is mach-dove support is,
compared to the DT based support in mach-mvebu for the same
hardware. If they are functionally the same, we could also just
remove mach-dove rather than applying my patches.

I also created patches to remove the w90x900 and ks8695 platforms
that seem to have lost their last users a few years ago.
I will post them separately, but plan to apply them in the same
branch for linux-5.4 if there are no objections.

      Arnd

Arnd Bergmann (14):
  usb: ohci-nxp: enable compile-testing
  usb: udc: lpc32xx: allow compile-testing
  watchdog: pnx4008_wdt: allow compile-testing
  serial: lpc32xx_hs: allow compile-testing
  gpio: lpc32xx: allow building on non-lpc32xx targets
  net: lpc-enet: factor out iram access
  net: lpc-enet: move phy setup into platform code
  net: lpc-enet: allow compile testing
  serial: lpc32xx: allow compile testing
  ARM: lpc32xx: clean up header files
  ARM: lpc32xx: allow multiplatform build
  ARM: dove: clean up mach/*.h headers
  ARM: orion/mvebu: unify debug-ll virtual addresses
  ARM: dove: multiplatform support

 arch/arm/Kconfig                              | 33 +---------
 arch/arm/Kconfig.debug                        |  5 +-
 arch/arm/configs/dove_defconfig               |  2 +
 arch/arm/configs/lpc32xx_defconfig            |  1 +
 arch/arm/mach-dove/Kconfig                    | 16 +++--
 arch/arm/mach-dove/Makefile                   |  2 +
 .../{include/mach => }/bridge-regs.h          |  4 +-
 arch/arm/mach-dove/cm-a510.c                  |  3 +-
 arch/arm/mach-dove/common.c                   |  4 +-
 arch/arm/mach-dove/dove-db-setup.c            |  2 +-
 arch/arm/mach-dove/{include/mach => }/dove.h  | 14 ++---
 arch/arm/mach-dove/include/mach/hardware.h    | 19 ------
 arch/arm/mach-dove/include/mach/uncompress.h  | 36 -----------
 arch/arm/mach-dove/irq.c                      |  5 +-
 arch/arm/mach-dove/{include/mach => }/irqs.h  |  2 -
 arch/arm/mach-dove/mpp.c                      |  2 +-
 arch/arm/mach-dove/pcie.c                     |  4 +-
 arch/arm/mach-dove/{include/mach => }/pm.h    |  4 +-
 arch/arm/mach-lpc32xx/Kconfig                 | 11 ++++
 arch/arm/mach-lpc32xx/common.c                | 24 +++++--
 arch/arm/mach-lpc32xx/common.h                |  1 -
 arch/arm/mach-lpc32xx/include/mach/board.h    | 15 -----
 .../mach-lpc32xx/include/mach/entry-macro.S   | 28 ---------
 arch/arm/mach-lpc32xx/include/mach/hardware.h | 25 --------
 .../mach-lpc32xx/include/mach/uncompress.h    | 50 ---------------
 .../{include/mach/platform.h => lpc32xx.h}    | 18 +++++-
 arch/arm/mach-lpc32xx/pm.c                    |  3 +-
 arch/arm/mach-lpc32xx/serial.c                | 33 +++++++++-
 arch/arm/mach-lpc32xx/suspend.S               |  3 +-
 arch/arm/mach-mv78xx0/mv78xx0.h               |  4 +-
 arch/arm/mach-orion5x/orion5x.h               |  4 +-
 drivers/gpio/Kconfig                          |  8 +++
 drivers/gpio/Makefile                         |  2 +-
 drivers/gpio/gpio-lpc32xx.c                   | 63 ++++++++++++-------
 drivers/net/ethernet/nxp/Kconfig              |  2 +-
 drivers/net/ethernet/nxp/lpc_eth.c            | 30 +++------
 drivers/tty/serial/Kconfig                    |  3 +-
 drivers/tty/serial/lpc32xx_hs.c               | 37 ++---------
 drivers/usb/gadget/udc/Kconfig                |  3 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c          |  2 -
 drivers/usb/host/Kconfig                      |  3 +-
 drivers/usb/host/ohci-nxp.c                   | 25 +++++---
 drivers/watchdog/Kconfig                      |  2 +-
 drivers/watchdog/pnx4008_wdt.c                |  1 -
 include/linux/soc/nxp/lpc32xx-misc.h          | 33 ++++++++++
 45 files changed, 246 insertions(+), 345 deletions(-)
 rename arch/arm/mach-dove/{include/mach => }/bridge-regs.h (96%)
 rename arch/arm/mach-dove/{include/mach => }/dove.h (95%)
 delete mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 rename arch/arm/mach-dove/{include/mach => }/irqs.h (98%)
 rename arch/arm/mach-dove/{include/mach => }/pm.h (97%)
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h
 rename arch/arm/mach-lpc32xx/{include/mach/platform.h => lpc32xx.h} (98%)
 create mode 100644 include/linux/soc/nxp/lpc32xx-misc.h

-- 
2.20.0
