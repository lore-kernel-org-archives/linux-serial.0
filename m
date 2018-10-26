From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 0/9] serial: Add Tegra Combined UART driver
Date: Fri, 26 Oct 2018 13:16:29 +0200
Message-ID: <20181026111638.10759-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

this is a reworked version of Mikko's earlier proposal[0]. I've reworked
the TCU driver itself so that it relies less on global variables as well
as added a Kconfig option to allow the console support to be selected. I
also fixed a couple of issues that manifested themselves as I was moving
towards the IRQ driven mode (TCU was passing a pointer to a local
variable which was getting stored in the mailbox's ring buffer and the
data pointed at was becoming stale by the time the mailbox got around to
dequeue it).

The biggest bulk of the changes is in the mailbox driver. This series
addresses all of Jassi's comments from back at the time. One notable
additional change is that shared mailboxes are now interrupt driven,
which removes the need for polling mode.

Unfortunately there is still an issue because the TCU uses the mailbox
in atomic context for both TTY and console modes, so we get a sleeping-
while-atomic BUG when using mbox_client->tx_block = true in order to
rate-limit mbox_send_message(). In order to work around this, I added a
mechanism to mbox_send_message() that will allow blocking from atomic
context if the mailbox controller implements the new ->flush() callback.
For Tegra HSP shared mailboxes this is done by spinning on the shared
mailbox register until the receiver has marked the mailbox as empty. I
have been running this locally for a couple of days now and it works
perfectly.

Furthermore this series incorporates Mikko's work in progress on
splitting up the mailbox controllers and allowing multiple controllers
to match on the same device tree node during mbox_request_channel().

Last but not least there are no build-time dependencies between the
mailbox and serial drivers, so I think the easiest way to merge this is
if Jassi picks up patches 1-5, Greg takes patches 6 & 7 and I pick up
patches 8-9 into the Tegra tree.

Thanks,
Thierry

[0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=357641

Mikko Perttunen (5):
  mailbox: Allow multiple controllers per device
  dt-bindings: tegra186-hsp: Add shared interrupts
  dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
  arm64: tegra: Add nodes for TCU on Tegra194
  arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888

Thierry Reding (4):
  mailbox: Support blocking transfers in atomic context
  mailbox: tegra-hsp: Add support for shared mailboxes
  mailbox: tegra-hsp: Add suspend/resume support
  serial: Add Tegra Combined UART driver

 .../bindings/mailbox/nvidia,tegra186-hsp.txt  |   3 +
 .../bindings/serial/nvidia,tegra194-tcu.txt   |  35 ++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  38 +-
 drivers/mailbox/mailbox.c                     |  11 +-
 drivers/mailbox/tegra-hsp.c                   | 495 +++++++++++++++---
 drivers/tty/serial/Kconfig                    |  22 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/tegra-tcu.c                | 299 +++++++++++
 include/linux/mailbox_controller.h            |   4 +
 include/uapi/linux/serial_core.h              |   3 +
 11 files changed, 847 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 create mode 100644 drivers/tty/serial/tegra-tcu.c

-- 
2.19.1
