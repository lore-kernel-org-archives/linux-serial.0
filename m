From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 0/3] UART driver for Conexat Digicolor SoCs
Date: Thu, 18 Dec 2014 21:45:22 +0200
Message-ID: <cover.1418930377.git.baruch@tkos.co.il>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This set of patches adds a driver for the peripheral known as USART of the
Conexant CX92755 SoC. The CX92755 is one an ARM based SoC series known as
Digicolor. USART apparently stands for Universal Synchronous/Asynchronous
Receiver/Transmitter. Besides plain UART, the USART can also do SPI and
I2S. Here we only add a UART driver, others may follow later.

CX92755 is based on Cortex-A8. I plan to post ARM basic platform support code
(along with clocksource and interrupt controller drivers) in the coming few
days.

Baruch Siach (3):
  devicetree: bindings: add Conexant vendor prefix
  serial: driver for Conexant Digicolor USART
  serial: add device tree binding documentation for Conexant USART

 .../devicetree/bindings/serial/digicolor-usart.txt |  27 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/tty/serial/Kconfig                         |  15 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/digicolor-usart.c               | 563 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt
 create mode 100644 drivers/tty/serial/digicolor-usart.c

-- 
2.1.3
