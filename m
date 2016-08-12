From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [Patch v2 0/3] misc: pch_phub: Add quirks for MIPS Boston platform
Date: Fri, 12 Aug 2016 12:48:51 +0100
Message-ID: <1471002534-10673-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-serial@vger.kernel.org

Hi,

These are a few patches for using the EG20T UART on the Imagination
Technologies Boston development platform

2 quirks needed
- Pass a specific value for the prefetch register from DT instead of using
the hard-coded default.
- Add a quirk for using the internal 25MHz clock source for the UART block

The patches for Boston platform are inflight.
https://patchwork.kernel.org/patch/8200941/

So pasting a DT node snippet here.

+                                       eg20t_pch@2,0,0 {
+                                               compatible = "pci8086,8801";
+                                               reg = <0x00020000 0 0 0 0>;
+
+                                               intel,eg20t-prefetch = <0>;
+                                       };
+                                       eg20t_uart0@02,10,1 {
+                                               compatible = "pci8086,8811";
+                                               reg = <0x00025100 0 0 0 0>;
+
+                                               clock-frequency = <25000000>;
+                                       };

Suggestions and feedback welcome.

Based on v4.8-rc1

Regards,
ZubairLK

Zubair Lutfullah Kakakhel (3):
  misc: pch_phub: Read prefetch value from device tree if passed
  misc: pch_phub: Add UART_CLK quirk for Boston platform
  serial: pch_uart: Add support for reading clock-frequency from DT

 drivers/misc/pch_phub.c       | 20 +++++++++++++++++++-
 drivers/tty/serial/Kconfig    |  2 +-
 drivers/tty/serial/pch_uart.c |  5 +++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.9.1
