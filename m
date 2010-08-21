From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 0/2] two serial_core suspend/resume fixes--to
Date: Sat, 21 Aug 2010 15:08:18 +0800
Message-ID: <1282374500-6531-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43771 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab0HUHFD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Aug 2010 03:05:03 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, arnd@arndb.de, sbrabec@suse.cz
Cc: linux-serial@vger.kernel.org

The [1/2] fix this situation:
we set no_console_supend and console=ttyS0 to bootargs, then bootup
the kernel, the boot logs will print out from ttyS0. When we execute
echo mem > /sys/power/state, the system will suspend, we press a
key(or other wakeup trigger) to resume the system, but the ttyS0 can't
work anymore.

The [2/2] fix this situation:
we set console=ttyS0 to bootargs, then bootup the kernel, the boot
logs will print out from ttyS0, this time we set ttyS1 as tty and
login for shell. When we execute echo mem > /sys/power/state, the
system will suspend, we press a key(or other wakeup trigger) to
resume the system, but the ttyS0 can't work anymore.


