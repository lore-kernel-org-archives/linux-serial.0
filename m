From: Mateusz Holenko <mholenko@antmicro.com>
Subject: [PATCH 0/3] LiteUART serial driver
Date: Mon, 30 Sep 2019 15:03:52 +0200
Message-ID: <20190930130352.GA5898@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sam Ravnborg <sam@ravnborg.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Icenowy Zheng <icenowy@aosc.io>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-serial@vger.kernel.org

This patchset introduces support for LiteUART
- serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

 .../bindings/serial/litex,liteuart.txt        |  12 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/Kconfig                    |  30 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 382 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 7 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.txt
 create mode 100644 drivers/tty/serial/liteuart.c

-- 
2.23.0
