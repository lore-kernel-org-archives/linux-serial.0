From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 2/3] ACPI: scan add call to probe amba devices
Date: Wed, 30 Sep 2015 11:38:49 +0100
Message-ID: <1443609530-21524-3-git-send-email-graeme.gregory@linaro.org>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

Call the amba device creation function in the default enumeration path,
this is the same location platform devices are probed.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f834b8c..aa3184e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1633,8 +1633,10 @@ static void acpi_default_enumeration(struct acpi_device *device)
 	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
 			       &is_spi_i2c_slave);
 	acpi_dev_free_resource_list(&resource_list);
-	if (!is_spi_i2c_slave)
+	if (!is_spi_i2c_slave) {
+		acpi_create_amba_device(device);
 		acpi_create_platform_device(device);
+	}
 }
 
 static const struct acpi_device_id generic_device_ids[] = {
-- 
2.4.3

