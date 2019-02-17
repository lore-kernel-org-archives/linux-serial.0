From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] tty: serial: msm_serial: Remove __init from msm_console_setup()
Date: Sat, 16 Feb 2019 22:05:52 -0700
Message-ID: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Due to the complexities of modern Qualcomm SoCs, about a half dozen drivers
must successfully probe before the clocks for the console are present, and
the console can successfully probe.  Depending on several random factors
such as probe order and modules vs builtin, msm_serial may not be able to
successfully probe for some, at which point, __init annotated functions
may become unmapped.  If this occurs, msm_console_setup() will be called
from the probe path, but will no longer exist, resulting in a kernel
panic.

Resolve this issue by removing the __init annotation from
msm_console_setup().

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 736b74f..1090960 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1634,7 +1634,7 @@ static void msm_console_write(struct console *co, const char *s,
 	__msm_console_write(port, s, count, msm_port->is_uartdm);
 }
 
-static int __init msm_console_setup(struct console *co, char *options)
+static int msm_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
