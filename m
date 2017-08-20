From: <sean.wang@mediatek.com>
Subject: [PATCH v3 0/2] serial: 8250: add support for MediaTek BTIF controller
Date: Mon, 21 Aug 2017 01:17:54 +0800
Message-ID: <cover.1503248851.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de, joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com, heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com, matthias.bgg@gmail.com, tthayer@opensource.altera.com
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Since v3:
- enhancing the definition of the compatible strings in dt-bindings

Since v2: 
- reusing 8250_of since the original driver has almost the same logic

This patchset introduces the support for MediaTek BTIF controller.

MediaTek BTIF controller is the serial interface similar to UART but it
works only as the digital device which is mainly used to communicate with
the connectivity module also called CONNSYS inside the SoC which could be
mostly found on those MediaTek SoCs with Bluetooth feature.

And the controller is made as being compatible with the 8250 register
layout so it tends to be integrated with existing 8250 core driver and
have no requirement for the modem configuration additionally such as the
baud rate calculation and assignment.

Sean Wang (2):
  dt-bindings: serial: 8250: Add MediaTek BTIF controller bindings
  serial: 8250: of: Add new port type for MediaTek BTIF controller on
    MT7622/23 SoC

 Documentation/devicetree/bindings/serial/8250.txt | 2 ++
 drivers/tty/serial/8250/8250_of.c                 | 2 ++
 drivers/tty/serial/8250/8250_port.c               | 8 ++++++++
 include/uapi/linux/serial_core.h                  | 3 +++
 4 files changed, 15 insertions(+)

-- 
2.7.4
