From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv3 0/8] serial: 8250: 8250_dw changes and dmaengine support
Date: Thu, 10 Jan 2013 11:25:04 +0200
Message-ID: <1357809912-25790-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changes since v2:
- ACPI support for 8250_dw.c
- dmaengine API support for 8250

It looks like there are a few UART drivers that are more or less
identical with 8250.c except they include DMA support, so if we had
DMA support in 8250.c there may be no need for them. Since dmaengine
is now supported on most platforms, I decided to suggest this
solution.

I tried to make the DMA support as simple as I could. Single transfers
with single descriptors. This should be sufficient in most cases.


Heikki Krogerus (8):
  serial: 8250: Allow drivers to deliver capabilities
  serial: 8250_dw: Don't use UPF_FIXED_TYPE
  serial: 8250_dw: Map IO memory
  serial: 8250_dw: Move device tree code to separate function
  serial: 8250_dw: Set FIFO size dynamically
  serial: 8250_dw: Add ACPI 5.0 support
  serial: 8250: Add support for dmaengine
  serial: 8250_dw: Enable DMA support with ACPI

 drivers/tty/serial/8250/8250.c     |   53 ++++++--
 drivers/tty/serial/8250/8250.h     |   50 ++++++++
 drivers/tty/serial/8250/8250_dma.c |  213 +++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dw.c  |  248 ++++++++++++++++++++++++++++++------
 drivers/tty/serial/8250/Kconfig    |   10 +-
 drivers/tty/serial/8250/Makefile   |    1 +
 include/linux/serial_8250.h        |    4 +
 7 files changed, 532 insertions(+), 47 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dma.c

-- 
1.7.10.4
