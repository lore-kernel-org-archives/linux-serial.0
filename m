From: =?iso-8859-1?q?suresh=20shenoy?= <msureshshenoy@yahoo.co.in>
Subject: Serial port read working but not write.
Date: Thu, 22 Jul 2004 17:48:03 +0100 (BST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web8206.mail.in.yahoo.com ([203.199.70.75]:58291 "HELO
	web8206.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S266913AbUGVTTg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jul 2004 15:19:36 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

   I am currently using redhat linux 9.0. I am working
with a hardware which senses some data and sends back
to the PC through serial port. It also can move a dc
motor using the same hardware. I am using POSIX serial
port programming for talking with the board. After
some struggles i was able to read the data from the
hardware device. But my current problem is that it is
not moving the motor when i send a command to the
hardware. Does anyone know the solution to this
problem. Please let me know if any piece of code or
any more information is required that i can furnish.

Thanks & Regards,
Suresh M Shenoy.

________________________________________________________________________
Yahoo! India Careers: Over 65,000 jobs online
Go to: http://yahoo.naukri.com/
