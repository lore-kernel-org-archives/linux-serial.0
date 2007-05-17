From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [linux-usb-devel] ark3116: receive returns negative
Date: Thu, 17 May 2007 16:51:09 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0705171646130.3231@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0705161743250.9570@yvahk01.tjqt.qr>
 <20070517124525.GC20055@kroah.com> <Pine.LNX.4.61.0705171529570.3231@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:36958 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965AbXEQOxl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2007 10:53:41 -0400
In-Reply-To: <Pine.LNX.4.61.0705171529570.3231@yvahk01.tjqt.qr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ark3116_driver@auctionant.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb-devel@lists.sourceforge.net


On May 17 2007 16:10, Jan Engelhardt wrote:
>Hi Greg,
>
>>But does the driver seem to work properly?
>>Do you get data through the device properly?

I have taken a voltmeter and an appropriate testcase program - and yes,
at least transmit works.

>USB-RS232-GenderChanger-RS232-USB.

A faulty setup that is. My bad.



	Jan
-- 
