From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_bcm: For serdev case close serdev on failure to set power
Date: Mon, 22 Jan 2018 12:53:24 +0100
Message-ID: <20180122115325.28960-2-hdegoede@redhat.com>
References: <20180122115325.28960-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180122115325.28960-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

Commit 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
introduced error checking for the bcm_gpio_set_power() call in bcm_open()
but the error-path it introduces unsets dev->hu, which is correct for
platform_device instantiated bcm_dev-s but not for serdev instantiated
devs. For serdev instantiated devs serdev_device_close() should be called
instead (and dev->hu should be left set).

Cc: Lukas Wunner <lukas@wunner.de>
Fixes: 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 64800cd2796c..0438a64b8185 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -412,8 +412,11 @@ static int bcm_open(struct hci_uart *hu)
 	return 0;
 
 err_unset_hu:
+	if (hu->serdev)
+		serdev_device_close(hu->serdev);
 #ifdef CONFIG_PM
-	bcm->dev->hu = NULL;
+	else
+		bcm->dev->hu = NULL;
 #endif
 err_free:
 	mutex_unlock(&bcm_device_lock);
-- 
2.14.3

