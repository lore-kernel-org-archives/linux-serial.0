From: "Alex Pavloff" <apavloff@esatechnology.com>
Subject: Token-passing protocol at 187.5KBaud
Date: Tue, 3 Feb 2004 09:48:40 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <662C51BFF387D9459C4281CD9A3F9D639FAE@tiber.internal.esatechnology.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:10973 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S266066AbUBCRsl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Feb 2004 12:48:41 -0500
Received: from tiber.internal.esatechnology.com (adsl-64-142-52-112.sonic.net [64.142.52.112])
	by b.mail.sonic.net (8.12.10/8.12.7) with ESMTP id i13Hmehi019040
	for <linux-serial@vger.kernel.org>; Tue, 3 Feb 2004 09:48:40 -0800
content-class: urn:content-classes:message
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi folks,

I've got a serial protocol (Siemens MPI) that I'm looking at, and I'm
wondering how difficult it would be to pull off I've got the data packet
format, so I'm not worried about that.  The protocol runs on a RS485
2-wire bus, and at 187,500bps.  There's also a requirement for a 300us
wait during a token passing sequence.  

Obviously, the main worry here is the fact that there's a non-standard
baud rate.  Now, I do have control over hardware -- we're running RS485
through our own UART on our own board, so that opens possibilities also.

Any advice or suggestions on the possibility of getting this to go?  

Thanks!

Alex Pavloff - apavloff@esatechnology.com
ESA Technology ---- www.esatechnology.com
------- Linux-based industrial HMI ------
-------- www.esatechnology.com/5k -------
