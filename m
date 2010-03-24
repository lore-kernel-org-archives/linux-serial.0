From: Toan Pham <tpham3783@gmail.com>
Subject: 8250 wrong IRQs set after boot
Date: Wed, 24 Mar 2010 11:38:18 -0400
Message-ID: <ffb2c0281003240838k7e2642ahffffb058e57cb0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:12480 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab0CXPiT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Mar 2010 11:38:19 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1911545qwh.37
        for <linux-serial@vger.kernel.org>; Wed, 24 Mar 2010 08:38:18 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I built a linux from scrach distro and setserial is not installed.

At boot up; all of the IRQ numbers for serial ports 1-4 are reported
correctly (according to the bios setting) from the bootup log.  They
are as followed.

ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 4) is a 16550A
ttyS2 at 0x03e8 (irq = 11) is a 16550A
ttyS3 at 0x02e8 (irq = 11) is a 16550A


However, after bootup, i login and looked at /proc/tty/driver/serial,
i noticed that all the IRQ for four serial ports

are wrong, and they as as follow:

ttyS0 to IRQ 4
ttyS1 to IRQ 3
ttyS2 to IRQ 4
ttyS3 to IRQ 3


as expected, serial ports ttyS1, ttyS2, and ttyS3 did not function
because the IRQs were reconfigured somehow.  I would like to know what
reconfigured the

IRQs since setserial is not installed in my distro.  I also checked
all the startup scripts in userspace and noticed that nothing would
have reconfigured
these ports.  I am thinking about installing setserial to my distro to
reconfigure the irqs back to the ones listed at bootup; however, I
would like to know

what caused them to change in the first place.


Thank you,


Toan
