From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 3/4] ACPI: add definitions of DBG2 subtypes
Date: Mon, 29 Feb 2016 15:02:31 +0300
Message-ID: <1456747355-15692-4-git-send-email-aleksey.makarov@linaro.org>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org
List-Id: linux-serial@vger.kernel.org

The recent version of Microsoft Debug Port Table 2 (DBG2) [1]
specifies additional serial debug port subtypes.  These constants
are also referred by Serial Port Console Redirection Table (SPCR) [2]

Add these constants.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
[2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a4ef625..652f747 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -371,6 +371,11 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
+#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
+#define ACPI_DBG2_ARM_DCC           0x000F
+#define ACPI_DBG2_BCM2835           0x0010
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.7.1
