From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 0/3] Support MPS2 UART controller
Date: Mon, 25 Apr 2016 09:47:45 +0100
Message-ID: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, arnd@arndb.de, sudeep.holla@arm.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

These patches allow to use UART controller found on MPS2 platform.

Following [1], please, consider to merge them into tty/serial tree.

[1] https://lkml.org/lkml/2016/4/23/190

Thanks!

Vladimir Murzin (3):
  dt-bindings: document the MPS2 UART bindings
  serial: mps2-uart: add MPS2 UART driver
  serial: mps2-uart: add support for early console

 .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 +
 drivers/tty/serial/Kconfig                         |   13 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/mps2-uart.c                     |  625 ++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |    3 +
 5 files changed, 661 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
 create mode 100644 drivers/tty/serial/mps2-uart.c

-- 
1.7.9.5
