From: Chuck Messenger <chuckm@rochester.rr.com>
Subject: Re: low_latency flag
Date: Fri, 21 Nov 2003 18:37:32 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <bpm6vr$86c$1@sea.gmane.org>
References: <11E89240C407D311958800A0C9ACF7D1A34049@EXCHANGE> <3FBD7CD7.1060902@rochester.rr.com> <bpm18m$73f$1@sea.gmane.org> <20031121224338.GI1037@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:7630 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261744AbTKUX0y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2003 18:26:54 -0500
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1ANKft-0004aa-00
	for <linux-serial@vger.kernel.org>; Sat, 22 Nov 2003 00:26:53 +0100
In-Reply-To: <20031121224338.GI1037@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Fri, 2003-11-21 16:59:50 -0500, Chuck Messenger <chuckm@rochester.rr.com>
> wrote in message <bpm18m$73f$1@sea.gmane.org>:
> 
>>Luckily, I happened to notice a recent message on this list with the 
>>word "low_latency".  This led me to discover the low_latency flag, which 
>>you can set with "setserial /dev/ttyS0 low_latency".  This sets a 
>>special mode on the port, which defeats some kernel-level buffering.  I 
>>don't (yet) know how to set this mode programmatically -- I just call 
>>system("...") from my code (yech!).
> 
> 
> Looking at setserial's sources, something like this:
> 
> struct serial_struct serinfo;
> fd = open ("/dev/ttySxx");
> ioctl (fd, TIOCGSERIAL, &serinfo);
> serinfo.flags |= 0x4000;
> ioctl (fd, TIOCSSERIAL, &serinfo);
> close (fd);
> 
> should do. Of course, not tested and missing all error handling:-(
> 
> MfG, JBG

Thanks for the idea.  Looking into it, I see in 
/usr/include/linux/serial.h, the definition for serial_struct.  The 
comments show these values for the flags member:

/*
  * Definitions for async_struct (and serial_struct) flags field
  */
...
#define ASYNC_LOW_LATENCY 0x2000 /* Request low latency behaviour */
#define ASYNC_BUGGY_UART  0x4000 /* This is a buggy UART, skip some safety
                                   * checks.  Note: can be dangerous! */
...

So, it looks like 0x2000 is the right value -- better, just use 
ASYNC_LOW_LATENCY.

To save some future reader some time, you need:

#include <sys/ioctl.h>
#include <linux/ioctl.h>
#include <linux/serial.h>

I tried it out and it works.  Thanks!


     - Chuck


