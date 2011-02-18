From: Nico Becker <nico.becker@gmx.de>
Subject: MAX3107 driver faulty
Date: Fri, 18 Feb 2011 14:31:51 +0100
Message-ID: <4D5E74C7.3040700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64474 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1BRNbx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 08:31:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,
i want to use the MAX3107 driver,
thats included in the kernel 2.6.37.

I think the driver is faulty.

I have done several changes,
before the driver works rudimentary.

I have check the datasheet and found
inconsistence between chip and driver.

In AutoCTS AutoRTS Mode the Register
txdisable and rxdisable should be set.
But txdisable isnt set, so the max3107 sends
data even the cts signal is high.

The IntOscen Flag (enable internal Oscilator) is never set.

Different register write operations are done in one stream.
Example: http://lxr.free-electrons.com/ident?a=arm;i=max3107_register_init
But in the datasheet it is explained:
"If the SPI burst address is different to 0x00, the MAX3107
automatically increments the register address after each SPI data
byte."
So it is impossible to write in the register 0x1D, 0x1C, 0x1B
in one stream.
after the first address 0x1D the maxim increment the address
automatically to 0x1E.


Have somebody test the driver,
or have although trouble with the chip?

Because i am really new with the kernel hacking,
what are the next steps, build an patch?

thanks a lot
