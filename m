From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: sharing UART
Date: Thu, 17 Sep 2009 12:46:30 +0530 (IST)
Message-ID: <751031.51650.qm@web94915.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web94915.mail.in2.yahoo.com ([203.104.17.192]:40908 "HELO
	web94915.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758582AbZIQHXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Sep 2009 03:23:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
I have searched through the archives, but did not find any example or need to share a UART by 2 drivers.

Basically there is a "hci_ldisc" line discipline driver which makes use of the UART which will be followed up by another driver with normal char dev exposed to user-space which needs to make use of UART as well.

So some-one somewhere would have wanted such an implementation right ?
what should be done ? any suggestions are welcome.

regards,
Pavan



      Add whatever you love to the Yahoo! India homepage. Try now! http://in.yahoo.com/trynew
