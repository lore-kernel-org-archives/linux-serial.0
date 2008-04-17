From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Thu, 17 Apr 2008 12:06:34 -0400
Message-ID: <8CA6EBC237868E0-15A8-85E8@webmail-nb06.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E482AE34A65-15A8-47A5@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171652010.6716@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-m22.mx.aol.com ([64.12.137.3]:47976 "EHLO
	imo-m22.mail.aol.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761288AbYDQQHE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 12:07:04 -0400
In-Reply-To: <Pine.LNX.4.64.0804171652010.6716@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

Guennadi,

I think the problem is with dynamic Major and Minor Addresses.


This is the code from serial_core.c ...

"
static int serial_match_port(struct device *dev, void *data)
{
    struct uart_match *match = data;
    dev_t devt = MKDEV(match->driver->major, match->driver->minor) + 
match->port->line;

    return dev->devt == devt; /* Actually, only one tty per port */
}
"

Well when you uses Dynamic Major and Minor number you set it equal to 0 
in the driver structure of the UART.

Example.

"
static struct uart_driver uart_driver = {
    .owner                  = THIS_MODULE,
    .driver_name            = "msm_serial",
    .dev_name               = "ttyS0",
    .major                  = 0, /* tty layer will assign the major id */
    .minor                  = 0,
    .nr                     = UART_MAX_COUNT,
    .cons                   = uart_console,
};

"

You match function does not work. At least this is my thoughts.  What 
do you think.

Can you try to use  Dynamic Major and Minor address and see if you 
driver works.


Thank You
Vipul







-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Thu, 17 Apr 2008 7:55 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Wed, 16 Apr 2008, vcgandhi1@aol.com wrote:

> I do the same
>
> port->dev   = &dev->dev;
>
> But I am not sure &dev->dev points to the parent. I think it points 
to the
> device it's self, but I may be wrong.  I have tried port->dev = 
&dev->dev as
> well as port->dev = dev->dev.parent.

It depends on what your "dev" is, and this is driver-specific. So,
unfortunately, I don't think I'll be able to help you any further 
without
seeing the sources.

> One of these found something when the
> port was TTYS0 but did not work when the port was TTYS2.
>
> Did you test with a non zero port->line. I working on ttyS2.

Yes, I tested it with ttyS0 and ttyS1.

> Just trying to narrow down what could be wrong. It just that
> tty_dev = device_find_child(port->dev, &match, serial_match_port);
>
> is returning NULL for me.
>
> Thank You for your help.
> Vipul
>
> PS. One quick suggestion you may want to check the return value and 
verify it
> is non-NULL before using it. Makes it easier to debug the code. ...

Feel free to submit a patch.

Thanks
Guennadi
---
Guennadi Liakhovetski

