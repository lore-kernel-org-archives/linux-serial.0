From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Change to serial_core.c .... causing my serial driver problem
 Help Request
Date: Thu, 17 Apr 2008 19:19:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804171915180.6716@axis700.grange>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804160046460.6851@axis700.grange>
 <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
 <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
 <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com>
 <Pine.LNX.4.64.0804171657320.6716@axis700.grange>
 <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760889AbYDQRTB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 13:19:01 -0400
In-Reply-To: <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org

On Thu, 17 Apr 2008, vcgandhi1@aol.com wrote:

> When I switch to static Major and Minor numbers, the code started to work. So
> I believe the issue is with dynamic Major and Minor number.

I still don't understand. drivers/serial/jsm/jsm_driver.c does the same. 
But as it calls in its jsm_init_module:

uart_register_driver
tty_register_driver

where

	if (!driver->major) {
		error = alloc_chrdev_region(&dev, driver->minor_start,
						driver->num, driver->name);
		if (!error) {
			driver->major = MAJOR(dev);
			driver->minor_start = MINOR(dev);
		}

then it does get non-zero major and minor numbers. Doesn't this work for 
you?

Thanks
Guennadi
---
Guennadi Liakhovetski
