From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH v3] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Fri,  1 Apr 2016 17:23:58 -0400
Message-ID: <1459545838-17646-1-git-send-email-cov@codeaurora.org>
References: <20160330165551.GB23817@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330165551.GB23817@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Dave Martin <dave.martin@arm.com>, Jim Perrin <jperrin@centos.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Timur Tabi <timur@codeaurora.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <cov@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Version 2 of the Server Base System Architecture (SBSAv2) describes UART
hardware registers as 32 bits wide, giving no guidance on access sizes. The
SBSA UART driver previously assumed partial-length 16 and 8 bit accesses would
work. But the SBSAv2 UART hardware on the Qualcomm Technologies QDF2432 only
supports full-length 32 bit register accesses, so use those exclusively. This
is compatible with SBSAv3, which explicitly requires UART hardware support 32
(and 16 and sometimes 8) bit accesses.

Tested on Juno, Midway, QDF2432, Seattle, and X-Gene 1.

Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
Changes since v2:
* Updated commit message
* Added Andre's Acked-by and Tested-by.
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7c198e0..a2aa655 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -121,6 +121,7 @@ static struct vendor_data vendor_arm = {
 
 static struct vendor_data vendor_sbsa = {
 	.reg_offset		= pl011_std_offsets,
+	.access_32b		= true,
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
