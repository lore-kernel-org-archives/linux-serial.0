From: Philip Rakity <prakity@marvell.com>
Subject: serial: serial_core.c question
Date: Wed, 13 Jul 2011 21:58:07 -0700
Message-ID: <2C1F39BE-B4CD-47AA-BA22-BA2FCD0532CB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46759 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab1GNFAr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jul 2011 01:00:47 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "dsaxena@laptop.org" <dsaxena@laptop.org>, Daniel Drake <dsd@laptop.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>


commit 891b9dd10764352926e1e107756aa229dfa2c210
Author: Jason Wang <jason77.wang@gmail.com>
Date:   Sat Aug 21 15:14:42 2010 +0800


In patch ba15ab0e8de
Set proper console speed on resume

the patch removed the uart_change_pm(state, 0); in the patch below.  

On a pxa168 this causes the clock to not be enabled
when termios is called and we do not update the DLL register.

Have you seen this ?

NOTE:  This code was back ported into 2.6.34 and the power management may be so different
that the clk is enabled.  This is hard for me to test.

This is the reason for the question

regards,

Philip

    serial-core: restore termios settings when resume console ports
    
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
    Acked-by: Stanislav Brabec <sbrabec@suse.cz>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

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




