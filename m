From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [RFC v2 3/4] ACPI: DBG2: add 16550 UART with 32-bit access
Date: Tue,  6 Dec 2016 23:58:28 +0600
Message-ID: <20161206175830.6989-4-aleksey.makarov@linaro.org>
References: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org
List-Id: linux-serial@vger.kernel.org

It was suggested to add a new Microsoft Debug Port Table 2
(DBG2) (the table used to enumerate the various subtypes of serial
port covered by the SPCR) 16550 UART subtype that may be needed for
some additional platforms, such as those based upon AppliedMicro
X-Gene ARMv8 SoCs.  This new subtype would be 16550-compatible
with 32-bit access.  There already exists 32-bit variant
ACPI_DBG2_ARM_SBSA_32BIT of SBSA console ACPI_DBG2_ARM_SBSA_GENERIC.

This patch introduces it to Linux kernel.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c93dbad..f219b04 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -371,6 +371,7 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_16550_32BIT       0x0002
 #define ACPI_DBG2_ARM_PL011         0x0003
 #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
-- 
2.10.2
