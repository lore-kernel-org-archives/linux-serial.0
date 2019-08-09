From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 00/13] v2: ARM: move lpc32xx to multiplatform
Date: Fri,  9 Aug 2019 16:40:26 +0200
Message-ID: <20190809144043.476786-1-arnd@arndb.de>
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
To: soc@kernel.org
Cc: linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org, Sylvain Lemieux <slemieux.tyco@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Version 2 contains some minor changes based on earlier feedback
and from the 0day build bot testing on other architectures. The
only patch that changed significantly is the one for the gpio driver.

I would suggest we merge this version into the soc tree directly
if there are no further concerns.

      Arnd

Arnd Bergmann (12):
  usb: ohci-nxp: enable compile-testing
  usb: udc: lpc32xx: allow compile-testing
  watchdog: pnx4008_wdt: allow compile-testing
  serial: lpc32xx_hs: allow compile-testing
  gpio: lpc32xx: allow building on non-lpc32xx targets
  net: lpc-enet: factor out iram access
  net: lpc-enet: move phy setup into platform code
  net: lpc-enet: fix printk format strings
  net: lpc-enet: allow compile testing
  serial: lpc32xx: allow compile testing
  ARM: lpc32xx: clean up header files
  ARM: lpc32xx: allow multiplatform build

kbuild test robot (1):
  net: lpc-enet: fix badzero.cocci warnings

 arch/arm/Kconfig                              |  17 +--
 arch/arm/configs/lpc32xx_defconfig            |   2 +
 arch/arm/mach-lpc32xx/Kconfig                 |  11 ++
 arch/arm/mach-lpc32xx/common.c                |  24 +++-
 arch/arm/mach-lpc32xx/common.h                |   1 -
 arch/arm/mach-lpc32xx/include/mach/board.h    |  15 ---
 .../mach-lpc32xx/include/mach/entry-macro.S   |  28 -----
 arch/arm/mach-lpc32xx/include/mach/hardware.h |  25 ----
 .../mach-lpc32xx/include/mach/uncompress.h    |  50 --------
 .../{include/mach/platform.h => lpc32xx.h}    |  18 ++-
 arch/arm/mach-lpc32xx/pm.c                    |   3 +-
 arch/arm/mach-lpc32xx/serial.c                |  33 ++++-
 arch/arm/mach-lpc32xx/suspend.S               |   3 +-
 drivers/gpio/Kconfig                          |   7 ++
 drivers/gpio/Makefile                         |   2 +-
 drivers/gpio/gpio-lpc32xx.c                   | 118 ++++++++++--------
 drivers/net/ethernet/nxp/Kconfig              |   2 +-
 drivers/net/ethernet/nxp/lpc_eth.c            |  45 +++----
 drivers/tty/serial/Kconfig                    |   3 +-
 drivers/tty/serial/lpc32xx_hs.c               |  37 +-----
 drivers/usb/gadget/udc/Kconfig                |   3 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c          |   3 +-
 drivers/usb/host/Kconfig                      |   3 +-
 drivers/usb/host/ohci-nxp.c                   |  25 ++--
 drivers/watchdog/Kconfig                      |   2 +-
 drivers/watchdog/pnx4008_wdt.c                |   1 -
 include/linux/soc/nxp/lpc32xx-misc.h          |  33 +++++
 27 files changed, 242 insertions(+), 272 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h
 rename arch/arm/mach-lpc32xx/{include/mach/platform.h => lpc32xx.h} (98%)
 create mode 100644 include/linux/soc/nxp/lpc32xx-misc.h

-- 
2.20.0

Cc: soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-gpio@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
