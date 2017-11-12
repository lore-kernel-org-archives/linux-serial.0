From: Matt Wilson <msw@linux.com>
Subject: [PATCH] serial: 8250_pci: Add Amazon PCI serial device ID
Date: Sun, 12 Nov 2017 14:14:06 -0800
Message-ID: <1510524846-18979-1-git-send-email-msw@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>, Matt Wilson <msw@amazon.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Matt Wilson <msw@amazon.com>

Cc: stable@vger.kernel.org
Signed-off-by: Matt Wilson <msw@amazon.com>
---
 drivers/tty/serial/8250/8250_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0c101a7..d4e7be8 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5137,6 +5137,9 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
 	{ PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000 },
 
+	/* Amazon PCI serial device */
+	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
-- 
2.7.4
