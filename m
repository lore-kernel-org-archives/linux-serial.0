From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v5 2/6] ACPI: add definitions of DBG2 subtypes
Date: Tue, 22 Mar 2016 13:46:29 +0300
Message-ID: <1458643595-14719-3-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, devel@acpica.org, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, "Zheng, Lv" <lv.zheng@intel.com>
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
2.7.4
