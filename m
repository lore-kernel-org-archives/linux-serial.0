From: Amit Kucheria <akucheria@metricsystems.com>
Subject: CONFIG_HARD_PPS ?
Date: Thu, 17 Apr 2003 14:19:52 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1050614393.1501.14.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta2.algx.net ([67.92.168.231]:34612 "EHLO chimta01.algx.net")
	by vger.kernel.org with ESMTP id S261767AbTDQVMQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 17:12:16 -0400
Received: from amit.metricsystems.com
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx01.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.10 (built Jan 23 2003))
 with ESMTP id <0HDI002QCB8W8D@chimmx01.algx.net> for
 linux-serial@vger.kernel.org; Thu, 17 Apr 2003 16:19:44 -0500 (CDT)
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hi,

I have been studying the serial driver code and found the following
chunk of code in serial.c (2.4.19):

---------------------------------------------------------------
#ifdef CONFIG_HARD_PPS
			if ((info->flags & ASYNC_HARDPPS_CD) &&
			    (status & UART_MSR_DCD))
				hardpps();
#endif
---------------------------------------------------------------

There seems to be no reference to it in the current 2.4 and 2.5 kernels.
There are some reference in the 2.2 kernels. Is this cruft left from
previous versions?

Regards,
Amit

-- 
----------------------------------------------------------------------
Amit Kucheria          akucheria@NOSPAMmetricsystems.com
Metric Systems Corp.   2320 Cousteau Court, Suite 201, Vista, CA 92083
----------------------------------------------------------------------

