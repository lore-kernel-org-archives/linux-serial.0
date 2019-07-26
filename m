From: "sudheer.v" <open.sudheer@gmail.com>
Subject: [patch v4 0/5] *** AST2500 DMA UART driver ***
Date: Fri, 26 Jul 2019 18:57:15 +0530
Message-ID: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, sudheer.veliseti@aspeedtech.com
Cc: sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Hi,

In this patchset v4,all the comments provided for patchset v3
are addressed.Also there is considerable
change in the code related to how the per port
uart structure is registerd with uart core.
so the patch [patch v4 1/5] considerably differs from [patch v3 1/5]

Thanks and Regards
Sudheer.V

changes in v4:
- since TX uart interrupt is being invoked by 8250 framework
  instead of expected TX DMA interrupt,registration of uart port is changed.
  per port uart structure registration is done directly now
  instead of going throgh 8250 framework.
  so there is considerable change in code against v3 patch
changes in v3:
- custom debugs replaced with pr_debug in 8250_ast2500_uart_dma.c
- change logs added in patches

sudheer veliseti (5):
  AST2500 DMA UART driver
  build configuration for AST2500 DMA UART driver
  DT nodes for AST2500 DMA UART driver
  defconfig and MAINTAINERS updated for AST2500 DMA UART driver
  Documentation: DT bindings AST2500 DMA UART driver

 .../bindings/serial/ast2500-dma-uart.txt      |   43 +
 MAINTAINERS                                   |   12 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   21 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   71 +-
 arch/arm/configs/aspeed_g5_defconfig          |    1 +
 .../tty/serial/8250/8250_ast2500_uart_dma.c   | 1901 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   45 +-
 drivers/tty/serial/8250/Makefile              |    1 +
 8 files changed, 2090 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/ast2500-dma-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_ast2500_uart_dma.c

-- 
2.17.1
