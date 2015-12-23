From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 2/3] ACPI: scan add in amba probing
Date: Wed, 23 Dec 2015 17:19:41 +0300
Message-ID: <1450880383-29560-3-git-send-email-aleksey.makarov@linaro.org>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Add a new ACPI scan handler for AMBA devices.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78d5f02..20c8cba 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1922,6 +1922,7 @@ int __init acpi_scan_init(void)
 	acpi_memory_hotplug_init();
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
+	acpi_amba_init();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
-- 
2.6.4
