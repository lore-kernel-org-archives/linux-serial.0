From: Hikaru1@verizon.net
Subject: 8250/16550 serial driver not being installed if set modular
Date: Tue, 15 Nov 2005 06:56:13 -0500
Message-ID: <20051115115613.GA10399@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:50654 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932377AbVKOL4Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Nov 2005 06:56:16 -0500
Received: from roll.roll ([70.22.139.174])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IPZ00BAEVTR0QX9@vms046.mailsrvcs.net> for
 linux-serial@vger.kernel.org; Tue, 15 Nov 2005 05:56:16 -0600 (CST)
Content-disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk

Hi, I'm emailing you to report a bug with the serial driver in linux kernel
2.6.14.2, you are listed as the maintainer in the MAINTAINERS file, so if
I've sent you this bug report in error please tell me where I should be
sending it.

I'm using slackware 10.2 on a AMD K7 (XP 2600) this is a 32bit i386
compatible machine.

in 2.6.14.2's menuconfig, under Device Drivers->Character devices->Serial
drivers if I select the option 8250/16550 and compatible serial support to
be compiled into the kernel, it works fine. If I select it to compile as a
module, the module 'serial' is not installed when I do make modules_install.
I'm also pretty sure it's not being compiled at all when selected to be
compiled as a module.

Just to be clear, the help for that option specifically says the module will
be named 'serial' if the name's wrong, could you tell me what it is named?

I don't know what's wrong with it, nor where to check. Could you give me
some pointers on what to check so I can give you more information? I
really prefer to have as much as I can as modules as my computer has to boot
using a floppy disk.

Timothy C. McGrath
