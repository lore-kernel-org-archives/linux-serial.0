From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH v2 0/5] tty/serial: atmel_serial: Device Tree support
Date: Wed, 12 Oct 2011 18:06:55 +0200
Message-ID: <1318435620-7481-1-git-send-email-nicolas.ferre@atmel.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, claudio@evidence.eu.com, jesper.nilsson@axis.com, alan@lxor
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

The goal of this patch series is to add device tree support to Atmel USART
driver: atmel_serial.
As this driver support RS485 mode, generic RS485 bindings have been added.

Some modifications are also included to ease the transition to parameter
settings comming from device tree.
The enumeration of ports is enhanced to be able to deal with several types
of port numbering: platform data, device tree or automatic.

Nicolas Ferre (5):
      tty/serial: RS485 bindings for device tree
      tty/serial: atmel_serial: change platform_data variable name
      tty/serial: atmel_serial: whitespace and braces modifications
      tty/serial: atmel_serial: auto-enumerate ports
      tty/serial: atmel_serial: add device tree support

 Documentation/devicetree/bindings/serial/rs485.txt |   31 +++++
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   27 +++++
 Documentation/serial/serial-rs485.txt              |    5 +
 drivers/tty/serial/atmel_serial.c                  |  122 +++++++++++++++++---
 4 files changed, 170 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
