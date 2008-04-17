From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Thu, 17 Apr 2008 18:58:52 -0400
Message-ID: <8CA6EF5BC26E069-12A0-1888@webmail-nc13.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171657320.6716@axis700.grange> <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171915180.6716@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-d21.mx.aol.com ([205.188.144.207]:59893 "EHLO
	imo-d21.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYDQW66 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 18:58:58 -0400
In-Reply-To: <Pine.LNX.4.64.0804171915180.6716@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

Guennadi,

My driver does the same as jsm_init_module. I would be very surprised 
if jsm actually worked with your change. You need to test it under 
suspend and resume condition.

My driver does the same uart_register_driver/tty_register_driver, but 
it looks like tty_register_driver sets the major address for the tty 
structure, but that does not get set back in the uart_driver structure. 
So uart_driver structure is still at zero.

To try to simplify this a little.

tty_register_driver will fill in the major and minor address in the 
following structure. struct tty_driver *driver

uart_register_driver input is struct uart_driver *drv. The value never 
gets set back into uart_driver and that is where you are looking to do 
the match.

To me this is either a bug in uart_register_driver for not propagating 
the value into uart_driver structure. But again it really did not 
matter since no one was looking at it till you modified the code.

Or your change should look at the tty_driver structure not the 
uart_driver structure, easy enough change. I do not think it is good 
for the lower level driver to fill in the value. It should not have to 
look at the tty structure it is suppose to be abstracted out.


Vipul

My recommendation is change you test driver to use 0 as the major 
address and do a suspend. It should crash.






-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Thu, 17 Apr 2008 10:19 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Thu, 17 Apr 2008, vcgandhi1@aol.com wrote:

> When I switch to static Major and Minor numbers, the code started to 
work. So
> I believe the issue is with dynamic Major and Minor number.

I still don't understand. drivers/serial/jsm/jsm_driver.c does the 
same.
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

then it does get non-zero major and minor numbers. Doesn't this work 
for
you?

Thanks
Guennadi
---
Guennadi Liakhovetski

