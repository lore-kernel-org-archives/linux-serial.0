From: "Michael Langford" <mlangford@tieronedesign.com>
Subject: sub-serial devices being created as block devices
Date: Fri, 14 Sep 2007 11:56:43 -0400
Message-ID: <3547473BFF99D74F875EEE3E38BCDDFF23A70A@tieroneserver.tier1design.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.tier1design.com ([68.16.98.218]:14917 "EHLO
	tieroneserver.tier1design.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbXINP4D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Sep 2007 11:56:03 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial Mailing List <linux-serial@vger.kernel.org>

When the kernel creates devices for usb-serial drivers in version
2.6.20.11, it creates them as block devices in the system:

[root@uclibc ~]# ls -la  /dev/ttyUSB0
brw-rw----    1 root     root     188,   0 Dec 31 17:00 /dev/ttyUSB0

This is happening for both prolific (pl2303) usb serial devices and our
custom one that we're developing.  

Any ideas on how to make this default to the correct type of device
node? 

I'm currently able to fix it with udev (as I'm really using a completely
different name for these), but I'd by and large prefer it not being
wrong in the first place.

           --Michael

-- 
Michael Langford
www.TierOneDesign.com

