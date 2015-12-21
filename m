From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 2/3] ACPI: scan add in amba probing
Date: Mon, 21 Dec 2015 19:41:37 +0300
Message-ID: <1450716100-13688-3-git-send-email-aleksey.makarov@linaro.org>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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
