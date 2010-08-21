From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH RESEND 2/2] serial-core: restore termios settings when resume console ports
Date: Sat, 21 Aug 2010 15:14:42 +0800
Message-ID: <1282374882-6651-3-git-send-email-jason77.wang@gmail.com>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
 <1282374882-6651-2-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44784 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab0HUHLZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Aug 2010 03:11:25 -0400
In-Reply-To: <1282374882-6651-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, sbrabec@suse.cz
Cc: linux-serial@vger.kernel.org

The commit 4547be7 rewrites suspend and resume functions. According
to this rewrite, when a serial port is a printk console device and
can suspend(without set no_console_suspend flag), it will definitely
call set_termios function during its resume, but parameter termios
isn't initialized, this will pass an unpredictable config to the
serial port. If this serial port is not a userspace opened tty device
, a suspend and resume action will make this serial port unusable.
I.E. ttyS0 is a printk console device, ttyS1 or keyboard+display is
userspace tty device, a suspend/resume action will make ttyS0
unusable.

If a serial port is both a printk console device and an opened tty
device, this issue can be overcome because it will call set_termios
again with the correct parameter in the uart_change_speed function.

Refer to the deleted content of commit 4547be7, revert parts relate
to restore settings into parameter termios. It is safe because if
a serial port is a printk console only device, the only meaningful
field in termios is c_cflag and its old config is saved in
uport->cons->cflag, if this port is also an opened tty device,
it will clear uport->cons->cflag in the uart_open and the old config
is saved in tty->termios.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/serial/serial_core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index ff21200..bc6cddd 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2066,6 +2066,18 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	 * Re-enable the console device after suspending.
 	 */
 	if (console_suspend_enabled && uart_console(uport)) {
+		/*
+		 * First try to use the console cflag setting.
+		 */
+		memset(&termios, 0, sizeof(struct ktermios));
+		termios.c_cflag = uport->cons->cflag;
+
+		/*
+		 * If that's unset, use the tty termios setting.
+		 */
+		if (port->tty && port->tty->termios && termios.c_cflag == 0)
+			termios = *(port->tty->termios);
+
 		uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		console_start(uport->cons);
-- 
1.5.6.5

