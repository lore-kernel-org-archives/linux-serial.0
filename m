From: Kiran Padwal <kiran.padwal21@gmail.com>
Subject: [PATCH] tty: serial: msm: Make of_device_id array const
Date: Wed, 23 Jul 2014 15:56:26 +0530
Message-ID: <1406111186-16627-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, gregkh@linuxfoundation.org
Cc: dwalker@fifo99.com, bryanh@codeaurora.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kiran.padwal@smartplayin.com
List-Id: linux-serial@vger.kernel.org

Make of_device_id array const, because all OF functions handle it as const.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/tty/serial/msm_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 6baf2ad..f4a85b8 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1073,7 +1073,7 @@ static int msm_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id msm_match_table[] = {
+static const struct of_device_id msm_match_table[] = {
 	{ .compatible = "qcom,msm-uart" },
 	{ .compatible = "qcom,msm-uartdm" },
 	{}
-- 
1.7.9.5
