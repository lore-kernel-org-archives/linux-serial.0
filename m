From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH 0/4] *** 8250_dw ***
Date: Wed, 22 Jul 2015 12:34:55 +0300
Message-ID: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, gregkh@linuxfoundation.org, jslaby@suse.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Coming to use 8250_dw driver with my serial device I had few problems
I solved with following patch set.

First and fourth patches are aimed to support BIG endian device.
Second patch is is aimed to support device without test loop support.
Third patch is aimed to minimize chance for getting interrupt before
we called request_irq() during initialize probing.


Noam Camus (4):
  serial: 8250_dw: Add support for big-endian MMIO accesses
  serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on device tree
  serial: 8250_dw: Add UPF_FIXED_TYPE to flags
  serial: 8250_dw: use serial_in() and not readl()

 .../bindings/serial/snps-dw-apb-uart.txt           |    2 +
 drivers/tty/serial/8250/8250_dw.c                  |   61 +++++++++++++++++---
 2 files changed, 54 insertions(+), 9 deletions(-)
