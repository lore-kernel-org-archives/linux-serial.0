From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V4 0/5] Add big-endian MMIO support to serial8250
Date: Thu,  9 Apr 2015 13:05:13 -0700
Message-ID: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

V3->V4:

Rebase on Linus' head of tree

Tweak documentation per Grant's request

Drop the of_earlycon patches in favor of Peter's series


Kevin Cernekee (5):
  of: Add helper function to check MMIO register endianness
  of/fdt: Add endianness helper function for early init code
  of: Document {little,big,native}-endian bindings
  serial: 8250: Add support for big-endian MMIO accesses
  serial: of_serial: Support big-endian register accesses

 .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
 drivers/of/base.c                                  | 23 +++++++++
 drivers/of/fdt.c                                   | 19 +++++++
 drivers/tty/serial/8250/8250_core.c                | 20 ++++++++
 drivers/tty/serial/8250/8250_early.c               |  5 ++
 drivers/tty/serial/of_serial.c                     |  3 +-
 include/linux/of.h                                 |  6 +++
 include/linux/of_fdt.h                             |  2 +
 8 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/common-properties.txt

-- 
2.2.2
