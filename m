From: Joseph Kogut <joseph.kogut@gmail.com>
Subject: [PATCH] tty: serial: Fixed misspelling of 'Medfield' in Kconfig
Date: Sun,  1 Mar 2015 00:39:02 -0700
Message-ID: <1425195542-3308-1-git-send-email-joseph.kogut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Joseph Kogut <joseph.kogut@gmail.com>
List-Id: linux-serial@vger.kernel.org

Change 'Medfile' to 'Medfield'

Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 drivers/tty/serial/mfd.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f0..7baf98c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -489,7 +489,7 @@ config SERIAL_MFD_HSU
 	select SERIAL_CORE
 
 config SERIAL_MFD_HSU_CONSOLE
-	bool "Medfile HSU serial console support"
+	bool "Medfield HSU serial console support"
 	depends on SERIAL_MFD_HSU=y
 	select SERIAL_CORE_CONSOLE
 
diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 8fe4501..97b0cf5 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1460,6 +1460,7 @@ static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081C) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081D) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081E) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x1191) },
 	{},
 };
 
-- 
2.3.1
