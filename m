From: Philip Oberstaller <Philip.Oberstaller@septentrio.com>
Subject: Printf hangs when internal buffer of driver is temporarily full
Date: Mon, 14 Jan 2013 14:11:31 +0100
Message-ID: <50F40403.9040000@septentrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server2.septentrio.com ([194.78.112.130]:41120 "HELO
	barracuda.septentrio.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1756151Ab3ANNYP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 08:24:15 -0500
Received: from SRVWIN14.Septentrio.local ([192.168.50.85]) by barracuda.septentrio.com with ESMTP id iYTIIS8k8Jv5n2Rp for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2013 14:11:31 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm writing a driver for the Exar's XR20M1280 SPI-based serial port
using kernel version 3.4.17.

If a string, which is considerably longer than the driver's internal buffer
(512 bytes), is written with printf/fprintf to the dedicated port, then the
function call hangs after the driver's write_room function returns zero,
which happens when the driver's internal buffer is temporarily full.
I would have expected that the TTY layer or the libc implementation of
printf would requery write_room automatically and thus would notice
after a while that there is space again, but this doesn't seem to happen.
Eventually the printf function returns after a very long timeout but without
that the remaining characters have been printed.

I based my code mainly on the ifx6x60-driver and I looked at other similar
drivers as well, but I can't see that they are using a different strategy.

In a dated driver book it was suggested that write_room and write should
always return at least one. I could use busy waiting in the write function
until there is space for at least one character, but I hope that there is
a better solution around?!

Thanks,
Philip

[Please CC me, I'm not on the list]

________________________________

This e-mail communication contains information that is confidential and may also be privileged. It is intended for the exclusive use of the addressees. If you are not the person or organization to whom it is addressed, you must not copy, distribute or take any action in reliance upon it. If you received this communication in error, please notify Septentrio nv immediately [ telephone +32 [0] 16 300800 ]. Septentrio nv will not accept liability for contractual commitments made by individuals employed by this company outside the scope of our business.
