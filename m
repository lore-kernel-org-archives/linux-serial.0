From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: [PATCH] Re: [linux-usb-devel] ark3116: receive returns negative
Date: Thu, 17 May 2007 17:16:44 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0705171704230.3231@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0705161743250.9570@yvahk01.tjqt.qr>
 <20070517124525.GC20055@kroah.com> <Pine.LNX.4.61.0705171529570.3231@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0705171646130.3231@yvahk01.tjqt.qr> <20070517145849.GA3282@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:58915 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbXEQPTS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 May 2007 11:19:18 -0400
In-Reply-To: <20070517145849.GA3282@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ark3116_driver@auctionant.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb-devel@lists.sourceforge.net


On May 17 2007 07:58, Greg KH wrote:
>On Thu, May 17, 2007 at 04:51:09PM +0200, Jan Engelhardt wrote:
>> On May 17 2007 16:10, Jan Engelhardt wrote:
>> >Hi Greg,
>> >
>> >>But does the driver seem to work properly?
>> >>Do you get data through the device properly?
>> 
>> I have taken a voltmeter and an appropriate testcase program - and yes,
>> at least transmit works.
>> 
>> >USB-RS232-GenderChanger-RS232-USB.
>> 
>> A faulty setup that is. My bad.
>
>You forgot the NULL modem inverter :)

Yeah I figured. Screw this legacy tech... Anyway here is the patch
for that printk:

---

Subject: Fix debug output of ark3116

Fix debug output. Previously, it would output "0xFFFFFFB0" on 32-bit 
archs (and probably "0xFFFFFFFFFFFFFFB0" on 64-bits), because buf is 
taken as signed char, which is promoted to signed int, while %x always 
expects an unsigned int.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

---
 drivers/usb/serial/ark3116.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/usb/serial/ark3116.c
===================================================================
--- linux-2.6.orig/drivers/usb/serial/ark3116.c
+++ linux-2.6/drivers/usb/serial/ark3116.c
@@ -63,7 +63,8 @@ static inline void ARK3116_RCV(struct us
 				 request, requesttype, value, index,
 				 buf, 0x0000001, 1000);
 	if (result)
-		dbg("%03d < %d bytes [0x%02X]", seq, result, buf[0]);
+		dbg("%03d < %d bytes [0x%02X]", seq, result,
+		    ((unsigned char *)buf)[0]);
 	else
 		dbg("%03d < 0 bytes", seq);
 }
