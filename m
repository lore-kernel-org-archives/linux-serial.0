From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] tty: serial: msm: Fix module autoload
Date: Mon,  2 Jan 2017 11:57:20 -0300
Message-ID: <1483369040-21442-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/tty/serial/msm_serial.ko | grep alias
$

After this patch:

$ modinfo drivers/tty/serial/msm_serial.ko | grep alias
alias:          of:N*T*Cqcom,msm-uartdmC*
alias:          of:N*T*Cqcom,msm-uartdm
alias:          of:N*T*Cqcom,msm-uartC*
alias:          of:N*T*Cqcom,msm-uart

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/tty/serial/msm_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7312e7e01b7e..6788e7532dff 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1809,6 +1809,7 @@ static const struct of_device_id msm_match_table[] = {
 	{ .compatible = "qcom,msm-uartdm" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, msm_match_table);
 
 static struct platform_driver msm_platform_driver = {
 	.remove = msm_serial_remove,
-- 
2.7.4
