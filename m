From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Thu, 21 Mar 2013 11:21:29 +0000
Message-ID: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:33427
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755344Ab3CULWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 07:22:00 -0400
Received: from mail215-va3 (localhost [127.0.0.1])	by
 mail215-va3-R.bigfish.com (Postfix) with ESMTP id 98B59C0013D	for
 <linux-serial@vger.kernel.org>; Thu, 21 Mar 2013 11:21:59 +0000 (UTC)
Received: from VA3EHSMHS040.bigfish.com (unknown [10.7.14.254])	by
 mail215-va3.bigfish.com (Postfix) with ESMTP id A764EB60057	for
 <linux-serial@vger.kernel.org>; Thu, 21 Mar 2013 11:21:57 +0000 (UTC)
Content-Language: en-GB
Content-ID: <BAF99A2E03EFFE48A000816AAE083545@beamcommunications.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

I'm interested in having support for hardware handshaking lines for both pseudo-tty (Unix 98 style) and USB serial gadget drivers. Unless I've missed something, it looks as though they don't support the hardware handshaking lines.

Has anyone worked on this already, for either pseudo-tty or USB serial gadget?

It sounds as though people have done pseudo-ttys with HW handshaking support--eg tty0tty project. However I'd rather implement this function in the kernel pseudo-terminal driver itself. Is there any reason not to do that?


I was wondering how to handle the HW lines on the master side of the pseudo-tty, and on the USB gadget device. It's the opposite way to a regular serial port (DCE rather than DTE), so you _write_ DSR, CTS, DCD and RING, and _read_ DTR and RTS. There could be two ways to do this:

1) Reverse normal operations, so do TIOCMSET of TIOCM_DSR, TIOCM_CD etc.

2) Act like a normal port, and "cross-over" signals. So do
TIOCMSET of TIOCM_DTR, which changes DSR on the slave;
TIOCMGET of TIOCM_DSR to read the state of DTR set by the slave. Etc.
What about setting the slave's DCD and RING? Maybe do TIOCMSET of TIOCM_OUT1 and TIOCM_OUT2 on the master.

Same question for the USB serial gadget.

So which of those choices would be better? I think I prefer (2) because the user code stays more the same whether it's talking to a master device or slave device.

Regards,
Craig McQueen


