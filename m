From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 0/8] Tegra Combined UART driver
Date: Mon, 2 Jul 2018 14:40:25 +0300
Message-ID: <20180702114033.15654-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Hi, here's v3. Changes are in individual patches. Acks are still
missing from the following patches:

mailbox: Add transmit done by blocking option
mailbox: tegra-hsp: Refactor in preparation of mailboxes
mailbox: tegra-hsp: Add support for shared mailboxes
serial: Add Tegra Combined UART driver

Thanks,
Mikko

Original message:

Hi all,

on Tegra194, the primary console UART is the "Tegra Combined UART",
or TCU. This is a "virtual UART", where each consumer communicates
with a central implementation over mailboxes. The central
implementation then multiplexes the streams and arbitrates use of
a hardware serial port. This driver implements the consumer portion
to allow using the primary console.

The series is split into the following parts:
* patches 1 and 2 add the device tree bindings for mailbox and tcu
  itself.
* patch 3 adds a blocking transmission option to the mailbox
  framework.
* patches 4 and 5 add support for the "shared mailbox" primitive
  to the Tegra HSP driver.
* patch 6 adds the TCU driver itself
* patches 7 and 8 do the necessary device tree changes.

The series has been tested on the Tegra194 P2972 board.

Mikko Perttunen (8):
  dt-bindings: tegra186-hsp: Add shared interrupts
  dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
  mailbox: Add transmit done by blocking option
  mailbox: tegra-hsp: Refactor in preparation of mailboxes
  mailbox: tegra-hsp: Add support for shared mailboxes
  serial: Add Tegra Combined UART driver
  arm64: tegra: Add nodes for tcu on Tegra194
  arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888

 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   3 +
 .../bindings/serial/nvidia,tegra194-tcu.txt        |  35 +++
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  34 ++-
 drivers/mailbox/mailbox.c                          |  30 +-
 drivers/mailbox/mailbox.h                          |   1 +
 drivers/mailbox/tegra-hsp.c                        | 320 +++++++++++++++++----
 drivers/tty/serial/Kconfig                         |   9 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/tegra-tcu.c                     | 291 +++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 11 files changed, 661 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 create mode 100644 drivers/tty/serial/tegra-tcu.c

-- 
2.16.1
