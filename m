From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 1/2] serial-core: skip call set_termios/console_start when no_console_suspend
Date: Sat, 21 Aug 2010 15:08:19 +0800
Message-ID: <1282374500-6531-2-git-send-email-jason77.wang@gmail.com>
References: <1282374500-6531-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43772 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab0HUHFD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Aug 2010 03:05:03 -0400
In-Reply-To: <1282374500-6531-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, arnd@arndb.de, sbrabec@suse.cz
Cc: linux-serial@vger.kernel.org

The commit 4547be7 rewrites suspend and resume functions, this
introduces a problem on the OMAP3EVM platoform. when the kernel boots
with no_console_suspend and we suspend the kernel, then resume it,
the serial console will be not usable. This problem should be common
for all platforms.
The cause for this problem is that when enter suspend, if we choose
no_console_suspend, the console_stop will be skiped. But in resume
function, the console port will be set to uninitialized state by
calling set_termios function and the console_start is called without
checking whether the no_console_suspend is set, Now fix it.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/serial/serial_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index cd85112..ff21200 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2065,7 +2065,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	/*
 	 * Re-enable the console device after suspending.
 	 */
-	if (uart_console(uport)) {
+	if (console_suspend_enabled && uart_console(uport)) {
 		uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		console_start(uport->cons);
-- 
1.5.6.5

