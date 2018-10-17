From: "sudheer.v" <open.sudheer@gmail.com>
Subject: [[PATCH] 0/9] *** DMA support for UART in ASPEED's AST2500  ***
Date: Wed, 17 Oct 2018 09:40:57 +0530
Message-ID: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Moese <mmoese@suse.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.orglinux
Cc: "sudheer.v" <open.sudheer@gmail.com>, Sudheer V <sudheer.veliseti@aspeedtech.com>, ShivahShankar Shakarnarayan rao <shivahshankar.shankarnarayanrao@aspeedtech.com>
List-Id: linux-serial@vger.kernel.org

DMA controller driver  and UART dma client driver for aspeed's AST2500

sudheer.v (9):
  DT-changes-for-DMA-UART-of-AST2500
  Defconfig-changes-for-DMA-UART-of-AST2500
  configuration-for-DMA-of-AST2500
  Documentation-DTbindings-DMA-controller-of-AST2500
  DMA-driver-for-AST2500
  configuration-for-DMA-UART-of-AST2500
  Documentation-DTbindings-DMA-UART-of-AST2500
  DMA-UART-Driver-for-AST2500
  updating MAINTAINERS for DMA and DMA-UART drivers of AST2500

 .../devicetree/bindings/dma/ast-uart-sdma.txt      |   23 +
 .../devicetree/bindings/serial/ast-sdma-uart.txt   |   34 +
 MAINTAINERS                                        |   26 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |   20 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   85 ++
 arch/arm/configs/aspeed_g5_defconfig               |    6 +-
 drivers/dma/Kconfig                                |    9 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/aspeed_uart_sdma.c                     |  810 ++++++++++
 drivers/tty/serial/8250/8250_aspeed_uart_dma.c     | 1594 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   34 +
 drivers/tty/serial/8250/Makefile                   |    1 +
 12 files changed, 2641 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
 create mode 100644 drivers/dma/aspeed_uart_sdma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed_uart_dma.c

-- 
1.9.1
