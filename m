From: "Michael V. David" <michael@newearth.org>
Subject: RocketModemII under Linux kernel 2.6.0-test8
Date: Sun, 19 Oct 2003 07:57:08 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <bmtu61$be7$1@sea.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:12457 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262106AbTJSMA1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Oct 2003 08:00:27 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1ABCEU-0004mw-00
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2003 14:00:26 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have two RocketModemII 4-modem PCI boards installed in a PC clone running
Linux kernel 2.6.0-test8, using the Rocket driver included with the kernel,
compiled as a module, as recommended in Comtrol's documentation. I have the
latest software from the Comtrol site (v2.04/1800024H.tgz). The rc.rocket
script runs on startup, and finds all 8 ports. The firmware is uploaded. The
active lines can be opened with minicom, and act like serial lines with
modems attached, responding appropriately to the documented AT commands.
Normally, I run mgetty to allow tty logins on some of the modem lines.
Nothing in the kernel files or the Comtrol software has been changed from
the defaults.

When I dial in with a terminal program, the line is answered and I can log
in. I use the bash shell. If I type a command line that produces less than
256 bytes of output, I get the expected output. If it produces more than 256
bytes of output, I get approximately 256 bytes of the expected output, and
then something else. The something else seems to be contents of the
computer's memory, such as parts of the mgetty program.

It seems to be going past the end of a buffer somewhere. I'd like to hear
what anyone knows about this. Using only one RocketModemII board, rather
than two, does not alter this behavior.

The two 16550A serial ports on the same machine work perfectly.

--mvd



