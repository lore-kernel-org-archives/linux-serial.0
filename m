From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v2 2/2] serdev: Update drivers/bluetooth/Kconfig for ACPI
 serdev support
Date: Sun, 8 Oct 2017 14:20:21 +1100
Message-ID: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>, gustavo@padovan.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, frederic.danis.oss@gmail.com, robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for serdev. This is only possible if serdev support is compiled in as the code hooks into TTY. Otherwise PM will silently break as the corresponding platform devices would no longer be registered and as the tty class device is also gone and hciattach (btattach) will also fail.

This patch set addresses this by making BT_HCIUART_BCM dependent on SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fae5a74dc737..8d432ee9f4bd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -171,6 +171,7 @@ config BT_HCIUART_BCM
 	depends on BT_HCIUART_SERDEV
 	select BT_HCIUART_H4
 	select BT_BCM
+	select SERIAL_DEV_CTRL_TTYPORT
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
 	  port interface for Broadcom Bluetooth controllers.
-- 
2.11.0
