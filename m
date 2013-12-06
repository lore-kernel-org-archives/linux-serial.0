From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/5] tty: serial: bcm63xx_uart: do not depend on MIPS
Date: Thu, 5 Dec 2013 18:26:03 -0800
Message-ID: <1386296768-20204-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org, mbizon@freebox.fr, cernekee@gmail.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, Florian Fainelli <florian@openwrt.org>
List-Id: linux-serial@vger.kernel.org

Hi all,

This patchset reduces the dependency of the bcm63xx_uart on the MIPS BCM63XX
SoC support code in preparation for being used on different architectures
such as ARM.

Due to the MIPS patch which breaks down the register defines, this series
should ideally go via the MIPS tree.

Thanks!

Florian Fainelli (5):
  tty: serial: bcm63xx_uart: remove unused inclusion
  tty: serial: bcm63xx_uart: drop bcm_{readl,writel} macros
  MIPS: BCM63XX: move UART register definitions
  tty: serial: bcm63xx_uart: use linux/serial_bcm63xx.h
  MIPS: BCM63XX: use linux/serial_bcm63xx.h

 arch/mips/bcm63xx/early_printk.c                  |   2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 120 ----------------------
 drivers/tty/serial/bcm63xx_uart.c                 |   9 +-
 include/linux/serial_bcm63xx.h                    | 119 +++++++++++++++++++++
 4 files changed, 123 insertions(+), 127 deletions(-)
 create mode 100644 include/linux/serial_bcm63xx.h

-- 
1.8.3.2
