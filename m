From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH] tty: amba-pl011: Use 32-bit accesses for SBSA UART
Date: Tue,  8 Mar 2016 00:43:19 -0500
Message-ID: <1457415800-8799-1-git-send-email-cov@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Andre Przywara <andre.przywara@arm.com>, Dave Martin <dave.martin@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <christopher.covington@linaro.org>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

From: Christopher Covington <christopher.covington@linaro.org>

Version 2 of the Server Base System Architecture (SBSA) describes the
Generic UART registers as 32 bits wide. At least one implementation, found
of the Qualcomm Technologies QDF2432, only supports 32 bit accesses. While
other implementations may also support smaller sized accesses, simply use
32 bit accesses all the time for the SBSA UART for simple, broad,
compatibility.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..ffb5eb8 100644
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
