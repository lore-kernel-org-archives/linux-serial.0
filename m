From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
Date: Mon, 27 Feb 2017 21:24:36 -0600
Message-ID: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, cov@mykolab.com, manoj.iyer@canonical.com
List-Id: linux-serial@vger.kernel.org

For Qualcomm Technologies QDF2400 SOCs that are affected by
erratum E44, the ACPI oem_revision field is actually set to 1,
not 0.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/acpi/spcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 2b5d0fa..2051a8c 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -30,7 +30,7 @@ static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
 		return true;
 
 	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
-			h->oem_revision == 0)
+			h->oem_revision == 1)
 		return true;
 
 	return false;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
