From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: installing line discipline from kernel
Date: Thu, 8 Oct 2009 10:03:54 +0530 (IST)
Message-ID: <430561.16988.qm@web94909.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web94909.mail.in2.yahoo.com ([203.104.17.168]:36603 "HELO
	web94909.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751584AbZJHEed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Oct 2009 00:34:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

Can I open up a serial device and install the line discipline from kernel space ?
We have a situation where in an application would try and access a character device node, on "open" file op on such a char device node, a particular line discipline needs to be installed.
[Can't change the application, but the line discipline driver which also exposes a character driver is subject to change]

Thanks & Regards,
Pavan Savoy


      Keep up with people you care about with Yahoo! India Mail. Learn how. http://in.overview.mail.yahoo.com/connectmore
