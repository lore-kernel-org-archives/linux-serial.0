From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 55/79] serial-core: power up uart port early before we do set_termios when resuming
Date: Wed, 26 Oct 2011 14:13:00 +0200
Message-ID: <1319631204-23262-55-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32824 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932926Ab1JZMNy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:54 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ning Jiang <ning.jiang@marvell.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Ning Jiang <ning.jiang@marvell.com>

The following patch removed uart_change_pm() in uart_resume_port():

commit 5933a161abcb8d83a2c145177f48027c3c0a8995
Author: Yin Kangkai <kangkai.yin@linux.intel.com>
    serial-core: reset the console speed on resume

It will break the pxa serial driver when the system resumes from suspend mode
as it will try to set baud rate divider register in set_termios but with
clock off. The register value can not be set correctly on some platform if
the clock is disabled. The pxa driver will check the value and report the
following warning:

------------[ cut here ]------------
WARNING: at drivers/tty/serial/pxa.c:545 serial_pxa_set_termios+0x1dc/0x250()
Modules linked in:
[<c0281f30>] (unwind_backtrace+0x0/0xf0) from [<c029341c>] (warn_slowpath_common+0x4c/0x64)
[<c029341c>] (warn_slowpath_common+0x4c/0x64) from [<c029344c>] (warn_slowpath_null+0x18/0x1c)
[<c029344c>] (warn_slowpath_null+0x18/0x1c) from [<c044b1e4>] (serial_pxa_set_termios+0x1dc/0x250)
[<c044b1e4>] (serial_pxa_set_termios+0x1dc/0x250) from [<c044a840>] (uart_resume_port+0x128/0x2dc)
[<c044a840>] (uart_resume_port+0x128/0x2dc) from [<c044bbe0>] (serial_pxa_resume+0x18/0x24)
[<c044bbe0>] (serial_pxa_resume+0x18/0x24) from [<c0454d34>] (platform_pm_resume+0x40/0x4c)
[<c0454d34>] (platform_pm_resume+0x40/0x4c) from [<c0457ebc>] (pm_op+0x68/0xb4)
[<c0457ebc>] (pm_op+0x68/0xb4) from [<c0458368>] (device_resume+0xb0/0xec)
[<c0458368>] (device_resume+0xb0/0xec) from [<c04584c8>] (dpm_resume+0xe0/0x194)
[<c04584c8>] (dpm_resume+0xe0/0x194) from [<c0458588>] (dpm_resume_end+0xc/0x18)
[<c0458588>] (dpm_resume_end+0xc/0x18) from [<c02c518c>] (suspend_devices_and_enter+0x16c/0x1ac)
[<c02c518c>] (suspend_devices_and_enter+0x16c/0x1ac) from [<c02c5278>] (enter_state+0xac/0xdc)
[<c02c5278>] (enter_state+0xac/0xdc) from [<c02c48ec>] (state_store+0xa0/0xbc)
[<c02c48ec>] (state_store+0xa0/0xbc) from [<c0408f7c>] (kobj_attr_store+0x18/0x1c)
[<c0408f7c>] (kobj_attr_store+0x18/0x1c) from [<c034a6a4>] (sysfs_write_file+0x108/0x140)
[<c034a6a4>] (sysfs_write_file+0x108/0x140) from [<c02fb798>] (vfs_write+0xac/0x134)
[<c02fb798>] (vfs_write+0xac/0x134) from [<c02fb8cc>] (sys_write+0x3c/0x68)
[<c02fb8cc>] (sys_write+0x3c/0x68) from [<c027c700>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 88289eceb4675b04 ]---

This patch fix the problem by adding the power on opertion back for uart
console when console_suspend_enabled is true.

Signed-off-by: Ning Jiang <ning.jiang@marvell.com>
Tested-by: Mayank Rana <mrana@codeaurora.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a32dc43..e562b12 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1975,6 +1975,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		if (port->tty && port->tty->termios && termios.c_cflag == 0)
 			termios = *(port->tty->termios);
 
+		if (console_suspend_enabled)
+			uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (console_suspend_enabled)
 			console_start(uport->cons);
-- 
1.7.7

