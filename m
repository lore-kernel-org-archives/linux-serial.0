From: Petr Slansky <slansky@usa.net>
Subject: Problem: serial port loopback serious bug
Date: Thu, 22 Apr 2004 13:35:45 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <749iDVLjt7104S07.1082633745@uwdvg007.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cmsrelay02.mx.net ([165.212.11.111]:21956 "HELO
	cmsrelay02.mx.net") by vger.kernel.org with SMTP id S263953AbUDVLfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Apr 2004 07:35:50 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Description:

Command 'cat file >/dev/ttyS0' sends the same first 4096 bytes again and
again... I observe the bug in kernel 2.4.21 and 2.4.22, I guess this is
general problem in 2.4.xx kernel.

DETAILS:

I have generic serial port on i586 machine (PC). I created loopback cable
(TX-RX and RTS-CTS pins connected) and conected the cable to serial port
ttyS0. Simple serial port loopback.

Configuration:
#stty 38400 raw clocal crtscts </dev/ttyS0

Command in console1 (capture ttyS0 to file):
#cat /dev/ttyS0 > fileI.bin

Command in console2 (send a longer file to ttyS0):
#cat fileO.bin >/dev/ttyS0

The file fileO.bin have to be at least 4096 bytes long.

I guess you know what is expected result but I bet you don't know real
result under Linux. Si, I will tell you. Only first 4096 bytes are sent to
/dev/ttyS0. After that this sequence is read from /dev/ttyS0 again and
again..., even when no data are send to /dev/ttyS0 anymore. I tested this
sequence on FreeBSD 4.9 too and I had no problem with loopback like
this there. Something is seriosly wrong in kernel 2.4.x Is this know issue?
What about 2.6.x??

With regards,
Petr


---------------------------------
  Petr Slansky, slansky@usa.net
---------------------------------


