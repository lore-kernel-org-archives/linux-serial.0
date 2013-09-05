From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Linux Serial Code Problems
Date: Wed, 4 Sep 2013 23:06:29 -0400
Message-ID: <20130905030629.GB21268@thunk.org>
References: <30148664.203459.1378337936840.JavaMail.root@vznit170080>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:54819 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762253Ab3IEDGc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Sep 2013 23:06:32 -0400
Content-Disposition: inline
In-Reply-To: <30148664.203459.1378337936840.JavaMail.root@vznit170080>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roger Davis <rogerdavis@verizon.net>
Cc: linux-serial@vger.kernel.org

I haven't been the serial driver maintainer in many years, but here
are some quick tips.

1) I prefer using c-kermit to debug serial problems.  That's because
it doesn't do anything automatically.  You manually set the baud rate,
enable disable flow control, etc., using simple comamands.  I don't
like programs which automatically try to dial, or automatically try to
"configure the modem" etc., because that just confuses things.
C-kernel doesn't do any of this.  You can configure the modem
yourself, using AT commands.  And when you are debugging, that's
actually preferred.

2) The serial driver registeres the irq only when the tty is open, and
it drops the irq when the last file descriptor to the tty is closed.
This is a throwback to the ISA bus days, when there were limited
number of irq ports available, and various serial cards had hacks to
try to allow serial ports to share irq channels.  So don't use
/proc/interrupts to see if the irq was properly gathered.  Instead use
/proc/tty/driver/serial (or the setserial program) to see what port
and irq were assgiend.

3) If you can boot the older version of Ubuntu where the serial driver
worked, check the port and irq that was detected when it wored, and
compare it to a newer kernel in /proc/tty/driver/serial.  It may be
that the port and irq isn't properly getting configured.

4) The fact that the UART was automatically detected seems to indicate
that the port is correct and there is a UART answering.  What I would
suspect is either (a) there is some kind of interrupt set up problem,
or (b) there is some magic ACPI hack which Windows knows about but we
don't in Linux which is required to power up the modem board fully ---
this could be some weird power management thing...

Good luck, and I hope some of this is helpful,

     	      	   	       		  - Ted
