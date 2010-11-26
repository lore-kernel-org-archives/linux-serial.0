From: Daniel Drake <dsd@laptop.org>
Subject: 8250 Serial console unusable
Date: Fri, 26 Nov 2010 17:27:14 +0000
Message-ID: <AANLkTimGPcuksdcwq73rDT6V1Xpyjm2qBGVc5MTgej7t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54281 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0KZR1P (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Nov 2010 12:27:15 -0500
Received: by gxk22 with SMTP id 22so1044363gxk.19
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2010 09:27:15 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: jason77.wang@gmail.com, alan@linux.intel.com, arnd@arndb.de, sbrabec@suse.cz

Hi,

I see there's been a bit of recent turmoil in the area of serial
console, no_console_suspend, and suspend/resume:


commit 891b9dd10764352926e1e107756aa229dfa2c210
Author: Jason Wang <jason77.wang@gmail.com>
    serial-core: restore termios settings when resume console ports

commit ca2e71aa8cfb0056ce720f3fd53f59f5fac4a3e1
Author: Jason Wang <jason77.wang@gmail.com>
    serial-core: skip call set_termios/console_start when no_console_suspend

commit 3f582b8c11014e4ce310d9839fb335164195333f
Author: Arnd Bergmann <arnd@arndb.de>
    serial: fix termios settings in open

commit 4547be7809a3b775ce750ec7f8b5748954741523
Author: Stanislav Brabec <sbrabec@suse.cz>
    serial-core: resume serial hardware with no_console_suspend


OLPC runs with "console=ttyS0,115200 no_console_suspend" parameters in
order to receive all kernel messages, including the suspend/resume
ones. A userspace-level getty and terminal is also run on this
console.

For the XO-1.5 laptop (x86, VIA-based) there was some breakage around
2.6.35 but this is now working in linus master - thanks.

The XO-1 has always been trickier here and OLPC have applied some
downstream-only hacks once or twice in the past. But now I'd like to
get things working properly upstream.
As of linus master as of today on XO-1, the serial console after
resume is unusable, printing garbage. It looks like when we do go into
suspend, the power to the 8250 chip is cut, so it gets reset at
hardware level. This suggests that we do indeed need to restore
register state during resume, even though we never suspended it. It
looks like Stanislav works with machines with a similar requirement,
which I guess suffer the same problem in Linus master:


commit 4547be7809a3b775ce750ec7f8b5748954741523
Author: Stanislav Brabec <sbrabec@suse.cz>
    serial-core: resume serial hardware with no_console_suspend

    Perform a tricky suspend/resume even with no_console_suspend.

    With no_console_suspend, kernel skips serial port suspend/resume and the
    serial hardware may remain in undefined state after resume. It actually
    happens on devices that don't have BIOS that handle serial
    initialization. It makes impossible to use serial console after resume.

    Devices affected by this problem include:
    Sharp Zaurus devices
    Several PXA based ARM embedded boards


What's the right way to go around solving this, that doesn't step on
anyones toes?

>From an ignorant high-level perspective, it doesn't sound unreasonable
or complicated to simply unconditionally restore the correct port
configuration on resume. I'm having trouble understanding the argument
against this perspective presented in commit 891b9dd10.

Thanks,
Daniel
