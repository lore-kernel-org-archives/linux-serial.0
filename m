From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 1/5] ACPI: change __init to __ref for early_acpi_os_unmap_memory()
Date: Mon, 15 Feb 2016 21:05:25 +0300
Message-ID: <1455559532-8305-2-git-send-email-aleksey.makarov@linaro.org>
References: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

early_acpi_os_unmap_memory() is marked as __init because it calls
__acpi_unmap_table(), but only when acpi_gbl_permanent_mmap is not set.

acpi_gbl_permanent_mmap is set in __init acpi_early_init()
so it is safe to call early_acpi_os_unmap_memory() from anywhere

We need this function to be non-__init because we need access to
some tables at unpredictable time--it may be before or after
acpi_gbl_permanent_mmap is set.  For example, SPCR (Serial Port Console
Redirection) table is needed each time a new console is registered.
It can be quite early (console_initcall) or when a module is inserted.
When this table accessed before acpi_gbl_permanent_mmap is set,
the pointer should be unmapped.  This is exactly what this function
does.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/osl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 67da6fb..8a552cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -497,7 +497,11 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
-void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
+/*
+ * acpi_gbl_permanent_mmap is set in __init acpi_early_init()
+ * so it is safe to call early_acpi_os_unmap_memory() from anywhere
+ */
+void __ref early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	if (!acpi_gbl_permanent_mmap)
 		__acpi_unmap_table(virt, size);
-- 
2.7.1
