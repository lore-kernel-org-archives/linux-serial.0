From: Michael Anderson <mjanders@us.ibm.com>
Subject: [PATCH] linux-2.6.2-rc3 Add icom serial device driver
Date: Fri, 6 Feb 2004 14:12:28 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <OFF4CA2E9C.4E3C6DF3-ON86256E32.006E5604-86256E32.006F107D@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29645 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265609AbUBFUM7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Feb 2004 15:12:59 -0500
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

I am posting the icom serial device driver code and supporting kernel
changes for submission to the linux kernel.  The icom serial
device driver enables linux to use a family of IBM iSeries serial
adapters.  The serial adapters supported by icom are intelligent adapters
that provide multiport serial access via iSeries RS232 cables on some
adapters or via internal modems on other adapters.  Today the icom device
driver only uses the family of adapters for asynchronous communications.

Please review this code for submission.

Please respond cc to mjanders@us.ibm.com.

The patch can be found at:

http://www-124.ibm.com/linux/patches/misc/icom-2.6.2-rc3.notrace.patch

